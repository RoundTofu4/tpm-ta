import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'home.dart';
import 'register.dart';
import 'model/user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Box usersBox;
  late Box sessionBox;

  @override
  void initState() {
    super.initState();
    usersBox = Hive.box('usersBox');
    sessionBox = Hive.box('sessionBox');
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String hashedPassword = hashPassword(password);

    User? user = usersBox.get(username);

    if (user != null && user.password == hashedPassword) {
      sessionBox.put('currentUser', username);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login gagal'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username'
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 10,),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
