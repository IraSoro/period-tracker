import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/storage.dart';

import 'package:tuple/tuple.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'storage.dart';

class SelectDate extends InheritedWidget {
  SelectDate({
    super.key,
    required this.selectDate,
    required super.child,
  });

  DateTime selectDate;

  void setSelectDate(DateTime newDate) {
    selectDate = newDate;
  }

  static SelectDate of(BuildContext context) {
    final SelectDate? result =
        context.dependOnInheritedWidgetOfExactType<SelectDate>();
    assert(result != null, 'No SelectDate found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SelectDate old) => selectDate != old.selectDate;
}

class TabHomeWidget extends StatefulWidget {
  const TabHomeWidget({Key? key}) : super(key: key);

  @override
  State<TabHomeWidget> createState() => _TabHomeWidgetState();
}

class _TabHomeWidgetState extends State<TabHomeWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SelectDate(
            selectDate: DateTime.now(),
            child: Builder(builder: (BuildContext innerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 140,
                          color: Colors.deepPurple.shade50,
                        ),
                        Opacity(
                            opacity: 0.5,
                            child: ClipPath(
                                clipper: WaveClipperTop(),
                                child: Container(
                                  color: Colors.deepPurple.shade200,
                                  width: MediaQuery.of(context).size.width,
                                  height: 160,
                                ))),
                        ClipPath(
                            clipper: WaveClipperTop(),
                            child: Container(
                              color: Colors.deepPurple.shade300,
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              alignment: Alignment.center,
                            )),
                        Positioned(
                          bottom: 320,
                          right: 20,
                          child: ButtonPeriodWidget(),
                        ),
                        const Positioned(
                          bottom: 100,
                          right: 120,
                          child: ButtonOvulationWidget(),
                        ),
                        ClipPath(
                            clipper: WaveClipperBottom(),
                            child: Container(
                              color: Colors.deepPurple.shade100,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 160,
                            )),
                        ClipPath(
                            clipper: WaveClipperBottom(),
                            child: Container(
                              color: Colors.deepPurple.shade300,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 140,
                            )),
                        const DatePickerWidget(),
                      ],
                    ),
                  ],
                ),
              );
            })));
  }
}

class WaveClipperTop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height);

    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaveClipperBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.moveTo(size.width, size.height - 140);

    var firstStart = Offset(size.width - size.width / 5, size.height - 140);
    var firstEnd =
        Offset(size.width - size.width / 2.25, size.height - 140 + 50.0);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset((size.width / 3.24), size.height - 140 + 105);
    var secondEnd = Offset(0, size.height - 140 + 10);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ButtonOvulationWidget extends StatefulWidget {
  const ButtonOvulationWidget({Key? key}) : super(key: key);

  @override
  State<ButtonOvulationWidget> createState() => _ButtonOvulationWidgetState();
}

class _ButtonOvulationWidgetState extends State<ButtonOvulationWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: selected ? Colors.deepPurple : Colors.deepPurple.shade400,
            border: Border.all(
                width: selected ? 0 : 10, color: Colors.deepPurple.shade100),
            borderRadius: BorderRadius.circular(120),
          ),
          width: 220.0,
          height: 220.0,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutBack,
          child: InfOvulationWidget(),
        ),
      ),
    );
  }
}

class InfPeriodWidget extends StatefulWidget {
  const InfPeriodWidget({Key? key}) : super(key: key);

  @override
  State<InfPeriodWidget> createState() => _InfPeriodWidgetState();
}

