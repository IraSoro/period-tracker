import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            children: const [
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 0, left: 20, right: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text('Длина циклов', textDirection: TextDirection.ltr),
                ),
              ),
              MyStatefulWidget(),
            ],
          ),
          Row(
            children: const [
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 0, left: 20, right: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text('Длина месячных', textDirection: TextDirection.ltr),
                ),
              ),
              //TODO: тут будет другой виджет - как наверху, только с меньшим диапазоном чисел
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
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = '25';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      // icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>[
        '1 ',
        '2 ',
        '3 ',
        '4 ',
        '5 ',
        '6 ',
        '7 ',
        '8 ',
        '9 ',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
        '17',
        '18',
        '19',
        '20',
        '21',
        '22',
        '23',
        '24',
        '25',
        '26',
        '27'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
