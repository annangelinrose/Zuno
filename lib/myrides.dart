import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRides extends StatefulWidget {
  const MyRides({Key? key}) : super(key: key);

  @override
  _MyRidesState createState() => _MyRidesState();
}

class _MyRidesState extends State<MyRides> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              height: MediaQuery.of(context).size.height / 15,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFFF0000),
                ), //
                onPressed: () {
                  print('Button Clicked');
                },
                child: Text(
                  'Current Rides',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(width: 30),
            Container(
              margin: EdgeInsets.only(top: 100),
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Color(0xFFFFFFFF)),
                onPressed: () {
                  print('Button Clicked');
                },
                child: Text(
                  'Find Rides ',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
