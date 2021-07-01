import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.from,
    required this.to,
    required this.rate,
    required this.status,
  }) : super(key: key);

  final String from;
  final String to;
  final double rate;
  final String status;

  Color statusColor() {
    if (status == 'Confirm') {
      return Color(0xFF4252FF);
    } else if (status == 'Completed') {
      return Color(0xFF03DE73);
    } else
      return Color(0xFFC8C7CC);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 15,
      margin: EdgeInsets.all(15),
      child: Container(
        margin: EdgeInsets.all(7),
        width: MediaQuery.of(context).size.width - 44,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 5),
                Container(
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Stack(
                        children: [
                          Image(
                            image: AssetImage("assets/images/green_loc.png"),
                            width: 24,
                          ),
                          Positioned(
                            top: 7,
                            left: 7,
                            child: CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              radius: 5,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 0,
                        width: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                        width: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0xffc8c7cc)),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                        width: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                        width: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0xffc8c7cc)),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                        width: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                        width: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0xffc8c7cc)),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                        width: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      ),
                      Image(
                        image: AssetImage("assets/images/red_loc.png"),
                        width: 24,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                Container(
                  height: 74,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        from,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Spacer(),
                      Text(
                        to,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(thickness: 1),
            Row(
              children: [
                Text(
                  'Rs ${rate.toString()}',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Spacer(),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor(),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
