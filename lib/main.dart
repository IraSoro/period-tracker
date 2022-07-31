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

class InputWidget extends StatefulWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            children: [
              Expanded(flex: 1, child: const Text('Длина циклов')),
              Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of days';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(flex: 1, child: const Text('Длина месячных')),
              Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of days';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      // Process data.
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // child: Container(
    //   padding: const EdgeInsets.all(20),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Row(
    //         children: [
    //           const Text.rich(
    //             TextSpan(
    //               text: 'Hello', // default text style
    //               children: <TextSpan>[
    //                 TextSpan(
    //                     text: ' beautiful ',
    //                     style: TextStyle(fontStyle: FontStyle.italic)),
    //                 TextSpan(
    //                     text: 'world',
    //                     style: TextStyle(fontWeight: FontWeight.bold)),
    //               ],
    //             ),
    //           ),
    //           TextFormField(
    //             decoration: const InputDecoration(
    //                border: OutlineInputBorder(),
    //              ),
    //             validator: (value) {
    //               if (value == null || value.isEmpty) {
    //                 return 'Please enter number of days';
    //               }
    //               return null;
    //             },
    //           ),
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           TextFormField(
    //             decoration: const InputDecoration(),
    //             validator: (value) {
    //               if (value == null || value.isEmpty) {
    //                 return 'Please enter number of days';
    //               }
    //               return null;
    //             },
    //           ),
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.symmetric(
    //               vertical: 16.0,
    //             ),
    //             child: ElevatedButton(
    //               onPressed: () {
    //                 // Validate will return true if the form is valid, or false if
    //                 // the form is invalid.
    //                 if (_formKey.currentState!.validate()) {
    //                   // Process data.
    //                 }
    //               },
    //               child: const Text('Submit'),
    //             ),
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    // ),
  }
}
