import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'tempFile.dart';

class TabHistoryWidget extends StatefulWidget {
  const TabHistoryWidget({Key? key}) : super(key: key);

  @override
  State<TabHistoryWidget> createState() => _TabHistoryWidgetState();
}

class _TabHistoryWidgetState extends State<TabHistoryWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Cycle> list = tempLoc.getListCycles();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'AVERAGE',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    color: Color.fromRGBO(179, 157, 219, 1),
                  ),
                ),
              ]),
          SizedBox(
            height: 120,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.deepPurple.shade100,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'CYCLE LENGTH',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            color: Color.fromRGBO(149, 117, 205, 1),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${tempLoc.getMidCycleLen()} DAYS',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(103, 58, 183, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.deepPurple.shade100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'PERIOD LENGTH ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(149, 117, 205, 1),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${tempLoc.getMidPeriodLen()} DAYS',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(103, 58, 183, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'HISTORY',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    color: Color.fromRGBO(179, 157, 219, 1),
                  ),
                ),
              ]),
          SizedBox(
            height: 400,
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                Cycle cycle = list[list.length - 1 - index];
                DateTime startDate = cycle.getDateStart();
                DateTime endDate =
                    startDate.add(Duration(days: cycle.getCycleLen()));

                return Container(
                  height: 50,
                  color: Colors.deepPurple.shade100,
                  child: Center(
                      child: Text(
                          '${DateFormat.MMMd().format(startDate)} - ${DateFormat.MMMd().format(endDate)}')),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
