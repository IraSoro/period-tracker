import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => const MainScreen(),
      '/settings': (BuildContext context) => const SettingsScreen()
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
    ),
  ));
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'home',
                ),
                Tab(
                  text: 'calendar',
                ),
                Tab(text: 'notes'),
              ],
            ),
            title: const Text('My apps'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              )
            ],
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.home),
              Icon(Icons.calendar_month),
              Icon(Icons.note),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
    );
  }
}
