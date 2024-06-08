import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/worker.dart';

class WorkerPage extends StatefulWidget {
  @override
  _WorkerPageState createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  List<Worker> _workers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWorkers();
  }

  Future<void> _fetchWorkers() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/?results=25'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Worker> loadedWorkers = [];
      for (var workerJson in data['results']) {
        loadedWorkers.add(Worker.fromJson(workerJson));
      }
      setState(() {
        _workers = loadedWorkers;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load workers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workers'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _workers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${_workers[index].firstName} ${_workers[index].lastName}'),
            subtitle: Text(_workers[index].email),
          );
        },
      ),
    );
  }
}
