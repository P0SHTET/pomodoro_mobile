import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_mobile/pages/account_page.dart';
import 'package:pomodoro_mobile/pages/home/home_page.dart';
import 'package:pomodoro_mobile/pages/info_page.dart';
import 'package:pomodoro_mobile/server/rest_client.dart';

RestClient? restClient;

void main() {
  final dio = Dio();
  dio.options.baseUrl = 'http://10.0.2.2:3000/';
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
    ),
  );

  restClient = RestClient(dio);

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
      home: const MainWindow(title: 'Pomodoro'),
    );
  }
}

class MainWindow extends StatefulWidget {
  const MainWindow({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
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
