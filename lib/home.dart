import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'jobs.dart';
import 'login.dart';
import 'model/user.dart';
import 'profile.dart';
import 'spareparts.dart';
import 'workers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late Box sessionBox;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    sessionBox = Hive.box('sessionBox');
    String currentUsername = sessionBox.get('currentUser');
    currentUser = Hive.box('usersBox').get(currentUsername);
    setState(() {}); // Trigger a rebuild to update the UI with currentUser
  }

  void _logout() {
    sessionBox.delete('currentUser');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
    );
  }

  void _onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      WelcomePage(currentUser: currentUser, onLogout: _logout), // Pass currentUser and _logout to WelcomePage
      JobsPage(),
      WorkerPage(),
      SparepartPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTappedBar,
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue, //somehow this does not work
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Workers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Spareparts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  final User? currentUser;
  final VoidCallback onLogout;

  WelcomePage({required this.currentUser, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.logout),
        //     onPressed: onLogout,
        //   ),
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Home Page ${currentUser?.username ?? ''}'),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: onLogout,
              child: Text('Logout'),
            ),
          ],
        )
      ),
    );
  }
}
