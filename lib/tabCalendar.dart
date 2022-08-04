import 'package:flutter/material.dart';

class TabCalendarWidget extends StatefulWidget {
  const TabCalendarWidget({Key? key}) : super(key: key);

  @override
  State<TabCalendarWidget> createState() => _TabCalendarWidgetState();
}

class _TabCalendarWidgetState extends State<TabCalendarWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const [
              Text('Calendar'),
            ],
          ),
        ],
      ),
    );
  }
}
