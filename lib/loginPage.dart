// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'utils/Validation.dart' as validation;

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zuno/verification.dart';

import 'Home.dart';
import 'forgetpassword.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var password = true;
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController newPhoneNumberController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  bool progressing = false;

  void login() async {
    if (phoneNumberController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter Mobile Number', context);
      return;
    }
    if (phoneNumberController.text.length < 10) {
      validation.showValidationErrorMessage(
          'Message', 'Enter the Valid Mobile Number', context);
      return;
    }
    if (loginPasswordController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'MESSAGE', 'Enter the Password', context);
      return;
    }
    if (loginPasswordController.text.length < 10) {
      validation.showValidationErrorMessage(
          'Message', 'Enter the Valid Mobile Number', context);
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      progressing = true;
    });
    print('Button Clicked');
    print(phoneNumberController.text);
    print(loginPasswordController.text);
    var jsonObject = {
      "phone": phoneNumberController.text,
      "password": loginPasswordController.text
    };
    print("the json object ${jsonObject} ");
    var header = {"Content-Type": "application/json"};
    var result = await http.post(Uri.parse("https://uatapi.zunocabs.com/login"),
        body: json.encode(jsonObject), headers: header);
    setState(() {
      progressing = false;
    });
    print(result.statusCode);
    print(result.body);
    var jsonResult = json.decode(result.body);
    print("My Full Name is ${jsonResult['fullName']}");
    sharedPreferences.setString("token", jsonResult["token"].toString());
    if (jsonResult['userId'] != null && jsonResult['roles'][0] == "DRIVER") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Invalid Credentials",
            textAlign: TextAlign.center,
          )));
    }
  }

  void signUp() async {
    if (newPhoneNumberController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter the Mobile Number', context);
      return;
    }
    if (newPhoneNumberController.text.length < 10) {
      validation.showValidationErrorMessage(
          'Message', 'Enter the Valid Mobile Number', context);
      return;
    }

    setState(() {
      progressing = true;
    });
    var jsonData = {
      "countryCode": "+91",
      "phone": newPhoneNumberController.text,
      "referralCode": referralCodeController.text
    };

    var header = {'Content-Type': 'application/json'};
    var Result = await http.post(
        Uri.parse('https://uatapi.zunocabs.com/public/driver/signup'),
        body: json.encode(jsonData),
        headers: header);
    setState(() {
      progressing = false;
    });
    var jsonResult = json.decode(Result.body);
    print(jsonResult);
    if (jsonResult['code'] == 0 && jsonResult['content'] != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Verification(
              otpVerification: jsonResult['content'],
              phoneNumberVerification: newPhoneNumberController.text,
            ),
          ));
    } else {
      print(jsonResult['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.network(
                "https://cdn.pixabay.com/photo/2014/03/22/17/03/the-background-292729_960_720.png",
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 375,
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(20, 200, 20, 20),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(1, 1),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ]),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          labelPadding: EdgeInsets.only(top: 20),
                          labelColor: Color(0xFF020202),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          indicatorColor: Color(0xFfFF0000),
                          indicatorWeight: 6,
                          indicatorPadding:
                              EdgeInsets.only(left: 66, right: 66),
                          tabs: [
                            Tab(
                              text: 'Sign Up',
                            ),
                            Tab(
                              text: 'Sign In',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 30, right: 20, left: 20, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Mobile Number',
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
                                      controller: newPhoneNumberController,
                                      maxLength: 10,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        counterText: '',
                                        hintText: 'Enter Mobile Number',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 2.0),
                                        ),
                                        prefixIcon: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(2, 2, 10, 2),
                                          color: Colors.grey[300],
                                          child: CountryCodePicker(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 0),
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
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Referral Code(Optional)',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: referralCodeController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter Referral Code',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 2.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    progressing
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : TextButton(
                                            style: TextButton.styleFrom(
                                              primary: Colors.white,
                                              backgroundColor:
                                                  Color(0xFFFF0000),
                                              minimumSize:
                                                  Size(double.infinity, 50),
                                            ),
                                            onPressed: () {
                                              print('clicked');
                                              signUp();
                                            },
                                            child: Text(
                                              'Sign Up',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'By Clicking Sign Up,You agree to our Terms & Condition',
                                      style: TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              padding: EdgeInsets.only(
                                  top: 30, right: 20, left: 20, bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mobile Number',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: phoneNumberController,
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      counterText: '',
                                      hintText: 'Enter Mobile Number',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2.0),
                                      ),
                                      prefixIcon: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(2, 2, 10, 2),
                                        color: Colors.grey[300],
                                        child: CountryCodePicker(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 0),
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Password',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: loginPasswordController,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black)),
                                        hintText: 'Enter New Password',
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.all(10),
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                        ),
                                        suffixIcon: IconButton(
                                          color: Colors.grey,
                                          icon: Icon(password
                                              ? Icons.remove_red_eye_outlined
                                              : Icons.visibility_off_outlined),
                                          onPressed: () {
                                            setState(() {
                                              password = !password;
                                            });
                                          },
                                        )),
                                    obscureText: password,
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  progressing
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : TextButton(
                                          style: TextButton.styleFrom(
                                              minimumSize:
                                                  Size(double.infinity, 50),
                                              primary: Colors.white,
                                              backgroundColor:
                                                  Color(0xFFFF0000)),
                                          onPressed: () {
                                            login();
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                'Sign In',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Color(0xFFFF0000),
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPassword(),
                          ));
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
