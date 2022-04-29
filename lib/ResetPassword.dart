// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'utils/Validation.dart' as validation;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zuno/otpverification.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class ResetPassword extends StatefulWidget {
  final phoneNumber;
  final resetPassword;
  const ResetPassword({Key? key, this.phoneNumber, this.resetPassword})
      : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var password = true;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();
  bool progressing = false;
  void resetPassword() async {
    if (newPasswordController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter the Password', context);
      return;
    }
    if (newPasswordController.text.length < 8) {
      validation.showValidationErrorMessage(
          'Message', 'Password Should be 8 Characters', context);
      return;
    }
    if (reEnterPasswordController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter the Password', context);
      return;
    }
    if (reEnterPasswordController.text.length < 8) {
      validation.showValidationErrorMessage(
          'Message', 'Password Should be 8 Characters', context);
      return;
    }
    setState(() {
      progressing = true;
    });
    if (newPasswordController.text != reEnterPasswordController.text) {
      print('Button Clicked');
      print(newPasswordController.text);
      print(reEnterPasswordController.text);
      validation.showValidationErrorMessage(
          'Message', 'Invalid credentials', context);
      setState(() {
        progressing = false;
      });

      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    print('Button Clicked');
    print(newPasswordController.text);
    print(reEnterPasswordController.text);
    var jsonObject = {
      "phone": sharedPreferences.getString('tempPhone'),
      "password": newPasswordController.text
    };
    print("the json object ${jsonObject} ");
    var header = {"Content-Type": "application/json"};
    var result = await http.post(
        Uri.parse("https://uatapi.zunocabs.com/public/add-password-on-signup"),
        body: json.encode(jsonObject),
        headers: header);
    setState(() {
      progressing = false;
    });
    print(result.statusCode);
    print(result.body);
    var jsonResult = json.decode(result.body);
    print("The userId is ${jsonResult['userId']}");
    sharedPreferences.setString('token', jsonResult['authToken'].toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF0000),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => OtpVerification()));
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' Reset Password',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 22),
                ),
                Text(
                  'Setup your new password',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width / 8,
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        'New Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width / 7,
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  child: TextFormField(
                    controller: newPasswordController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      counterText: '',
                      hintText: 'Enter New Password',
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
                      ),
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
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    ' Confirm Password',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  child: TextFormField(
                    controller: reEnterPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Re-Enter Password',
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
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                      ),
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: MediaQuery.of(context).size.width / 8,
                  margin:
                      const EdgeInsets.only(right: 10, left: 10, bottom: 20),
                  child: progressing
                      ? Center(child: CircularProgressIndicator())
                      : TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              primary: Colors.white,
                              backgroundColor: Color(0xFFFF0000)),
                          onPressed: () {
                            resetPassword();
                          },
                          child: Text(
                            'Set Password',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
