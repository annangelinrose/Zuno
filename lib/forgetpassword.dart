// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'utils/Validation.dart' as validation;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'otpverification.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController mobileNumberController = TextEditingController();

  bool progressing = false;
  void otp() async {
    if (mobileNumberController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter the Mobile Number', context);
      return;
    }
    if (mobileNumberController.text.length < 10) {
      validation.showValidationErrorMessage(
          'Message', 'Enter the Valid Mobile Number', context);
      return;
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      progressing = true;
    });
    print('Button Clicked');
    print(mobileNumberController.text);
    var jsonObject = {
      "countryCode": "+91",
      "phone": mobileNumberController.text,
    };
    print("the json object ${jsonObject} ");
    var header = {"Content-Type": "application/json"};
    var result = await http.post(
        Uri.parse(
            "https://uatapi.zunocabs.com/public/resend-otp?forgotPassword=2"),
        body: json.encode(jsonObject),
        headers: header);
    setState(() {
      progressing = false;
    });
    print(result.statusCode);
    print(result.body);
    var jsonResult = json.decode(result.body);
    print(jsonResult['message']);

    if (jsonResult['code'] == 100) {
      sharedPreferences.setString("tempPhone", mobileNumberController.text);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpVerification(
                    otp: jsonResult['content'],
                    phoneNumber: mobileNumberController.text,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFF0000),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: Container(
              height: 90,
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 22),
                  ),
                  Text(
                    'Verify your Registered mobile number to reset password',
                    style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobile Number',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: mobileNumberController,
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
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
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
                SizedBox(
                  height: 50,
                ),
                progressing
                    ? Center(child: CircularProgressIndicator())
                    : TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color(0xFFFF0000),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          otp();
                        },
                        child: Text(
                          'Get OTP',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
