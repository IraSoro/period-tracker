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
          Row(
            children: [
              Container(
                  child: Stack(children: [
                Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          color: Colors.deepPurple.shade200,
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                        ))),
                ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Colors.deepPurple.shade300,
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      alignment: Alignment.center,
                      child: Text(
                        tempLoc.getTotalInf(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ))
              ]))
            ],
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
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
