import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/user.dart';
import 'login.dart';

class JobsPage extends StatefulWidget {
  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  late Box usersBox;
  late Box sessionBox;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    usersBox = Hive.box('usersBox');
    sessionBox = Hive.box('sessionBox');

    String currentUsername = sessionBox.get('currentUser');
    currentUser = usersBox.get(currentUsername);
  }

  void _addJobTodo() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController jobController = TextEditingController();
        return AlertDialog(
          title: Text('Add Job Todo'),
          content: TextField(
            controller: jobController,
            decoration: InputDecoration(labelText: 'Job Description'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  currentUser!.jobTodos.add(jobController.text);
                  currentUser!.save();
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _markJobAsDone(int index) {
    setState(() {
      currentUser!.jobTodos.removeAt(index);
      currentUser!.save();
    });
  }

  void _logout() {
    sessionBox.delete('currentUser');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job to do list'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome, ${currentUser?.username}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addJobTodo,
              child: Text('Add Job Todo'),
            ),
            SizedBox(height: 20),
            Text(
              'Your Job Todos:',
              style: TextStyle(fontSize: 16),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentUser?.jobTodos.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(currentUser!.jobTodos[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () => _markJobAsDone(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
