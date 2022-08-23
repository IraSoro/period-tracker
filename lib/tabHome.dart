import 'package:flutter/material.dart';
import 'package:flutter_application/tempFile.dart';

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
                child: const MyStatefulWidget(),
              ),
              const Positioned(
                bottom: 100,
                right: 120,
                child: const MyStatefulWidget(),
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

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
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
            alignment:
                selected ? Alignment.center : AlignmentDirectional.topCenter,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOutBack,
            child: Text(
              tempLoc.getTotalInf(),
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
