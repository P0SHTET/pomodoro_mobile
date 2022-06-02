import 'package:flutter/material.dart';
import 'package:pomodoro_mobile/account_page.dart';
import 'package:pomodoro_mobile/home_page.dart';
import 'package:pomodoro_mobile/info_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Pomodoro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  final List<Widget> _widgetOptions = const [
    AccountPage(),
    HomePage(),
    InfoPage(),
  ];

  void _onNavigationItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          )
        ],
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        currentIndex: _selectedIndex,
        onTap: _onNavigationItemTapped,
      ),
    );
  }
}
