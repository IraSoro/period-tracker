import 'package:flutter/material.dart';
import 'package:flutter_application/tempFile.dart';

import 'package:tuple/tuple.dart';

import 'tempFile.dart';

class TabHomeWidget extends StatefulWidget {
  const TabHomeWidget({Key? key}) : super(key: key);

  @override
  State<TabHomeWidget> createState() => _TabHomeWidgetState();
}

class _TabHomeWidgetState extends State<TabHomeWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              child: Stack(
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
            ],
          )),
        ],
      ),
    );
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
      child: Container(
        child: Center(
          // alignment: Alignment.center,
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
  Tuple2<bool, int> infPeriod = tempLoc.getMenstruation();
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
            color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
  Tuple2<bool, int> infOvulation = tempLoc.getOvulation();
  @override
  Widget build(BuildContext context) {
    if (!infOvulation.item1) {
      return const Text(
        'Enter settings',
        style: TextStyle(
          fontSize: 30,
          color: Colors.amber,
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
                color: Colors.white,
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
        color: Colors.white,
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

  void _play() async {
    await animationController.forward().orCancel;
    await animationController.reverse().orCancel;
  }

  Widget _output() {
    if (!tempLoc.getMenstruation().item1) {
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
            _play();
          },
        ),
      ),
    ]);
  }
}
