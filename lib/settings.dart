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
              CycleDropdownWidget(dropdownValue: tempLoc.getLastCycleLen()),
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
              PeriodDropdownWidget(dropdownValue: tempLoc.getLastPeriodLen()),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 0.0, left: 20.0, right: 20.0),
                child: DateTimeWidget(selectedDate: tempLoc.getLastDateStart()),
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
                    if (tempLoc.isInit()) {
                      tempLoc.addLastMarkCycle();
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

class CycleDropdownWidget extends StatefulWidget {
  int dropdownValue = 14;

  CycleDropdownWidget({Key? key, required this.dropdownValue})
      : super(key: key);

  @override
  State<CycleDropdownWidget> createState() =>
      _CycleDropdownWidgetState(this.dropdownValue);
}

class _CycleDropdownWidgetState extends State<CycleDropdownWidget> {
  int dropdownValue = 14;

  List<int> list = [
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42
  ];

  _CycleDropdownWidgetState(this.dropdownValue);

  int getLenCycle() {
    if (-1 == dropdownValue) {
      return 14;
    }
    return dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: getLenCycle(),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (int? newValue) {
        setState(() {
          dropdownValue = newValue!;
          tempLoc.setStartCycleLen(dropdownValue);
        });
      },
      items: list.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value'),
        );
      }).toList(),
    );
  }
}

class PeriodDropdownWidget extends StatefulWidget {
  int dropdownValue = 1;

  PeriodDropdownWidget({Key? key, required this.dropdownValue})
      : super(key: key);

  @override
  State<PeriodDropdownWidget> createState() =>
      _PeriodDropdownWidgetState(this.dropdownValue);
}

class _PeriodDropdownWidgetState extends State<PeriodDropdownWidget> {
  int dropdownValue = 1;

  List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  _PeriodDropdownWidgetState(this.dropdownValue);

  int getLenPeriod() {
    if (-1 == dropdownValue) {
      return 1;
    }
    return dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: getLenPeriod(),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (int? newValue) {
        setState(() {
          dropdownValue = newValue!;
          tempLoc.setStartPeriodLen(dropdownValue);
        });
      },
      items: list.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value'),
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
          tempLoc.setStartDateLastStart(selectedDate);
        });
      },
    );
  }
}
