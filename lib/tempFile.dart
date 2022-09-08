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
}

class TempStorage {
  //TODO: Change final variable names
  final List<int> listCycle = [
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

  final List<int> listPeriod = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  var _box;
  int _numberRecords = 0;

  void init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    _box = await Hive.openBox('myBox');
    _numberRecords = _box.values.length;
    // await _box.clear();
  }

  bool isInit() {
    if (0 == _numberRecords) {
      return false;
    }
    return true;
  }

  List getListCycles() {
    return _box.values.toList();
  }

  int getNumberRecords() {
    return _numberRecords;
  }

  int getFirstCycleLen() {
    if (0 == _numberRecords) {
      return listCycle[0];
    }

    var firstRecords = _box.get(0);
    int cycleLen = firstRecords['cycleLen'];
    _box.put(0, firstRecords);

    return cycleLen;
  }

  int getFirstPeriodLen() {
    if (0 == _numberRecords) {
      return listPeriod[0];
    }

    var firstRecords = _box.get(0);
    int periodLen = firstRecords['periodLen'];
    _box.put(0, firstRecords);

    return periodLen;
  }

  DateTime getFirstDateStart() {
    if (0 == _numberRecords) {
      return DateTime.now();
    }

    var firstRecords = _box.get(0);
    DateTime dateStart = firstRecords['dateStart'];
    _box.put(0, firstRecords);

    return dateStart;
  }

  void setStartCycleLen(int newCycleLen) async {
    if (0 == _numberRecords) {
      await _box.put(_numberRecords, {
        'cycleLen': newCycleLen,
        'periodLen': listPeriod[0],
        'dateStart': DateTime.now()
      });
      _numberRecords++;
    } else {
      var firstRecords = await _box.get(0);
      firstRecords['cycleLen'] = newCycleLen;
      await _box.put(0, firstRecords);
    }
  }

  void setStartPeriodLen(int newPeriodLen) async {
    if (0 == _numberRecords) {
      await _box.put(_numberRecords, {
        'cycleLen': listCycle[0],
        'periodLen': newPeriodLen,
        'dateStart': DateTime.now()
      });
      _numberRecords++;
    } else {
      var firstRecords = await _box.get(0);
      firstRecords['periodLen'] = newPeriodLen;
      await _box.put(0, firstRecords);
    }
  }

  void setStartDateLastStart(DateTime newDateStart) async {
    if (0 == _numberRecords) {
      await _box.put(_numberRecords, {
        'cycleLen': listCycle[0],
        'periodLen': listPeriod[0],
        'dateStart': newDateStart
      });
      _numberRecords++;
    } else {
      var firstRecords = await _box.get(0);
      firstRecords['dateStart'] = newDateStart;
      await _box.put(0, firstRecords);
    }
  }

  void addNewCycle(Cycle newCycle) async {
    if (0 == _numberRecords) {
      await _box.put(_numberRecords, {
        'cycleLen': newCycle._cycleLen,
        'periodLen': newCycle._periodLen,
        'dateStart': newCycle._dateStart
      });
      _numberRecords++;
      return;
    }

    var lastRecords = await _box.get(_numberRecords - 1);
    DateTime bdateLast = lastRecords['dateStart'];
    Duration blenLastCycle = newCycle._dateStart.difference(bdateLast);

    lastRecords['cycleLen'] = blenLastCycle.inDays;
    await _box.put(_numberRecords - 1, lastRecords);

    await _box.put(_numberRecords, {
      'cycleLen': getMidCycleLen(),
      'periodLen': newCycle._periodLen,
      'dateStart': newCycle._dateStart
    });
    _numberRecords++;
    outputCycles();
  }

//TODO: This functions is for debugging. Then remove.
  void getLenArr() {
    print('number = $_numberRecords');
  }

  void outputCycles() {
    print('numberC = $_numberRecords');
    var v = _box.values.toList();
    print('DB: $v ');
  }

  Tuple2<bool, int> getMenstruation() {
    if (0 == _numberRecords) {
      return const Tuple2<bool, int>(false, 0);
    }

    int daysCycle = getMidCycleLen();
    var lastRecords = _box.get(_numberRecords - 1);

    DateTime lastDate = lastRecords["dateStart"];
    _box.put(_numberRecords - 1, lastRecords);

    DateTime nextDate = lastDate.add(Duration(days: daysCycle));
    Duration dif = nextDate.difference(DateTime.now());

    return Tuple2<bool, int>(true, dif.inDays);
  }

  Tuple2<bool, int> getOvulation() {
    if (0 == _numberRecords) {
      return const Tuple2<bool, int>(false, 0);
    }
    int daysCycle = getMidCycleLen();
    var lastRecords = _box.get(_numberRecords - 1);

    DateTime lastDate = lastRecords["dateStart"];
    _box.put(_numberRecords - 1, lastRecords);

    DateTime ovulationDate = lastDate.add(Duration(days: daysCycle - 14));
    Duration dif = ovulationDate.difference(DateTime.now());

    return Tuple2<bool, int>(true, dif.inDays);
  }

  int getMidCycleLen() {
    if (0 == _numberRecords) {
      return 0;
    }
    if (1 == _numberRecords) {
      var firstRecords = _box.get(0);
      int cycleLen = firstRecords['cycleLen'];
      _box.put(0, firstRecords);
      return cycleLen;
    }
    var arCycles = _box.values.toList();
    num lenCycles = 0;

    for (int i = 0; i < _numberRecords; ++i) {
      var firstRecords = arCycles[i];
      lenCycles += firstRecords['cycleLen'].toInt();
    }

    return lenCycles ~/ _numberRecords;
  }

  int getMidPeriodLen() {
    if (0 == _numberRecords) {
      return 0;
    }
    if (1 == _numberRecords) {
      var firstRecords = _box.get(0);
      int cycleLen = firstRecords['periodLen'];
      _box.put(0, firstRecords);
      return cycleLen;
    }
    var arCycles = _box.values.toList();
    num lenPeriod = 0;

    for (int i = 0; i < _numberRecords; ++i) {
      var firstRecords = arCycles[i];
      lenPeriod += firstRecords['periodLen'].toInt();
    }

    return lenPeriod ~/ _numberRecords;
  }
}

TempStorage tempLoc = TempStorage();
