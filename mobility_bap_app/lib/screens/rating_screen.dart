import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'home_screen.dart';

class RatingScreen extends StatelessWidget {
  static const routeName = '/rating-screen';
  const RatingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(14, 50, 10, 0),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.white,
                ),
                Spacer(),
                Text(
                  'Rating',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {}, //Not for usage
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  color: Theme.of(context).primaryColor,
                ),
                //Second IconButton for centering text only
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
                padding: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 25), //Radius of circle
                    Text(
                      'Rajesh K R',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    Text('Cochin Taxi Service'),
                    Text(
                      'How is your trip?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Column(
                        children: [
                          Text('Your feedback will help improve'),
                          Text('driving experience'),
                        ],
                      ),
                    ),
                    RatingBar.builder(
                      glow: false,
                      initialRating: 3,
                      minRating: 1,
                      itemCount: 5,
                      unratedColor: Colors.grey,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xFFEFEFF4).withOpacity(0.5),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Additional comments...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          //Implement code for Ratings
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            HomeScreen.routeName,
                            (_) => false,
                          );
                        },
                        child: Text('Submit Review'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF4252FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: MediaQuery.of(context).size.width / 2 - 40 - 8,
                //DeviceWidth - Margin of container - Padding
                child: CircleAvatar(
                  radius: 50,
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