class _InfPeriodWidgetState extends State<InfPeriodWidget> {
  Tuple2<bool, int> infPeriod = storage.getMenstruation();
  @override
  Widget build(BuildContext context) {
    if (!infPeriod.item1) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 60.0),
        child: const Text(
          'Enter settings',
          style: TextStyle(
            fontSize: 30,
            color: Color.fromRGBO(237, 231, 246, 1),
          ),
        ),
      );
    }
    if (infPeriod.item2 < 0) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            const Text(
              'Period is',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(237, 231, 246, 1),
              ),
            ),
            Text(
              infPeriod.item2.abs().toString(),
              style: const TextStyle(
                fontSize: 40,
                color: Color.fromRGBO(160, 196, 196, 1),
              ),
            ),
            const Text(
              'days late',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(237, 231, 246, 1),
              ),
            )
          ],
        ),
      );
    }
    if (infPeriod.item2 > 0) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 55.0),
        child: Column(
          children: [
            const Text(
              'Period in',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(237, 231, 246, 1),
              ),
            ),
            Text(
              '${infPeriod.item2.toString()} Days',
              style: const TextStyle(
                fontSize: 40,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      child: const Text(
        'Period today',
        style: TextStyle(
          fontSize: 30,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}

class InfOvulationWidget extends StatefulWidget {
  const InfOvulationWidget({Key? key}) : super(key: key);

  @override
  State<InfOvulationWidget> createState() => _InfOvulationWidgetState();
}

class _InfOvulationWidgetState extends State<InfOvulationWidget> {
  Tuple2<bool, int> infOvulation = storage.getOvulation();
  @override
  Widget build(BuildContext context) {
    if (!infOvulation.item1) {
      return const Text(
        'Enter settings',
        style: TextStyle(
          fontSize: 30,
          color: Color.fromRGBO(237, 231, 246, 1),
        ),
      );
    }
    if (infOvulation.item2 > 0) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 55.0),
        child: Column(
          children: [
            const Text(
              'Ovulation in',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(237, 231, 246, 1),
              ),
            ),
            Text(
              '${infOvulation.item2.toString()} Days',
              style: const TextStyle(
                fontSize: 40,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      );
    }
    if (infOvulation.item2 == 0) {
      return const Text(
        'Ovulation today',
        style: TextStyle(
          fontSize: 28,
          color: Colors.cyanAccent,
        ),
      );
    }
    return const Text(
      'Temp written',
      style: TextStyle(
        fontSize: 30,
        color: Color.fromRGBO(237, 231, 246, 1),
      ),
    );
  }
}

class ButtonPeriodWidget extends StatefulWidget {
  @override
  _ButtonPeriodWidgetState createState() => _ButtonPeriodWidgetState();
}

class _ButtonPeriodWidgetState extends State<ButtonPeriodWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animationSize;
  late Animation animationColor;
  late Animation animationBorderColor;
  late CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.ease);
    animationSize = Tween(begin: 220.0, end: 230.0).animate(curvedAnimation);
    animationColor =
        ColorTween(begin: Colors.deepPurple.shade400, end: Colors.deepPurple)
            .animate(curvedAnimation);
    animationBorderColor =
        ColorTween(begin: Colors.deepPurple.shade100, end: Colors.deepPurple)
            .animate(curvedAnimation);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void _playAnimation() async {
    await animationController.forward().orCancel;
    await animationController.reverse().orCancel;
  }

  void _addNewCycle(int lenPeriod) {
    if (storage.isInit()) {
      Cycle newCycle =
          Cycle.withParams(1, lenPeriod, SelectDate.of(context).selectDate);
      storage.addNewCycle(newCycle);
    }

    //TODO: This is debugging. Then remove.
    // storage.getLenArr();
    // storage.outputCycles();
  }

  Widget _output() {
    if (!storage.getMenstruation().item1) {
      return Column(
        children: const [
          InfPeriodWidget(),
        ],
      );
    }
    return const InfPeriodWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Container(
              width: animationSize.value,
              height: animationSize.value,
              decoration: BoxDecoration(
                  color: animationColor.value,
                  borderRadius: BorderRadius.circular(120),
                  border: Border.all(
                    width: 10,
                    color: animationBorderColor.value,
                  )),
              child: Center(
                child: _output(),
              ),
            );
          }),
      Positioned(
        bottom: 0,
        right: 0,
        child: ElevatedButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Color.fromRGBO(209, 196, 233, 1),
                  width: 7,
                ),
              ),
              shape: MaterialStateProperty.all(CircleBorder()),
              padding: MaterialStateProperty.all(EdgeInsets.all(30)),
              backgroundColor:
                  MaterialStateProperty.all(Colors.deepPurple.shade400),
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.deepPurple;
              }),
            ),
            child: Column(children: [
              Icon(Icons.domain_verification, color: Colors.deepPurple.shade50),
              const Text(
                "Mark",
                style: TextStyle(
                    fontSize: 10, color: Color.fromRGBO(237, 231, 246, 1)),
              ),
            ]),
            onPressed: () {
              _playAnimation();
              if (storage.isInit()) {
                //TODO: Change Dialog style
                //TODO: Add middle lenght of period when select days
                showDialog<String>(
                  context: context,
                  builder: (BuildContext contextDialog) => SimpleDialog(
                    title: const Text('Select the length of your period'),
                    // TODO: Change numbers to list from storage when new cycle adding
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () {
                          _addNewCycle(storage.listPeriod[0]);
                          Navigator.pop(contextDialog);
                        },
                        child: const Text('1 Days'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          _addNewCycle(storage.listPeriod[1]);
                          Navigator.pop(contextDialog);
                        },
                        child: const Text('2 Days'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          _addNewCycle(storage.listPeriod[2]);
                          Navigator.pop(contextDialog);
                        },
                        child: const Text('3 Days'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          _addNewCycle(storage.listPeriod[3]);
                          Navigator.pop(contextDialog);
                        },
                        child: const Text('4 Days'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          _addNewCycle(storage.listPeriod[4]);
                          Navigator.pop(contextDialog);
                        },
                        child: const Text('5 Days'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          _addNewCycle(storage.listPeriod[5]);
                          Navigator.pop(contextDialog);
                        },
                        child: const Text('6 Days'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          _addNewCycle(storage.listPeriod[6]);
                          Navigator.pop(contextDialog);
                        },
                        child: const Text('7 Days'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          _addNewCycle(storage.listPeriod[7]);
                          Navigator.pop(contextDialog);
                        },
                        child: const Text('8 Days'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          _addNewCycle(storage.listPeriod[8]);
                          Navigator.pop(contextDialog);
                        },
                        child: const Text('9 Days'),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    ]);
  }
}

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key}) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

//TODO: Show the default date on the home screen.
class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
//TODO: Then remove Column widget
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DatePicker(
          DateTime.now().subtract(const Duration(days: 4)),
          initialSelectedDate: DateTime.now(),
          daysCount: 7,
          inactiveDates: [
            DateTime.now().add(const Duration(days: 2)),
            DateTime.now().add(const Duration(days: 1)),
          ],
          monthTextStyle: const TextStyle(
              fontFamily: 'Montserrat',
              color: Color.fromRGBO(209, 196, 233, 1),
              fontSize: 10),
          dateTextStyle: const TextStyle(
              fontFamily: 'MontSerrat',
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(209, 196, 233, 1),
              fontSize: 15),
          dayTextStyle: const TextStyle(
              fontFamily: 'Montserrat',
              color: Color.fromRGBO(209, 196, 233, 1),
              fontSize: 10),
          selectionColor: Colors.deepPurple.shade100,
          selectedTextColor: Colors.deepPurple,
          deactivatedColor: Colors.deepPurple.shade200,
          height: 70,
          width: 50,
          onDateChange: (date) {
            setState(() {
              selectedDate = date;
              SelectDate.of(context).setSelectDate(date);
            });
          },
        ),
      ],
    );
  }
}
