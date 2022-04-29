// ignore_for_file: prefer_const_constructors
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zuno/homeprofile.dart';
import 'package:zuno/profiledetails.dart';
import 'package:zuno/ridehistory.dart';

import 'homePage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MainProfile(),
    RideHistory(),
    MainProfile()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/zunologo.svg"),
                        SizedBox(
                          width: 140,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            padding: EdgeInsets.only(left: 30),
                            child: Icon(
                              Icons.circle,
                              size: 28,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            padding: EdgeInsets.only(left: 30),
                            child: Icon(
                              Icons.notifications_none_sharp,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                preferredSize: Size.fromHeight(15),
              ),
            ),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              unselectedItemColor: Colors.white,

              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.black,
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.time_to_leave,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.black,
                  label: "MyRides",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.access_time_outlined,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.black,
                  label: "RidesHistory",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.black,
                  label: "MyProfile",
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              iconSize: 40,
              onTap: _onItemTapped,
              //   elevation: 5),
            )));
  }
}
