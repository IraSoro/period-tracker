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
  late int _startCycleLen;
  late int _startPeriodLen;
  late DateTime _startDateLastStart;

  final _arCycles = List<Cycle>.empty(growable: true);

  TempStorage() {
    _startCycleLen = -1;
    _startPeriodLen = -1;
    _startDateLastStart = DateTime.now();
  }

  bool isInit() {
    if (_startCycleLen == -1 || _startPeriodLen == -1) {
      return false;
    }
    return true;
  }

  int getLastCycleLen() {
    if (_arCycles.isEmpty) {
      return _startCycleLen;
    }
    return _arCycles.last.getCycleLen();
  }

  int getLastPeriodLen() {
    if (_arCycles.isEmpty) {
      return _startPeriodLen;
    }
    return _arCycles.last.getPeriodLen();
  }

  DateTime getLastDateStart() {
    if (_arCycles.isEmpty) {
      return _startDateLastStart;
    }
    return _arCycles.last.getDateStart();
  }

  void setStartCycleLen(int newStartCycleLen) {
    _startCycleLen = newStartCycleLen;
  }

  void setStartPeriodLen(int newStartPeriodLen) {
    _startPeriodLen = newStartPeriodLen;
  }

  void setStartDateLastStart(DateTime newStartDateLastStart) {
    _startDateLastStart = newStartDateLastStart;
  }

  void addNewCycle(Cycle newCycle) {
    _arCycles.add(newCycle);
  }

  void addLastMarkCycle() {
    if (_arCycles.isNotEmpty) {
      _arCycles.last
          .setValues(_startCycleLen, _startPeriodLen, _startDateLastStart);
      return;
    }
    Cycle markCycle =
        Cycle.withParam(_startCycleLen, _startPeriodLen, _startDateLastStart);
    _arCycles.add(markCycle);
  }

//TODO: This function is for debugging. Then remove.
  int getLenArr() {
    return _arCycles.length;
  }

  Tuple2<bool, int> getMenstruation() {
    if (_startCycleLen == -1 || _startPeriodLen == -1) {
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
    if (_startCycleLen == -1 || _startPeriodLen == -1) {
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
