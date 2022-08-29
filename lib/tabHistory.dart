import 'package:flutter/material.dart';

class TabHistoryWidget extends StatefulWidget {
  const TabHistoryWidget({Key? key}) : super(key: key);

  @override
  State<TabHistoryWidget> createState() => _TabHistoryWidgetState();
}

class _TabHistoryWidgetState extends State<TabHistoryWidget> {
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
              Text('History'),
            ],
          ),
        ],
      ),
    );
  }
}
