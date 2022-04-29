// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'utils/Validation.dart' as validation;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zuno/Home.dart';
import 'package:zuno/setpassword.dart';
import 'package:zuno/vehicledetails.dart';
import 'package:http/http.dart' as http;

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  List genders = [
    {"name": "Male", "icon": "assets/Group 13.png"},
    {"name": "Female", "icon": "assets/Group 14.png"},
    {"name": "Others", "icon": "assets/Group 557.png"},
  ];

  File? singleImage;
  File? licenceImage;
  final licencePicker = ImagePicker();
  final singlePicker = ImagePicker();
  int selectedIndex = 0;
  var profileImage;
  var licenceUrl;
  bool progressing = false;

  void sendRequest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    setState(() {
      progressing = true;
    });
    print('the token is$token');
    var request = await http.MultipartRequest('POST',
        Uri.parse('https://uatapi.zunocabs.com/public/upload/profile-img'));
    request.files
        .add(await http.MultipartFile.fromPath('files', singleImage!.path));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'application/json';
    setState(() {
      progressing = false;
    });

    http.StreamedResponse response = await request.send();
    final res = await http.Response.fromStream(response);
    var jsonResult = json.decode(res.body);
    profileImage = jsonResult['content'][0];
    print(profileImage);
    print(res.body);
  }

  void licenceRequest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    setState(() {
      progressing = true;
    });
    print('the token is$token');
    print(licenceImage);
    var request = await http.MultipartRequest('POST',
        Uri.parse('https://uatapi.zunocabs.com/public/upload/licence-img'));
    request.files
        .add(await http.MultipartFile.fromPath('files', licenceImage!.path));
    request.headers['Authorization'] = 'Bearer $token';
    setState(() {
      progressing = false;
    });

    http.StreamedResponse response = await request.send();
    final res = await http.Response.fromStream(response);
    var jsonResult = json.decode(res.body);
    licenceUrl = jsonResult['content'][0];
    print(licenceUrl);
    print(res.body);
  }

  TextEditingController emailIdController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  void profileDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (nameController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter The Name', context);
      return;
    }
    if (aadharNumberController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter The AadharNumber', context);
      return;
    }
    if (aadharNumberController.text.length < 12) {
      validation.showValidationErrorMessage(
          'Message', 'Enter The Valid AadharNumber', context);
      return;
    }
    if (cityController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter The City Name', context);
      return;
    }
    if (emailIdController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter The emailId', context);
      return;
    }
    if (stateController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter The StateId', context);
      return;
    }
    if (districtController.text.isEmpty) {
      validation.showValidationErrorMessage(
          'Message', 'Enter The DistrictId', context);
      return;
    }
    setState(() {
      progressing = true;
    });

    var jsonObject = {
      'firstName': nameController.text,
      "lastName": lastNameController.text,
      'aadhaarNumber': aadharNumberController.text,
      "cityName": cityController.text,
      "email": emailIdController.text,
      "statesId": stateController.text,
      "districtId": districtController.text
    };
    print(nameController.text);
    print(lastNameController.text);
    print(emailIdController.text);
    print(
      aadharNumberController.text,
    );
    print(
      stateController.text,
    );
    print(districtController.text);
    print(cityController.text);
    var token = sharedPreferences.getString("token");
    print(token);
    var header = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    };
    var result = await http.post(
        Uri.parse(
            "https://uatapi.zunocabs.com/driver/addProfileDetailsOnSignup"),
        body: json.encode(jsonObject),
        headers: header);
    setState(() {
      progressing = false;
    });
    print(result.statusCode);
    print(result.body);
    var jsonResult = json.decode(result.body);
    print(jsonResult['message']);
    // sharedPreferences.setString('token', jsonResult['token'].toString());
    if (result.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFF0000),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SetPassword()));
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
                    'Profile Details',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 22),
                  ),
                  Text(
                    'Please provide the below details to GET STARTED.',
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
        body: Container(
          height: MediaQuery.of(context).size.height / 1,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(20),
            children: [
              Stack(
                children: [
                  GestureDetector(
                      onTap: () {
                        getSingleImage();
                      },
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              color: Colors.black,
                              shape: BoxShape.circle),
                          child: ClipOval(
                            child: singleImage != null
                                ? Image.file(
                                    singleImage!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ) //
                                : Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                          ),
                        ),
                      )),
                ],
              ),
              Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 15,
                      child: Row(
                        children: [
                          Text(
                            'First Name ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                              color: Color(0xFFFF0000),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 0),
                height: MediaQuery.of(context).size.height / 18,
                child: TextFormField(
                  controller: nameController,
                  maxLength: 25,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    counterText: '',
                    hintText: 'First Name',
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
                  height: MediaQuery.of(context).size.height / 15,
                  child: Row(
                    children: [
                      Text(
                        'LastName',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          color: Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 0),
                height: MediaQuery.of(context).size.height / 18,
                child: TextFormField(
                  controller: lastNameController,
                  maxLength: 25,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    counterText: '',
                    hintText: 'Last Name',
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
                      'Gender',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                        color: Color(0xFFFF0000),
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
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
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
                        'Aadhar Number ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          color: Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(bottom: 0),
                height: MediaQuery.of(context).size.height / 18,
                child: TextFormField(
                  controller: aadharNumberController,
                  maxLength: 12,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    counterText: '',
                    hintText: 'Enter Aadhar Number',
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
                  // height: MediaQuery.of(context).size.height/48,
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Text(
                        'email',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          color: Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: MediaQuery.of(context).size.height / 18,
                child: TextFormField(
                  controller: emailIdController,
                  maxLength: 25,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    counterText: '',
                    hintText: 'Enter email Id',
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
                        'State ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          color: Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: MediaQuery.of(context).size.height / 18,
                child: TextFormField(
                    controller: stateController,
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
                        'District ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          color: Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: MediaQuery.of(context).size.height / 18,
                child: TextFormField(
                  controller: districtController,
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
                  controller: cityController,
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
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 6,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '     Vehicles Details ',
                                style: TextStyle(
                                  height: 3,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                  color: Color(0xFFFF0000),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            /* margin: EdgeInsets.only(
                                top: 0, right: 40, left: 40, bottom: 10),*/
                            padding: EdgeInsets.only(left: 60, right: 60),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              color: Colors.white,
                            ),
                            child: TextButton(
                              onPressed: () {
                                print('Button Clicked');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VehicleDetails()));
                              },
                              child: Text(
                                ' + Add New Vehicle ',
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
                  ],
                ),
              ),
              Container(
                // padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.only(top: 20),
                height: 215,
                width: double.infinity,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '  Upload Driving License  ',
                          style: TextStyle(
                            height: 3,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            color: Color(0xFFFF0000),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: getLicenceImage,
                      child: licenceImage != null
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 153,
                              width: double.infinity,
                              child:
                                  Image.file(licenceImage!, fit: BoxFit.cover),
                            )
                          : Container(
                              height: 173,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 15, 20),
                                child: DottedBorder(
                                  color: Colors.grey,
                                  dashPattern: [8, 8],
                                  strokeWidth: 2,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera_alt_outlined,
                                            size: 30),
                                        Text(
                                          "Add Image",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              progressing
                  ? Center(child: CircularProgressIndicator())
                  : TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          primary: Colors.white,
                          backgroundColor: Color(0xFFFF0000)),
                      onPressed: () {
                        profileDetails();
                        print('Button Clicked');
                      },
                      child: Column(
                        children: [
                          Text(
                            'Finish',
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

  Future getSingleImage() async {
    final pickedImage =
        await singlePicker.getImage(source: (ImageSource.gallery));
    setState(() {
      if (pickedImage != null) {
        singleImage = File(pickedImage.path);
        sendRequest();
      } else {
        print('No Image Selected');
      }
    });
  }

  Future getLicenceImage() async {
    final pickedImage =
        await licencePicker.getImage(source: (ImageSource.gallery));
    setState(() {
      if (pickedImage != null) {
        licenceImage = File(pickedImage.path);
        licenceRequest();
      } else {
        print('No Image Selected');
      }
    });
  }
}
