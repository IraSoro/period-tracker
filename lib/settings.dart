//TODO: Then show this page only on the start screen
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
              CycleDropdownWidget(dropdownCycle: tempLoc.getLastCycleLen()),
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
              PeriodDropdownWidget(dropdownPeriod: tempLoc.getLastPeriodLen()),
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
                      tempLoc.getLenArr();
                      tempLoc.outputCycles();
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
  int dropdownCycle = tempLoc.listCycle[0];

  CycleDropdownWidget({Key? key, required this.dropdownCycle})
      : super(key: key);

  @override
  State<CycleDropdownWidget> createState() =>
      _CycleDropdownWidgetState(this.dropdownCycle);
}

class _CycleDropdownWidgetState extends State<CycleDropdownWidget> {
  int dropdownCycle = tempLoc.listCycle[0];

  _CycleDropdownWidgetState(this.dropdownCycle);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: dropdownCycle,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (int? newValue) {
        setState(() {
          dropdownCycle = newValue!;
          tempLoc.setStartCycleLen(dropdownCycle);
        });
      },
      items: tempLoc.listCycle.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value'),
        );
      }).toList(),
    );
  }
}

class PeriodDropdownWidget extends StatefulWidget {
  int dropdownPeriod = tempLoc.listPeriod[0];

  PeriodDropdownWidget({Key? key, required this.dropdownPeriod})
      : super(key: key);

  @override
  State<PeriodDropdownWidget> createState() =>
      _PeriodDropdownWidgetState(this.dropdownPeriod);
}

class _PeriodDropdownWidgetState extends State<PeriodDropdownWidget> {
  int dropdownPeriod = tempLoc.listPeriod[0];

  _PeriodDropdownWidgetState(this.dropdownPeriod);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: dropdownPeriod,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (int? newValue) {
        setState(() {
          dropdownPeriod = newValue!;
          tempLoc.setStartPeriodLen(dropdownPeriod);
        });
      },
      items: tempLoc.listPeriod.map<DropdownMenuItem<int>>((int value) {
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
