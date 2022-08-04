import 'package:flutter/material.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
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
              LongStatefulWidget(),
            ],
          ),
          Row(
            children: const [
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 0, left: 20, right: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child:
                      Text('Длина месячных', textDirection: TextDirection.ltr),
                ),
              ),
              ShortStatefulWidget(),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {},
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

class LongStatefulWidget extends StatefulWidget {
  const LongStatefulWidget({Key? key}) : super(key: key);

  @override
  State<LongStatefulWidget> createState() => _LongStatefulWidgetState();
}

class _LongStatefulWidgetState extends State<LongStatefulWidget> {
  String dropdownValue = 'Choose';

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
        'Choose',
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
        '27',
        '28',
        '29',
        '30',
        '31',
        '32',
        '33',
        '34',
        '35',
        '36',
        '37',
        '38',
        '39',
        '40',
        '41',
        '42'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class ShortStatefulWidget extends StatefulWidget {
  const ShortStatefulWidget({Key? key}) : super(key: key);

  @override
  State<ShortStatefulWidget> createState() => _ShortStatefulWidgetState();
}

class _ShortStatefulWidgetState extends State<ShortStatefulWidget> {
  String dropdownValue = 'Choose';

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
        'Choose',
        '1 ',
        '2 ',
        '3 ',
        '4 ',
        '5 ',
        '6 ',
        '7 ',
        '8 ',
        '9 '
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
