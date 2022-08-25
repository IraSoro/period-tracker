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
              const Positioned(
                bottom: 320,
                right: 20,
                child: const ButtonPeriodWidget(),
              ),
              const Positioned(
                bottom: 100,
                right: 120,
                child: const ButtonOvulationWidget(),
              ),
              ClipPath(
                  clipper: WaveClipperBottom(),
                  child: Container(
                    color: Colors.deepPurple.shade200,
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
                  width: selected ? 0 : 10, color: Colors.deepPurple.shade200),
              borderRadius: BorderRadius.circular(120),
            ),
            width: 220.0,
            height: 220.0,
            // color: selected ? Colors.red : Colors.blue,
            alignment: Alignment.center,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOutBack,
            child: selected
                ? Text(
                    tempLoc.getOvulation(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    tempLoc.getOvulation(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class ButtonPeriodWidget extends StatefulWidget {
  const ButtonPeriodWidget({Key? key}) : super(key: key);

  @override
  State<ButtonPeriodWidget> createState() => _ButtonPeriodWidgetState();
}

class _ButtonPeriodWidgetState extends State<ButtonPeriodWidget> {
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
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: selected ? Colors.deepPurple : Colors.deepPurple.shade400,
              border: Border.all(
                  width: selected ? 0 : 10, color: Colors.deepPurple.shade200),
              borderRadius: BorderRadius.circular(120),
            ),
            width: 220.0,
            height: 220.0,
            // color: selected ? Colors.red : Colors.blue,
            alignment: Alignment.center,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOutBack,
            child: InfPeriodWidget(),
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
  //TODO: add alignment
  Widget build(BuildContext context) {
    if (!infPeriod.item1) {
      return const Text(
        'Enter settings',
        style: TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      );
    }
    if (infPeriod.item2 < 0) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Text(
              'Period is',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            Text(
              infPeriod.item2.abs().toString(),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.deepOrange,
              ),
            ),
            const Text(
              'days late',
              style: TextStyle(
                fontSize: 10,
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
        child: Column(
          children: [
            const Text(
              'Period in',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Text(
                  infPeriod.item2.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.deepOrange,
                  ),
                ),
                const Text(
                  'Days',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }
    return const Text(
      'Period today',
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
      ),
    );
  }
}
