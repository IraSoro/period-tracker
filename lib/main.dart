import 'package:flutter/material.dart';
import 'settings.dart';
import 'tabHome.dart';
import 'tabHistory.dart';
import 'tabNotes.dart';

import 'storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  storage.init();
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
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => MainScreen(),
      '/settings': (BuildContext context) => const SettingsScreen()
    },
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

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
                  child: Text(
                    'home',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'history',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'nodes',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),
            // title: const Text('My apps'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  if (0 == storage.getNumberRecords()) {
                    Navigator.popAndPushNamed(context, '/settings');
                  }
                },
              )
            ],
          ),
          body: const TabBarView(
            children: [
              TabHomeWidget(),
              TabHistoryWidget(),
              TabNotesWidget(),
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
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const InputWidget(),
    );
  }
}
