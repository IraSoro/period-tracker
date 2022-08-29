import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

import 'tempFile.dart';

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
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 0, left: 20, right: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text('Cycle length', textDirection: TextDirection.ltr),
                ),
              ),
              LongDropdownWidget(dropdownValue: tempLoc.MidCycleLen),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 0, left: 20, right: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child:
                      Text('Period length', textDirection: TextDirection.ltr),
                ),
              ),
              ShortDropdownWidget(dropdownValue: tempLoc.MidPeriodLen),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 0.0, left: 20.0, right: 20.0),
                child: DateTimeWidget(selectedDate: tempLoc.dateLastStart),
              ))
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (!(tempLoc.MidCycleLen == 'Choose' ||
                        tempLoc.MidPeriodLen == 'Choose')) {
                      Navigator.popAndPushNamed(context, '/');
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

class LongDropdownWidget extends StatefulWidget {
  String dropdownValue = 'Choose';

  LongDropdownWidget({Key? key, required this.dropdownValue}) : super(key: key);

  @override
  State<LongDropdownWidget> createState() =>
      _LongDropdownWidgetState(this.dropdownValue);
}

class _LongDropdownWidgetState extends State<LongDropdownWidget> {
  String dropdownValue = 'Choose';

  _LongDropdownWidgetState(this.dropdownValue);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          tempLoc.MidCycleLen = dropdownValue;
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

class ShortDropdownWidget extends StatefulWidget {
  String dropdownValue = 'Choose';

  ShortDropdownWidget({Key? key, required this.dropdownValue})
      : super(key: key);

  @override
  State<ShortDropdownWidget> createState() =>
      _ShortDropdownWidgetState(this.dropdownValue);
}

class _ShortDropdownWidgetState extends State<ShortDropdownWidget> {
  String dropdownValue = 'Choose';

  _ShortDropdownWidgetState(this.dropdownValue);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          tempLoc.MidPeriodLen = dropdownValue;
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

class DateTimeWidget extends StatefulWidget {
  DateTime selectedDate = DateTime(2020, 3, 8);

  DateTimeWidget({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<DateTimeWidget> createState() =>
      _DateTimeWidgetState(this.selectedDate);
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  DateTime selectedDate = DateTime(2020, 3, 8);

  _DateTimeWidgetState(this.selectedDate);

  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      initialValue: selectedDate,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.event_note),
        labelText: 'Start of last period',
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      onDateSelected: (DateTime newDate) {
        setState(() {
          selectedDate = newDate;
          tempLoc.dateLastStart = selectedDate;
        });
      },
    );
  }
}
