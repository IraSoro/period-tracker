import 'package:flutter/material.dart';
// import 'package:dartx/dartx.dart'; TODO: удалить пакет
import 'package:tuple/tuple.dart';

class Cycle {
  int cycleLen = 0;
  int periodLen = 0;
  DateTime dateStart = DateTime.now();
}

class TempStorage {
  String MidCycleLen = 'Choose';
  String MidPeriodLen = 'Choose';
  DateTime dateLastStart = DateTime.now();
  List<Cycle> arCycles = [];

  Tuple2<bool, int> getMenstruation() {
    if (MidCycleLen == 'Choose' || MidPeriodLen == 'Choose') {
      return Tuple2<bool, int>(false, 0);
    }

    int daysCycle = int.parse(MidCycleLen);
    DateTime nextDate = dateLastStart.add(Duration(days: daysCycle));
    Duration dif = nextDate.difference(DateTime.now());

    return Tuple2<bool, int>(true, dif.inDays);
    // if (dif.inDays < 0) {
    //   return 'Period is\n' + dif.inDays.abs().toString() + '\ndays late';
    // } else if (dif.inDays > 0) {
    //   return 'Period in\n' + dif.inDays.toString() + '\nDays';
    // }
    // return 'Period today';
  }

  String getOvulation() {
    if (MidCycleLen == 'Choose' || MidPeriodLen == 'Choose') {
      return 'Enter settings';
    }
    DateTime dateNext;
    int daysCycle = int.parse(MidCycleLen);
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

TempStorage tempLoc = new TempStorage();
