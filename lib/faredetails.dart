// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zuno/profiledetails.dart';
import 'package:zuno/vehicledetails.dart';

class FareDetails extends StatefulWidget {
  const FareDetails({Key? key}) : super(key: key);

  @override
  _FareDetailsState createState() => _FareDetailsState();
}

class _FareDetailsState extends State<FareDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Color(0xFFFF0000),
          bottom: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(right: 20),
              height: 50,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VehicleDetails(),
                          ));
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  Text(
                    'Fare Details',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      'Step 1 of 2',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            preferredSize: Size.fromHeight(15),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: ListView(scrollDirection: Axis.vertical, children: [
            Row(
              children: [
                Text(
                  '  Base Fare*',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 170,
                ),
                Text(
                  ' (Max. ₹ 100)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: 'Enter Base Fare ',
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  prefixIcon: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '\u{20B9}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width / 12,
                    color: Colors.grey[300],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  '  Base Fare KM',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 150,
                ),
                Text(
                  ' (Max. 1.5 KM)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: 'Enter Base Fare KM',
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  prefixIcon: Container(
                    height: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'KM ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width / 12,
                    color: Colors.grey[300],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  '  Amount Per KM',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 150,
                ),
                Text(
                  ' (Max. ₹ 7)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: 'Enter Amount Per KM',
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  prefixIcon: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '\u{20B9}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width / 12,
                    color: Colors.grey[300],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  '  Waiting Charges',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 150,
                ),
                Text(
                  ' (Max. ₹ 2)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: 'Enter Waiting Charges',
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  prefixIcon: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '\u{20B9}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width / 12,
                    color: Colors.grey[300],
                  )),
            ),
            SizedBox(
              height: 150,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFFF0000)),
              onPressed: () {
                print('Button Clicked');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileDetails(),
                    ));
              },
              child: Column(
                children: [
                  Text(
                    'Add Vehicle',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
