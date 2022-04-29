// ignore_for_file: prefer_const_constructors

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:zuno/vehicledetails.dart';

import 'Home.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  List genders = [
    {"name": "Male", "icon": "assets/Group 13.png"},
    {"name": "Female", "icon": "assets/Group 14.png"},
    {"name": "Others", "icon": "assets/Group 557.png"},
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF0000),
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.arrow_back),
            SizedBox(
              width: 10,
            ),
            Text("Profile Details"),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20),
          children: [
            // Image.asset("assets/Group 16.png"),

            Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 15,
                    child: Row(
                      children: [
                        Text(
                          'Full Name *',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height / 18,
              child: TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: 'John Doe',
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    'Contact Number',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                counterText: '',
                hintText: '8698445503',
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
                contentPadding: EdgeInsets.all(10),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                ),
                prefixIcon: Container(
                  margin: EdgeInsets.fromLTRB(2, 2, 10, 2),
                  color: Colors.grey[300],
                  child: CountryCodePicker(
                    padding: EdgeInsets.only(left: 10, right: 0),
                    initialSelection: '+91',
                    favorite: ['IN', '+91'],
                    showFlag: true,
                    showCountryOnly: true,
                    enabled: false,
                    hideMainText: true,
                  ),
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height / 15,
                child: Row(
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height / 18,
              child: TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: 'iansaunders@xyz.com',
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 20,
              child: Row(
                children: [
                  Text(
                    'Gender *',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Wrap(
                direction: Axis.horizontal,
                children: genders
                    .asMap()
                    .entries
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          print("key:${e.key}");
                          setState(() {
                            selectedIndex = e.key;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          margin: EdgeInsets.only(top: 10, right: 10),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          color: getColor(e),
                          height: 50,
                          child: Row(children: [
                            Image.asset(e.value["icon"]),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              e.value["name"],
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ]),
                        ),
                      ),
                    )
                    .toList()),

            Container(
                // height: MediaQuery.of(context).size.height/48,
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text(
                      'Aadhar Number *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )),
            SizedBox(height: 12),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height / 18,
              child: TextFormField(
                maxLength: 12,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: '4587 3658 6984 2584',
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height / 48,
                child: Row(
                  children: [
                    Text(
                      'State *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )),
            SizedBox(height: 12),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height / 18,
              child: TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    counterText: '',
                    hintText: 'Select One',
                    hintStyle: TextStyle(fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  onTap: () {
                    print("Clicked");
                  }),
            ),
            Container(
                height: MediaQuery.of(context).size.height / 48,
                child: Row(
                  children: [
                    Text(
                      'District *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )),
            SizedBox(height: 12),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height / 18,
              child: TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: 'Select One',
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height / 48,
                child: Row(
                  children: [
                    Text(
                      'City',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )),
            SizedBox(height: 12),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height / 18,
              child: TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: 'Enter Name of City',
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFFF0000)),
              onPressed: () {
                print('Button Clicked');
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Column(
                children: [
                  Text(
                    'Update',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getColor(e) {
    var genderColor = Colors.grey[200];
    if (selectedIndex == 0 && e.value["name"] == "Male") {
      genderColor = Colors.blue;
    }
    if (selectedIndex == 1 && e.value["name"] == "Female") {
      genderColor = Colors.pink;
    }
    if (selectedIndex == 2 && e.value["name"] == "Others") {
      genderColor = Colors.purple;
    }
    return genderColor;
  }
}
