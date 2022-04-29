// ignore_for_file: prefer_const_constructors
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:zuno/profiledetails.dart';

import 'faredetails.dart';

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  var SelectedVehicleType;
  List<dynamic> vehicleType = [
    {
      "title": "Auto",
      "image": 'assets/Auto.jpg',
    },
    {
      "title": "Hatchback",
      "image": 'assets/7seater.jpg',
    },
    {
      "title": "Sedan",
      "image": 'assets/car.jpg',
    },
    {
      "title": "7-Seater",
      "image": 'assets/svan.jpg',
    },
    {"title": "Van", "image": 'assets/car.jpg'}
  ];
  List vehicleBrandList = ['Bajaj', 'Tata', 'Suzuki', 'Mahindra', 'Piaggio'];
  List vehicleModelList = ['Indigo', 'Nexon', 'Altroz', 'Tiago', 'Tigor'];
  var vehicleBrandText = 'Select Vehicle Brand';
  var vehicleModelText = 'Select Vehicle Model';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
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
                            builder: (context) => ProfileDetails(),
                          ));
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  Text(
                    'Vehicle Details',
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 15),
                height: 20,
                child: Row(
                  children: [
                    Text("Vehicle Type ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
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
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 90,
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: vehicleType.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          SelectedVehicleType = vehicleType[index]["title"];
                        });

                        print(SelectedVehicleType);
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  border: SelectedVehicleType ==
                                          vehicleType[index]["title"]
                                      ? Border.all(width: 10, color: Colors.red)
                                      : Border(),
                                  shape: BoxShape.circle),
                              child: ClipOval(
                                child: Image.asset(
                                  vehicleType[index]["image"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${vehicleType[index]["title"]}',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 40,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(top: 0, left: 15),
                child: Row(
                  children: [
                    Text(
                      'Vehicle Brands ',
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
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      enableDrag: false,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 75),
                          padding: EdgeInsets.fromLTRB(20, 30, 10, 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Vehicle Brand',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Expanded(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      scrollbarTheme: ScrollbarThemeData(
                                          thumbColor: MaterialStateProperty.all(
                                              Color(0xFFAAAAAA)),
                                          trackColor: MaterialStateProperty.all(
                                              Color(0xFFEBEBEB)))),
                                  child: Scrollbar(
                                    radius: Radius.circular(10),
                                    isAlwaysShown: true,
                                    thickness: 8,
                                    trackVisibility: true,
                                    child: ListView.separated(
                                        primary: true,
                                        shrinkWrap: true,
                                        itemCount: vehicleBrandList.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            VehicleDetails(),
                                                      ));
                                                  setState(() {
                                                    vehicleBrandText =
                                                        vehicleBrandList[index];
                                                  });
                                                  print(vehicleBrandText);
                                                },
                                                child: Text(
                                                    vehicleBrandList[index])),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const SizedBox(
                                                  height: 25,
                                                )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          vehicleBrandText,
                          style: TextStyle(
                              fontSize: 14,
                              color: vehicleBrandText == 'Select Vehicle Brand'
                                  ? Color(0xFFAAAAAA)
                                  : Colors.black),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                        )
                      ],
                    )),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(top: 0, left: 15),
                child: Row(
                  children: [
                    Text(
                      'Vehicle Models ',
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
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      enableDrag: false,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 75),
                          padding: EdgeInsets.fromLTRB(20, 30, 10, 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Vehicle Model',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Expanded(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      scrollbarTheme: ScrollbarThemeData(
                                          thumbColor: MaterialStateProperty.all(
                                              Color(0xFFAAAAAA)),
                                          trackColor: MaterialStateProperty.all(
                                              Color(0xFFEBEBEB)))),
                                  child: Scrollbar(
                                    radius: Radius.circular(10),
                                    isAlwaysShown: true,
                                    thickness: 8,
                                    trackVisibility: true,
                                    child: ListView.separated(
                                        primary: true,
                                        shrinkWrap: true,
                                        itemCount: vehicleModelList.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            VehicleDetails(),
                                                      ));
                                                  setState(() {
                                                    vehicleModelText =
                                                        vehicleModelList[index];
                                                  });
                                                  print(vehicleModelText);
                                                },
                                                child: Text(
                                                    vehicleModelList[index])),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const SizedBox(
                                                  height: 25,
                                                )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          vehicleModelText,
                          style: TextStyle(
                              fontSize: 14,
                              color: vehicleModelText == 'Select Vehicle Model'
                                  ? Color(0xFFAAAAAA)
                                  : Colors.black),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                        )
                      ],
                    )),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
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
                          '  Vehicle Image with Vehicle Number  ',
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
                    Container(
                      height: 173,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 15, 20),
                        child: DottedBorder(
                          color: Colors.grey,
                          dashPattern: [8, 8],
                          strokeWidth: 2,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt_outlined, size: 30),
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
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(top: 0, left: 15),
                child: Row(
                  children: [
                    Text(
                      '  Vehicle Number ',
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
                ),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                height: MediaQuery.of(context).size.height / 18,
                child: TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    counterText: '',
                    hintText: 'Enter Your Vehicle Number',
                    hintStyle: TextStyle(fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width / 3,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFFFFFFF),
                      ),
                      onPressed: () {
                        print('Button Clicked');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FareDetails()));
                      },
                      child: Text(
                        '     Skip     ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 3,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFFF0000)),
                      onPressed: () {
                        print('Button Clicked');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FareDetails()));
                      },
                      child: Text(
                        '      Next     ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
