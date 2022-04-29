// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'utils/Validation.dart' as validation;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zuno/profiledetails.dart';
import 'package:zuno/verification.dart';
import 'package:http/http.dart' as http;

class SetPassword extends StatefulWidget {
  final phoneNumberVerification;
  const SetPassword({Key? key, this.phoneNumberVerification}) : super(key: key);

  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newReEnterPasswordController = TextEditingController();
  var password = true;
  bool progressing = false;

  void setPassword() async {
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
    if (newReEnterPasswordController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter the Password', context);
      return;
    }
    if (newReEnterPasswordController.text.length < 8) {
      validation.showValidationErrorMessage(
          'Message', 'Password Should be 8 Characters', context);
      return;
    }
    setState(() {
      progressing = true;
    });
    print(newPasswordController.text);
    print(newReEnterPasswordController.text);
    if (newPasswordController.text != newReEnterPasswordController.text) {
      validation.showValidationErrorMessage(
          'Message', 'invalid credentials', context);
      setState(() {
        progressing = false;
      });
      return;
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonData = {
      "phone": sharedPreferences.getString('tempPhone'),
      "password": newPasswordController.text
    };
    print(widget.phoneNumberVerification);
    var header = {'Content-Type': 'application/json'};
    var Result = await http.post(
        Uri.parse('https://uatapi.zunocabs.com/public/add-password-on-signup'),
        body: json.encode(jsonData),
        headers: header);

    var jsonResult = json.decode(Result.body);
    print(jsonResult['message']);
    sharedPreferences.setString(
        'token', jsonResult['content']['authToken'].toString());
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileDetails()));
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
                MaterialPageRoute(builder: (context) => Verification()));
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
                  ' Set Password',
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
                  margin: EdgeInsets.only(left: 20),
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
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  child: TextFormField(
                    controller: newPasswordController,
                    maxLength: 20,
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
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    ' Confirm Password',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  child: TextFormField(
                    controller: newReEnterPasswordController,
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
                      const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  child: progressing
                      ? Center(child: CircularProgressIndicator())
                      : TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              primary: Colors.white,
                              backgroundColor: Color(0xFFFF0000)),
                          onPressed: () {
                            print('Button Clicked');
                            setPassword();
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
