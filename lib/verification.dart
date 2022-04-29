import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zuno/setpassword.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class Verification extends StatefulWidget {
  final otpVerification;
  final phoneNumberVerification;
  const Verification(
      {Key? key, this.otpVerification, this.phoneNumberVerification})
      : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController otpController = TextEditingController();

  bool progressing = false;
  void showValidationErrorMessage(String title, String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void verification() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (otpController.text.isEmpty) {
      showValidationErrorMessage("Message", 'OTP Cannot be Empty');
      return;
    }
    if (otpController.text.length != 6) {
      showValidationErrorMessage("Message", 'Enter a Valid OTP');
      return;
    }
    setState(() {
      progressing = true;
    });
    print(otpController.text);
    var jsonObject = {
      "phone": widget.phoneNumberVerification,
      "otp": otpController.text
    };
    print("the json object ${jsonObject} ");
    var header = {"Content-Type": "application/json"};
    var result = await http.post(
        Uri.parse('https://uatapi.zunocabs.com/public/verify-signup-otp'),
        body: json.encode(jsonObject),
        headers: header);
    setState(() {
      progressing = false;
    });
    print(result.statusCode);
    print(result.body);
    var jsonResult = json.decode(result.body);
    print(jsonResult['content']);
    if (result.statusCode == 200) {
      sharedPreferences.setString('tempPhone', widget.phoneNumberVerification);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SetPassword()));
    }
  }

  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getOtpNumber();
    });
  }

  void getOtpNumber() {
    print(widget.otpVerification);
    print(widget.phoneNumberVerification);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Your OTP is'),
        content: Text(widget.otpVerification),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
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
              height: 100,
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Verification',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 22),
                  ),
                  Text(
                    'Enter your OTP code here',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: PinInputTextField(
                  decoration: UnderlineDecoration(
                      colorBuilder:
                          PinListenColorBuilder(Colors.black, Colors.grey)),
                  controller: otpController,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  onSubmit: (pin) {
                    debugPrint('submit pin:$pin');
                  },
                  onChanged: (pin) {
                    debugPrint('onChanged execute. pin:$pin');
                  },
                  enableInteractiveSelection: false,
                  cursor: Cursor(
                    width: 2,
                    color: Colors.lightBlue,
                    radius: Radius.circular(1),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                color: Colors.white,
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    child: progressing
                        ? Center(child: CircularProgressIndicator())
                        : TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Color(0xFFFF0000),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            onPressed: () {
                              print('clicked');
                              verification();
                            },
                            child: Text(
                              'Verify Now',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
