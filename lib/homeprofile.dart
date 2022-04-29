// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zuno/main.dart';
import 'package:zuno/personalDetails.dart';
import 'package:zuno/vehicledetails.dart';

import 'loginPage.dart';

class MainProfile extends StatefulWidget {
  const MainProfile({Key? key}) : super(key: key);

  @override
  State<MainProfile> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  void clearToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  void redeemNow() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        enableDrag: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 70),
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter UPI ID',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainProfile()));
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter valid UPI ID',
                        hintStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color(0xFFFF0000),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Verify',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
        elevation: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 30, 15, 20),
                height: 213,
                decoration: BoxDecoration(
                    color: Color(0xFFFF0000),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'lan Saunders',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '+91 8623453456',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'lansaunders@xyz.com',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    color: Colors.red,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                )),
                            Positioned(
                              top: 37,
                              left: 37,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: Color(0xFFFF0000),
                                    )),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 13,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/awardzuno.svg",
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '100',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Points Redeemed',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/gift.svg"),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '50',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Yet to Redeemed',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 60,
                          ),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Color(0xFF020202),
                                minimumSize: Size(113, 30),
                              ),
                              onPressed: redeemNow,
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/pocket.svg"),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Redeem Now',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                color: Colors.grey[100],
                padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            'Journey Status',
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'Montserrat,'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 1.90,
                            left: 130,
                          ),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                elevation: 4,
                                padding: EdgeInsets.only(right: 0, left: 2),
                                alignment: Alignment.centerLeft,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                backgroundColor: Color(0xFFFFFFFF),
                                minimumSize: Size(50, 20),
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.circle,
                                size: 28,
                                color: Color(0xFFAAAAAA),
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Currently no cab is activated',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFAAAAAA),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 33,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonalDetails()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile Details',
                      style: TextStyle(fontSize: 14),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VehicleDetails()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My vehicles',
                      style: TextStyle(fontSize: 14),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Benefits',
                    style: TextStyle(fontSize: 14),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                  clearToken();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(fontSize: 14),
                    ),
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 15),
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.5,
                          spreadRadius: 0.4),
                    ],
                    border: Border.all(width: 1, color: Color(0xFFAAAAAA80))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invite Your friends to Cuno Cabs',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Invite Your friends to Zuno Cabs and get Rewards point when your friend Completes their first ride ',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Zu7Ac',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 8, 16, 8),
                          margin: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  width: 2, color: Color(0xffAAAAAA))),
                          child: Row(
                            children: [
                              Icon(Icons.copy),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Copy Code',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 49),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Color(0xFFFF0000),
                                  minimumSize: Size(163, 40),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Invite as Driver',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Color(0xFF020202),
                                  minimumSize: Size(163, 40),
                                ),
                                child: Text(
                                  'Invite as Users',
                                  style: TextStyle(fontSize: 14),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
