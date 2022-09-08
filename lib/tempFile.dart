import 'package:tuple/tuple.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


class Cycle {
  int _cycleLen = 0;
  int _periodLen = 0;
  DateTime _dateStart = DateTime.now();

  Cycle.withParams(int newCycleLen, int newPeriodLen, DateTime newDateStart) {
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
  List<int> listCycle = [
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

  List<int> listPeriod = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  final _arCycles = List<Cycle>.empty(growable: true);

  var box;

  void init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    box = await Hive.openBox('myBox');
    // await box.clear();
    box.put('1', 'David');
    box.put('3', 'Ira');

    // var name = box.get('name');

    var v = box.values.toList();
    // var v1 = box.values.length;

    print('Name: $v  len = ${v.length}');

    // print(box.gestAt(0));
  }

  bool isInit() {
    if (_arCycles.isEmpty) {
      return false;
    }
    return true;
  }

  List<Cycle> getListCycles() {
    return _arCycles;
  }

  int getLastCycleLen() {
    if (_arCycles.isEmpty) {
      return listCycle[0];
    }

    return _arCycles[0].getCycleLen();
  }

  int getLastPeriodLen() {
    if (_arCycles.isEmpty) {
      return 1;
    }
    return _arCycles[0].getPeriodLen();
  }

  DateTime getLastDateStart() {
    if (_arCycles.isEmpty) {
      return DateTime.now();
    }
    return _arCycles[0].getDateStart();
  }

  void setStartCycleLen(int newCycleLen) {
    if (_arCycles.isEmpty) {
      //TODO: change adding to one line ???
      Cycle newCycle =
          Cycle.withParams(newCycleLen, listPeriod[0], DateTime.now());
      _arCycles.add(newCycle);
    } else {
      _arCycles[0].setCycleLen(newCycleLen);
    }
  }

  void setStartPeriodLen(int newPeriodLen) {
    if (_arCycles.isEmpty) {
      //TODO: change adding to one line ???
      Cycle newCycle =
          Cycle.withParams(listCycle[0], newPeriodLen, DateTime.now());
      _arCycles.add(newCycle);
    } else {
      _arCycles[0].setPeriodLen(newPeriodLen);
    }
  }

  void setStartDateLastStart(DateTime newDateStart) {
    if (_arCycles.isEmpty) {
      //TODO: change adding to one line
      Cycle newCycle =
          Cycle.withParams(listCycle[0], listPeriod[0], newDateStart);
      _arCycles.add(newCycle);
    } else {
      _arCycles[0].setDateStart(newDateStart);
    }
  }

  void addNewCycle(Cycle newCycle) {
    if (_arCycles.isEmpty) {
      _arCycles.add(newCycle);
      return;
    }
    DateTime dateLast = _arCycles.last.getDateStart();
    Duration lenLastCycle = newCycle.getDateStart().difference(dateLast);
    _arCycles.last.setCycleLen(lenLastCycle.inDays);

    newCycle.setCycleLen(getMidCycleLen());
    _arCycles.add(newCycle);
  }

//TODO: This functions is for debugging. Then remove.
  void getLenArr() {
    print('len = ${_arCycles.length}');
  }

  void outputCycles() {
    for (int i = 0; i <= _arCycles.length - 1; i++) {
      print(
          "$i) lenCycle = ${_arCycles[i].getCycleLen()}  lenPeriod = ${_arCycles[i].getPeriodLen()}  data = ${_arCycles[i].getDateStart().toString()}\n");
    }
  }

  Tuple2<bool, int> getMenstruation() {
    if (_arCycles.isEmpty) {
      return const Tuple2<bool, int>(false, 0);
    }
    Cycle lastCycle = _arCycles.last;

    int daysCycle = getMidCycleLen();
    print('period = $daysCycle');
    DateTime lastDate = lastCycle.getDateStart();
    DateTime nextDate = lastDate.add(Duration(days: daysCycle));
    Duration dif = nextDate.difference(DateTime.now());

    return Tuple2<bool, int>(true, dif.inDays);
  }

  Tuple2<bool, int> getOvulation() {
    if (_arCycles.isEmpty) {
      return const Tuple2<bool, int>(false, 0);
    }
    Cycle lastCycle = _arCycles.last;

    int daysCycle = getMidCycleLen();
    DateTime lastDate = lastCycle.getDateStart();
    DateTime ovulationDate = lastDate.add(Duration(days: daysCycle - 14));
    Duration dif = ovulationDate.difference(DateTime.now());

    return Tuple2<bool, int>(true, dif.inDays);
  }

  int getMidCycleLen() {
    if (_arCycles.isEmpty) {
      return 0;
    }
    if (1 == _arCycles.length) {
      return _arCycles[0].getCycleLen();
    }
    int lenCycles = 0;
    for (Cycle cycle in _arCycles) {
      lenCycles += cycle.getCycleLen();
    }

    return lenCycles ~/ _arCycles.length;
  }

  int getMidPeriodLen() {
    if (_arCycles.isEmpty) {
      return 0;
    }
    if (1 == _arCycles.length) {
      return _arCycles[0].getPeriodLen();
    }
    int lenPeriod = 0;
    for (Cycle cycle in _arCycles) {
      lenPeriod += cycle.getPeriodLen();
    }

    return lenPeriod ~/ _arCycles.length;
  }

  int getPeriodDay(DateTime dateNow) {
    for (Cycle cycle in _arCycles) {
      DateTime startDate = cycle.getDateStart();
      DateTime endDate = startDate.add(Duration(days: cycle.getPeriodLen()));
      if (startDate.isBefore(dateNow) || endDate.isAfter(dateNow)) {
        Duration dif = startDate.difference(dateNow);
        return dif.inDays;
      }
    }
    return -1;
  }
}

TempStorage tempLoc = TempStorage();
