import 'package:flutter/material.dart';
import 'settings.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.deepPurple,
      ),
      textTheme:
          const TextTheme(bodyText2: TextStyle(color: Colors.deepPurple)),
      scaffoldBackgroundColor: Colors.deepPurple[50],
    ),
    //TODO:оформить темную тему
    // darkTheme: ThemeData.dark(),
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => const MainScreen(),
      '/settings': (BuildContext context) => const SettingsScreen()
    },
  ));
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
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
                  Navigator.pushNamed(context, '/settings');
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
      body: const InputWidget(),
    );
  }
}
