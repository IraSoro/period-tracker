import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Cycle {
  int _cycleLen = 0;
  int _periodLen = 0;
  DateTime _dateStart = DateTime.now();

  Cycle.undefined() {
    _cycleLen = 0;
    _periodLen = 0;
    _dateStart = DateTime.now();
  }

  Cycle.withParam(int newCycleLen, int newPeriodLen, DateTime newDateStart) {
    _cycleLen = newCycleLen;
    _periodLen = newPeriodLen;
    _dateStart = newDateStart;
  }

  int getCycleLen() {
    return _cycleLen;
  }

  int getPeriodLen() {
    return _periodLen;
  }

  DateTime getDateStart() {
    return _dateStart;
  }

  setValues(int newCycleLen, int newPeriodLen, DateTime newDateStart) {
    _cycleLen = newCycleLen;
    _periodLen = newPeriodLen;
    _dateStart = newDateStart;
  }

  void setCycleLen(int newCycleLen) {
    _cycleLen = newCycleLen;
  }

  void setPeriodLen(int newPeriodLen) {
    _periodLen = newPeriodLen;
  }

  void setDateStart(DateTime newDateStart) {
    _dateStart = newDateStart;
  }
}

class TempStorage {
  late String _middleCycleLen;
  late String _middlePeriodLen;
  late DateTime _dateLastStart;
  final _arCycles = List<Cycle>.empty(growable: true);

  TempStorage() {
    _middleCycleLen = 'Choose';
    _middlePeriodLen = 'Choose';
    _dateLastStart = DateTime.now();
  }

  bool isInit() {
    if (tempLoc._middleCycleLen == 'Choose' ||
        tempLoc._middlePeriodLen == 'Choose') {
      return false;
    }
    return true;
  }

  String getMiddleCycleLen() {
    return _middleCycleLen;
  }

  String getMiddlePeriodLen() {
    return _middlePeriodLen;
  }

  DateTime getDateLastStart() {
    return _dateLastStart;
  }

  void setMiddleCycleLen(String newMiddleCycleLen) {
    _middleCycleLen = newMiddleCycleLen;
  }

  void setMiddlePeriodLen(String newMiddlePeriodLen) {
    _middlePeriodLen = newMiddlePeriodLen;
  }

  void setDateLastStart(DateTime newDateLastStart) {
    _dateLastStart = newDateLastStart;
  }

  void addNewCycle(Cycle lastCycle) {
    _arCycles.add(lastCycle);
  }

  void addLastMarkCycle() {
    if (_arCycles.isNotEmpty) {
      _arCycles.last.setValues(int.parse(_middleCycleLen),
          int.parse(_middlePeriodLen), _dateLastStart);
      return;
    }
    Cycle markCycle = Cycle.withParam(int.parse(_middleCycleLen),
        int.parse(_middlePeriodLen), _dateLastStart);
    _arCycles.add(markCycle);
  }
//TODO: This function is for debugging. Then remove.
  int getLenArr(){
    return _arCycles.length;
  }

  Tuple2<bool, int> getMenstruation() {
    if (_middleCycleLen == 'Choose' || _middlePeriodLen == 'Choose') {
      return const Tuple2<bool, int>(false, 0);
    }
    Cycle lastCycle = _arCycles.last;

    int daysCycle = lastCycle.getCycleLen();
    DateTime lastDate = lastCycle.getDateStart();
    DateTime nextDate = lastDate.add(Duration(days: daysCycle));
    Duration dif = nextDate.difference(DateTime.now());

    return Tuple2<bool, int>(true, dif.inDays);
  }

  Tuple2<bool, int> getOvulation() {
    if (_middleCycleLen == 'Choose' || _middlePeriodLen == 'Choose') {
      return const Tuple2<bool, int>(false, 0);
    }
    Cycle lastCycle = _arCycles.last;

    int daysCycle = lastCycle.getCycleLen();
    DateTime lastDate = lastCycle.getDateStart();
    DateTime ovulationDate = lastDate.add(Duration(days: daysCycle - 14));
    Duration dif = ovulationDate.difference(DateTime.now());

    return Tuple2<bool, int>(true, dif.inDays);
  }
}

TempStorage tempLoc = new TempStorage();
