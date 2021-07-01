import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobility_bap_app/widgets/history_card.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = '/history-screen';

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _selectedDate = DateTime.now();

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'History',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: _presentDatePicker,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${DateFormat.MMMMEEEEd().format(_selectedDate)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, count) {
                  return HistoryCard(
                    from: 'Tripunithura Bus Stand',
                    to: 'Model Engineering College',
                    rate: 200,
                    status: 'Confirm',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
