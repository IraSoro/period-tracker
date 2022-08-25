import 'package:flutter/material.dart';
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
  }

  Tuple2<bool, int> getOvulation() {
    if (MidCycleLen == 'Choose' || MidPeriodLen == 'Choose') {
      return Tuple2<bool, int>(false, 0);
    }

    int daysCycle = int.parse(MidCycleLen);
    DateTime ovulationDate = dateLastStart.add(Duration(days: daysCycle - 14));

    Duration dif = ovulationDate.difference(DateTime.now());

    return Tuple2<bool, int>(true, dif.inDays);
  }
}

TempStorage tempLoc = new TempStorage();
