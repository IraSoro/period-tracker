import 'package:flutter/material.dart';

void main() {
  runApp(const TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

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
