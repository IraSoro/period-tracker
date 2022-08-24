import 'package:flutter/material.dart';

class TempValue {
  String cycleLen = 'Choose';
  String periodLen = 'Choose';
  DateTime dateLastStart = DateTime.now();

  String getTotalInf() {
    return "Длина циклов " +
        cycleLen +
        " дней\nДлина месячных " +
        periodLen +
        " дней\nНачало последней менструации " +
        dateLastStart.toString();
  }

  String getMenstruation() {
    if (cycleLen == 'Choose' || periodLen == 'Choose') {
      return 'Enter settings';
    }
    DateTime dateNext;
    int daysCycle = int.parse(cycleLen);
    DateTime nextDate = dateLastStart.add(Duration(days: daysCycle));
    Duration dif = nextDate.difference(DateTime.now());
    if (dif.inDays < 0) {
      return 'Period is\n' + dif.inDays.abs().toString() + '\ndays late';
    } else if (dif.inDays > 0) {
      return 'Period in\n' + dif.inDays.toString() + '\nDays';
    }
    return 'Period today';
  }

  String getOvulation() {
    if (cycleLen == 'Choose' || periodLen == 'Choose') {
      return 'Enter settings';
    }
    DateTime dateNext;
    int daysCycle = int.parse(cycleLen);
    DateTime OvulationDate = dateLastStart.add(Duration(days: daysCycle - 14));

    Duration dif = OvulationDate.difference(DateTime.now());
    if (dif.inDays < 0) {
      return 'Ovulation is\n' + dif.inDays.abs().toString() + '\ndays late';
    } else if (dif.inDays > 0) {
      return 'Ovulation in\n' + dif.inDays.toString() + '\nDays';
    }
    return 'Ovulation today';
  }
}

TempValue tempLoc = new TempValue();
