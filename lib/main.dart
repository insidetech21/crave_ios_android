import 'dart:convert';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:craveiospro/SelectPhotoOptionsScreen.dart';
import 'package:craveiospro/dashboard_screen.dart';
import 'package:craveiospro/utility.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'custom_date_picker_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      const MyApp()
  );

  // FirebaseDatabase.instance.setPersistenceEnabled(true);
  // final scoresRef = FirebaseDatabase.instance.ref("scores");
  // scoresRef.keepSynced(true);
  //
  // final FirebaseDatabase database = FirebaseDatabase.instance;
  // database.setPersistenceEnabled(true);
  // database.setPersistenceCacheSizeBytes(10000000);

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crave Client Registration',
      theme: ThemeData(
        canvasColor: const Color(0xFFD4FCFF),
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: const Color(0xFF00D3FF),
          background: Colors.red,
          secondary: const Color(0xFFD4F8FF),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  String selectedImagePath = ""; // For Image Picker
  //XFile? image; // For Image Picker

  Uint8List? _bytesImage;
  String imgString = "";

  //final ImagePicker picker = ImagePicker(); // For Image Picker

  bool isCompleted = false; //Check completeness of input
  /* final _formKey = GlobalKey<
      FormState>();*/ // form object to be used for form validation

  int _activeStepIndex = 0;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController addressStreet1 = TextEditingController();
  TextEditingController addressStreet2 = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController companyAddress = TextEditingController();
  TextEditingController companyMail = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController comments = TextEditingController();
  final TextEditingController dateOfNextStepscontroller = TextEditingController();
  DateTime? _dateofNextStep;

  String genderValue = '';
  String cityValue1 = '';
  String stateValue1 = '';
  String countryValue1 = '';
  String interestedInValue = '';
  String nextStepsValue = '';
  String reachOutValue = '';

  var getResult = '';

  File? _image;
  UploadTask? uploadTask;
  String? urlDownload;

  Future _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      PickedFile? image = await picker.getImage(source: source);
      // final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        // final bytes = File().readAsBytesSync();
        // String imgString= base64Encode(bytes);
        //String imgString = base64Encode(_image);
        //final File img2=File(_image.path)
        imgString = Utility.base64String(_image!.readAsBytesSync());
        Navigator.of(context).pop();
      });
    } on Exception catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
    await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) =>
          DraggableScrollableSheet(
              initialChildSize: 0.28,
              maxChildSize: 0.4,
              minChildSize: 0.28,
              expand: false,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: SelectPhotoOptionsScreen(
                    onTap: _pickImage,
                  ),
                );
              }),
    );
  }

//   String result = "Hello World...!";
//   Future _scanQR() async {
//     var cameraStatus = await Permission.camera.status;
//     if(cameraStatus.isGranted)
//     {
//       String? qrdata = await scanner.scan();
//       print(qrdata);
//     }
//     else{
//       var isGrant = await Permission.camera.request();
//
//       if(isGrant.isGranted){
//         String? qrdata = await scanner.scan();
//         print(qrdata);
//       }
//     }
//     try {
//       String? cameraScanResult = await scanner.scan();
//       setState(() {
//         result = cameraScanResult!; // setting string result with cameraScanResult
//       });
//     } on PlatformException catch (e) {
//       print(e);
//     }
//

  List<Step> stepList() =>
      [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Step 1'),
          content: SingleChildScrollView(
            padding: const EdgeInsets.only(
                top: 25.0, right: 0.0, bottom: 25.0, left: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: TextFormField(
                    controller: name,
                    decoration: const InputDecoration(
                      /*prefixIcon: Container(
                          width:100, //Set it according to your need
                          color: Colors.cyan,
                        ),*/
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF00D3FF), width: 1),
                      ),

                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter Name :',
                      hintText: 'Full Name',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Card(
                          color: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: 58,
                            width: 48,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Full Name';
                      }
                      return null;
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                /* TextFormField(
              controller: qr,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Personal Data :',
                //hintText: 'Scan QR/Bar Code',
                icon: Icon(Icons.qr_code),
              ),
              readOnly: false,
              showCursor: false,
              autocorrect: true,
              enableIMEPersonalizedLearning: true,
              // onChanged: (qr){
              //   dispose();
              // },

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Scan the QR or Bar Code';
                }
                return null;
              },
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),*/

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: TextFormField(
                    controller: mobilenumber,
                    decoration: const InputDecoration(

                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF00D3FF), width: 1),
                      ),

                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter Mobile Number :',
                      hintText: 'Mobile Number',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Card(
                          color: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: 58,
                            width: 48,
                            child: Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Mobile Number';
                      }
                      return null;
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(

                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF00D3FF), width: 1),
                      ),

                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter Email Id :',
                      hintText: 'Email Id',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Card(
                          color: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: 58,
                            width: 48,
                            child: Icon(
                              Icons.mail,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email ID';
                      }
                      return null;
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                // TextFormField(
                //   controller: email,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     filled: true,
                //     labelText: 'Select Gender',
                //     hintText: 'Gender',
                //     icon: Icon(Icons.people),
                //   ),
                //   keyboardType: TextInputType.text,
                // ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      //iconSize: 30,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF00D3FF), width: 1),
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Select Gender',
                        hintText: 'Gender',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child:  Card(
                            color: Color(0xFF00D3FF),
                            child: SizedBox(
                              height: 58,
                              width: 48,
                              child: Icon(
                                Icons.people,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select Gender';
                        }
                        return null;
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down, color: Colors.blueGrey,),
                      items: <String>['Male', 'Female', 'Other'].map((
                          String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (values) {
                        setState(() {
                          genderValue = values!;
                        }
                        );
                      },
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: TextFormField(
                    controller: addressStreet1,
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF00D3FF), width: 1),
                      ),
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter Street 1 :',
                      hintText: 'Street 1 Address',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child:  Card(
                          color: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: 58,
                            width: 48,
                            child: Icon(
                              Icons.location_city,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Street 1';
                      }
                      return null;
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: TextFormField(
                    controller: addressStreet2,
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF00D3FF), width: 1),
                      ),
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter Street 2 :',
                      hintText: 'Street 2 Address',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child:  Card(
                          color: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: 58,
                            width: 48,
                            child: Icon(
                              Icons.streetview,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Street 2';
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                // TextFormField(
                //   controller: addressCity,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     filled: true,
                //     labelText: 'Enter City :',
                //     hintText: 'City',
                //     icon: Icon(Icons.location_city),
                //   ),
                //   keyboardType: TextInputType.text,
                //
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please Enter City';
                //     }
                //     return null;
                //   },
                // ),
                // const Padding(
                //   padding: EdgeInsets.only(bottom: 30.0),
                // ),


                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: TextFormField(
                    controller: pincode,
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF00D3FF), width: 1),
                      ),
                      filled: true,
                      //fillColor: Color(0xFF004B8D),
                      labelText: 'Enter Zip Code :',
                      hintText: 'Zip',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child:  Card(
                          color: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: 58,
                            width: 48,
                            child: Icon(
                              Icons.numbers,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Zip Code';
                      }
                      return null;
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                /* showCountryPicker(
                  context: context,
                  countryFilter: <String>['CD', 'CG', 'KE', 'UG'], // only specific countries
                  onSelect: (){},
                ),*/

                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        elevation: 15,
                        //color: Colors.transparent,
                        shadowColor: const Color(0xFF00D3FF),
                        child: CSCPicker(
                          ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                          dropdownDecoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(05)),
                              color: Colors.transparent,
                              border:
                              Border.all(color: const Color(0xFF00D3FF), width: 1)),

                          ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                          disabledDropdownDecoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(5)),
                              color: Colors.grey.shade200,
                              border:
                              Border.all(color: Colors.grey.shade500, width: 1)),

                          layout: Layout.vertical,
                          //flagState: CountryFlag.DISABLE,

                          onCountryChanged: (value) {
                            setState(() {
                              countryValue1 = value.toString();
                            });
                          },

                          onStateChanged: (value) {
                            setState(() {
                              stateValue1 = value.toString();
                            });
                          },

                          onCityChanged: (value){
                            setState(() {
                              cityValue1 = value.toString();
                            });
                          },

                          ///Enable disable state dropdown [OPTIONAL PARAMETER]
                          showStates: true,

                          /// Enable disable city drop down [OPTIONAL PARAMETER]
                          showCities: true,


                          ///Default Country
                          //defaultCountry: DefaultCountry.India,
                          //defaultCountry: DefaultCountry.United_States,

                          dropdownDialogRadius: 20.0,

                          ///selected item style [OPTIONAL PARAMETER]
                          selectedItemStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),

                          ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                          dropdownHeadingStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),

                          ///DropdownDialog Item style [OPTIONAL PARAMETER]
                          dropdownItemStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),

                          //currentCountry:,

                          ///Disable country dropdown (Note: use it with default country)
                          disableCountry: false,

                          ///Search bar radius [OPTIONAL PARAMETER]
                          searchBarRadius: 50.0,

                        ),
                      ),
                    ],
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(0.0),
                //   child: DropdownButtonFormField<String>(
                //     isExpanded: true,
                //     //iconSize: 30,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       filled: true,
                //       labelText: 'Select State',
                //       hintText: 'State',
                //       icon: Icon(Icons.people_rounded),
                //     ),
                //
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please Select State';
                //       }
                //       return null;
                //     },
                //     icon: const Icon(Icons.arrow_drop_down, color: Colors.blueGrey,),
                //     items: <String>['Maharashtra','Gujarat','Up', 'MP','Assam'].map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (values) {
                //       setState(() {
                //         genderValue = values!;
                //       }
                //       );
                //     },
                //   ),
                // ),

                // const Padding(
                //   padding: EdgeInsets.only(bottom: 30.0),
                // ),

                // TextFormField(
                //   controller: state,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     filled: true,
                //     labelText: 'Enter State :',
                //     hintText: 'State',
                //     icon: Icon(Icons.map),
                //   ),
                //   keyboardType: TextInputType.text,
                //
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please Enter State';
                //     }
                //     return null;
                //   },
                // ),

                // const Padding(
                //   padding: EdgeInsets.only(bottom: 30.0),
                // ),


                // Padding(
                //   padding: const EdgeInsets.all(0.0),
                //   child: DropdownButtonFormField<String>(
                //     isExpanded: true,
                //     //iconSize: 30,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       filled: true,
                //       labelText: 'Select Country',
                //       hintText: 'Country',
                //       icon: Icon(Icons.people_rounded),
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please Select Country';
                //       }
                //       return null;
                //     },
                //     icon: const Icon(Icons.arrow_drop_down, color: Colors.blueGrey,),
                //     items: <String>['US', 'UK', 'Canada','India','Other'].map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (values) {
                //       setState(() {
                //         genderValue = values!;
                //       }
                //       );
                //     },
                //   ),
                // ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),


                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: Center(
                    child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _showSelectPhotoOptions(context);
                        },
                        child: Center(
                          child: Container(
                            height: 180.0,
                            width: 300.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xFFDDE8EB),
                            ),
                            child: Center(
                              child: _image == null
                                  ? const Text(
                                'Select Image',
                                style: TextStyle(fontSize: 20),
                              )
                                  : Center(
                                /*child: Container(
                                      decoration:const BoxDecoration(
                                        //backgroundImage: FileImage(_image!),
                                        shape: BoxShape.rectangle,
                                        color: Color(0xFFDDE8EB),
                                      ),*/
                                child: Container(
                                  //duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.memory(setImage(imgString)).image,
                                      fit: BoxFit.cover,
                                    ),
                                    // your own shape
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                                /*CircleAvatar(
                                backgroundImage: FileImage(_image!),
                                radius: 100.0,
                                          *//*backgroundColor: Colors.yellow,*//*
                              ),*/
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                // TextFormField(
                //   controller: name,
                //   decoration: const InputDecoration(
                //     fillColor: Colors.transparent,
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Color(0xFF004B8D), width: 1),
                //     ),
                //     border: OutlineInputBorder(),
                //     filled: true,
                //     labelText: 'Select Image :',
                //     hintText: 'Tap here for selecting Image',
                //     icon: Icon(Icons.image),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please Upload Image';
                //     }
                //     return null;
                //   },
                //   onTap: (){
                //     //Navigator.push(context, route)
                //     Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ImagePic()));
                //   },
                // ),


                /* TextFormField(
              controller: country,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Country :',
                hintText: 'Country',
                icon: Icon(Icons.flag),
              ),
              keyboardType: TextInputType.text,

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Country';
                }
                return null;
              },
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),*/

              ],
            ),
          ),
        ),

        // Step(
        //   state: _activeStepIndex<= 1? StepState.editing : StepState.complete,
        //   isActive: _activeStepIndex >= 1,
        //   title: const Text('Full\nAddress'),
        //   content: SingleChildScrollView(
        //     padding: const EdgeInsets.only(top: 25.0, right: 30.0, bottom: 25.0, left: 10.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: <Widget>[
        //
        //       ],
        //     ),
        //   ),
        // ),

        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Step 2'),
          content: SingleChildScrollView(
            padding: const EdgeInsets.only(
                top: 25.0, right: 0.0, bottom: 25.0, left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: TextFormField(
                    controller: companyName,
                    decoration: const InputDecoration(

                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF00D3FF), width: 1),
                      ),

                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter Company Name :',
                      hintText: 'Company Name',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Card(
                          color: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: 58,
                            width: 48,
                            child: Icon(
                              Icons.corporate_fare,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Company Name';
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: TextFormField(
                    controller: companyAddress,
                    decoration: const InputDecoration(

                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF00D3FF), width: 1),
                      ),

                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter company address :',
                      hintText: 'Company Address',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child:  Card(
                          color: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: 58,
                            width: 48,
                            child: Icon(
                              Icons.location_city,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Company Address';
                      }
                      return null;
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: TextFormField(
                    controller: companyMail,
                    decoration: const InputDecoration(

                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF00D3FF), width: 1),
                      ),

                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter Email Id :',
                      hintText: 'Company Email Id',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child:  Card(
                          color: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: 58,
                            width: 48,
                            child: Icon(
                              Icons.mail_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Company Email ID';
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: TextFormField(
                    controller: website,
                    decoration: const InputDecoration(

                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF00D3FF), width: 1),
                      ),

                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter Company Website :',
                      hintText: 'Company Website',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Card(
                          color: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: 58,
                            width: 48,
                            child: Icon(
                              Icons.web,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Company Website';
                      }
                      return null;
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      //iconSize: 30,
                      decoration: const InputDecoration(

                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF00D3FF), width: 1),
                        ),

                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Interested In :',
                        hintText: 'Select your preference',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child:  Card(
                            color: Color(0xFF00D3FF),
                            child: SizedBox(
                              height: 58,
                              width: 48,
                              child: Icon(
                                Icons.interests,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select your preference';
                        }
                        return null;
                      },

                      icon: const Icon(
                        Icons.arrow_drop_down, color: Colors.blueGrey,),
                      items: <String>[
                        'cMaintenance',
                        'cCalibration',
                        'cFSM',
                        'Facility Maintenance',
                        'cDispatch',
                        'Warehouse',
                        'cTrack',
                        'Truck Loading'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (values) {
                        setState(() {
                          interestedInValue = values!;
                        }
                        );
                      },
                    ),

                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      //iconSize: 30,
                      decoration: const InputDecoration(

                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF00D3FF), width: 1),
                        ),

                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Next Steps :',
                        hintText: 'Select your preference',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child:  Card(
                            color: Color(0xFF00D3FF),
                            child: SizedBox(
                              height: 58,
                              width: 48,
                              child: Icon(
                                Icons.handshake,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select your next Steps';
                        }
                        return null;
                      },

                      icon: const Icon(
                        Icons.arrow_drop_down, color: Colors.blueGrey,),
                      items: <String>['Meeting', 'Proposal', 'Workshop', 'Other']
                          .map((String value1) {
                        return DropdownMenuItem<String>(
                          value: value1,
                          child: Text(value1),
                        );
                      }).toList(),
                      onChanged: (values) {
                        setState(() {
                          nextStepsValue = values!;
                        }
                        );
                      },
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      //iconSize: 30,
                      decoration: const InputDecoration(

                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF00D3FF), width: 1),
                        ),

                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Reach Out In :',
                        hintText: 'Select your preference',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child:  Card(
                            color: Color(0xFF00D3FF),
                            child: SizedBox(
                              height: 58,
                              width: 48,
                              child: Icon(
                                Icons.timeline,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please Select your preference';
                      //   }
                      //   return null;
                      // },

                      icon: const Icon(
                        Icons.arrow_drop_down, color: Colors.blueGrey,),
                      items: <String>['1M', '3M', '6M', '12M'].map((
                          String value1) {
                        return DropdownMenuItem<String>(
                          value: value1,
                          child: Text(value1),
                        );
                      }).toList(),
                      onChanged: (values) {
                        setState(() {
                          reachOutValue = values!;
                        }
                        );
                      },
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                // date field

                // TextFormField(
                //   controller: date,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     filled: true,
                //     labelText: ' Select Date',
                //     //hintText: 'Select Date',
                //     icon: Icon(Icons.calendar_today),
                //   ),
                //   onTap: () async {
                //     DateTime? pickeddate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(2000),
                //         lastDate: DateTime(2101));

                //     if(pickeddate != null){
                //       setState(() {
                //         //date.text = ('yyyy-MM-dd').format(pickeddate);

                //       });
                //     }

                //     },
                //   keyboardType: TextInputType.text,
                // ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: CustomDatePickerFormField(
                      controller: dateOfNextStepscontroller,
                      txtLabel: "Next Steps Planned On :",
                      //hintText: 'Select your preference',
                      callback: () {
                        pickDateOfBirth(context);
                      }),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00D3FF),
                  child: TextFormField(
                    //controller: ,
                    controller: comments,
                    decoration: const InputDecoration(

                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF00D3FF), width: 1),
                      ),

                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Comments (Optional) :',
                      hintText: 'Any Comments ?',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child:  Card(
                          color: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: 68,
                            width: 50,
                            child: Icon(
                              Icons.text_format,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter comments';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Step 3'),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: 150.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: _image == null
                          ? const Text(
                        'No image selected',
                        style:
                        TextStyle(fontSize: 20),
                      )
                          : Hero(
                        tag: 'emimg-$_image',
                        child:
                        Container(
                          //duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Image.memory(setImage(imgString)).image,
                              fit: BoxFit.cover,
                            ),

                            // your own shape
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                    )),

                Text('Name : ${name.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),

                /* Text('Personal Data : $getResult',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),*/

                Text('Email : ${email.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                Text('Mobile Number : ${mobilenumber.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                Text('Gender: $genderValue',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                Text('Address Street1 : ${addressStreet1.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                Text('Address Street2 : ${addressStreet2.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                Text('PinCode : ${pincode.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                Text('City : $cityValue1',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                Text('State : $stateValue1',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                Text('Country : $countryValue1',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                Text('Company Name : ${companyName.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),

                Text('Company Add : ${companyAddress.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),

                Text('Company Mail : ${companyMail.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),

                Text('Company Website : ${website.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),

                Text('Interested In : $interestedInValue',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                Text('Next Steps : $nextStepsValue',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),

                Text('Reach Out In : $reachOutValue',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),

                Text('Next Steps Planned : ${dateOfNextStepscontroller.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),

                Text('Comments : ${comments.text}',
                  style: const TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),

                // Center(
                //   child: ElevatedButton(
                //     onPressed: (){
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: ((context) =>const ViewCustomeer() ))
                //       );
                //     }, child: const Text('View Data'),),
                //
                // ),
              ],
            ),
          ),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: ,
      backgroundColor: Colors.white,
      appBar:
      AppBar(
        title: const Center(child:
        Text('Crave Client Registration')
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.document_scanner,
              color: Colors.white,
            ),
            onPressed: () {

              /*scanQRCode();
              qr.value = TextEditingValue(
                text: getResult,
                selection: TextSelection.fromPosition(
                  TextPosition(offset: getResult.length),
                ),
              );*/
              // do something
            },
          ),
        ],
        backgroundColor: const Color(0xFF00D3FF),
      ),
      //
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF00D3FF),
        //icon: const Icon(Icons.save),
        onPressed: () {

          uploadFile();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Data Submitted Successfully !"),
          ));
          //_scanQR(); // calling a function when user click on button

          //final image2 = _image;
          final image2 = urlDownload!;
          final name2 = name.text;
          final email2 = email.text;
          final genderValue2 = genderValue;
          final mobilenumber2 = mobilenumber.text;
          final addressStreet1_2 = addressStreet1.text;
          final addressStreet2_2 = addressStreet2.text;
          final pincode2 = pincode.text;
          final city2 = cityValue1;
          final state2 = stateValue1;
          final country2 = countryValue1;
          final companyName2 = companyName.text;
          final companyAddress2 = companyAddress.text;
          final companyMail2 = companyMail.text;
          final website2 = website.text;
          final interestedIn2 = interestedInValue;
          final nextSteps2 = nextStepsValue;
          final reachOutIn2 = reachOutValue;
          final nextStepsPlanned2 = dateOfNextStepscontroller.text;
          final comments2 = comments.text;



          createuser(
            //_image: image2,
            image: image2,
            name: name2,
            email: email2,
            genderValue: genderValue2,
            mobilenumber: mobilenumber2,
            addressStreet1: addressStreet1_2,
            addressStreet2: addressStreet2_2,
            pincode: pincode2,
            cityValue1: city2,
            stateValue1: state2,
            countryValue1: country2,
            companyName: companyName2,
            companyAdd: companyAddress2,
            companyMail: companyMail2,
            website: website2,
            interestedInValue: interestedIn2,
            nextStepsValue: nextSteps2,
            reachOutValue: reachOutIn2,
            dateOfNextStepscontroller: nextStepsPlanned2,
            comments: comments2,
          );
        },
        label: const Text("Submit Data"),

        // code added for Firebase Connection Checking

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      //
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 05),
        height: 600,
        child: Stepper(
            type: StepperType.horizontal,
            currentStep: _activeStepIndex,
            steps: stepList(),
            onStepContinue: () {
              if (_activeStepIndex < (stepList().length - 1)) {
                _activeStepIndex += 1;
              }
              setState(() {},);
            },
            onStepCancel: () {
              if (_activeStepIndex == 0) {
                return;
              }
              _activeStepIndex -= 1;
              setState(() {});
            },
            // For Controlling the Stepper Buttons
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00D3FF),
                        // padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        // textStyle: TextStyle(
                        //     fontSize: 30,
                        //     fontWeight: FontWeight.bold)
                      ),
                      child: Text(_activeStepIndex == stepList().length - 1
                          ? "SUBMIT"
                          : "NEXT"),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  if(_activeStepIndex != 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00D3FF),
                        ),
                        child: const Text('PREVIOUS'),
                      ),

                    ),
                  /*  Expanded(child:
                  ElevatedButton(
                    child: const Text("Submit") ,
                    onPressed: () {
                      },
                  ),
                  ),*/
                ],
              );
            }
        ),
      ),

      /* body: const CSCPicker(

        onCountryChanged: (){},
        onStateChanged: (){},
        onCityChanged: (){},
      ),*/

    );
  }

  // Its for Validation part

  // bool isCompleted(){
  //   if (_activeStepIndex == 0){
  //     //check steps fields
  //     if(name.text.isEmpty || email.text.isEmpty){
  //       return false;
  //     } else{
  //       return true; // if all fields are not empty
  //     }
  //     else  if(_activeStepIndex == 1){
  //     //it will check second step
  //       if(companyName.text.isEmpty){
  //         return false;
  //       } else{
  //         return true;
  //       }
  //   }
  //   }
  // }

  Future createuser({
    required String
    image,
    name,
    email,
    genderValue,
    mobilenumber,
    addressStreet1,
    addressStreet2,
    pincode,
    cityValue1,
    stateValue1,
    countryValue1,
    companyName,
    companyAdd,
    companyMail,
    website,
    interestedInValue,
    nextStepsValue,
    reachOutValue,
    dateOfNextStepscontroller,
    comments,

  }) async {
    final docuser = FirebaseFirestore.instance.collection('guest2').doc();
    final customer = Customer(
      id: docuser.id,
      image:image,
      name: name,
      email: email,
      genderValue: genderValue,
      mobilenumber: mobilenumber,
      addressStreet1: addressStreet1,
      addressStreet2: addressStreet2,
      pincode: pincode,
      cityValue1: cityValue1,
      stateValue1: stateValue1,
      countryValue1: countryValue1,
      companyName: companyName,
      companyAdd: companyAdd,
      companyMail: companyMail,
      website: website,
      interestedInValue: interestedInValue,
      nextStepsValue: nextStepsValue,
      reachOutValue: reachOutValue,
      dateOfNextStepscontroller: dateOfNextStepscontroller,
      comments: comments,

    );
    final json = customer.toJson();
    await docuser.set(json);
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _dateofNextStep ?? initialDate,
      firstDate: DateTime(DateTime
          .now()
          .year - 100),
      lastDate: DateTime(DateTime
          .now()
          .year + 1),
      builder: (context, child) =>
          Theme(
              data: ThemeData().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF00D3FF),
                  onPrimary: Colors.white,
                  onSecondary: Colors.black,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child ?? const Text('')),
    );
    if (newDate == null) {
      return;
    }
    setState(() {
      _dateofNextStep = newDate;
      String dob = DateFormat('dd/MM/yyy').format(newDate);

      dateOfNextStepscontroller.text = dob;
    });
  }

/*  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });
      // print("QRCode_Result: ");
      // print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }*/

  setImage(String img) {
    _bytesImage = const Base64Decoder().convert(img);
    return _bytesImage;
  }

  // Future uploadFile() async {
  //   final file = File(_image!.path);
  //   final path = "visiting_cards/${_image!.path}";

  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   ref.putFile(file);

  //     }


  Future uploadFile() async {
    final file = File(_image!.path);
    final path = "visiting_cards/${_image!.path}";

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => null);

    urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link:$urlDownload');
    //Image.network(urlDownload);
    setState(() {

      uploadTask = null;
    });

  }

/*Future uploadFile() async{
    try{

      firebase_storage.UploadTask uploadTask;

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.
      ref().
      child('visiting_cards');

      ref.putFile(_image.path)
    }
    catch(e){
      print(e);
    }
}*/
}

class Customer {
  String id;
  final String image;
  final String name;
  final String email;
  final String genderValue;
  final String mobilenumber;
  final String addressStreet1;
  final String addressStreet2;
  final String pincode;
  final String cityValue1;
  final String stateValue1;
  final String countryValue1;
  final String companyName;
  final String companyAdd;
  final String companyMail;
  final String website;
  final String interestedInValue;
  final String nextStepsValue;
  final String reachOutValue;
  final String dateOfNextStepscontroller;
  final String comments;


  Customer({
    this.id = '',
    required this.image,
    required this.name,
    required this.email,
    required this.genderValue,
    required this.mobilenumber,
    required this.addressStreet1,
    required this.addressStreet2,
    required this.pincode,
    required this.cityValue1,
    required this.stateValue1,
    required this.countryValue1,
    required this.companyName,
    required this.companyAdd,
    required this.companyMail,
    required this.website,
    required this.interestedInValue,
    required this.nextStepsValue,
    required this.reachOutValue,
    required this.dateOfNextStepscontroller,
    required this.comments,

  });

  Map<String, dynamic> toJson() => {
    'image':image,
    'id': id,
    'name': name,
    'email': email,
    'genderValue': genderValue,
    'mobilenumber': mobilenumber,
    'addressStreet1': addressStreet1,
    'addressStreet2': addressStreet2,
    'pincode': pincode,
    'cityValue1': cityValue1,
    'stateValue1': stateValue1,
    'countryValue1': countryValue1,
    'companyName':companyName,
    'companyAdd': companyAdd,
    'companyMail': companyMail,
    'website': website,
    'interestedInValue' : interestedInValue,
    'nextStepsValue' : nextStepsValue,
    'reachOutValue' : reachOutValue,
    'dateOfNextStepscontroller' : dateOfNextStepscontroller,
    'comments' : comments,
  };

  static Customer fromJson(Map<String, dynamic> json) =>
      Customer(
        image: json['image'],
        name: json['name'],
        email: json['email'],
        genderValue: json['genderValue'],
        mobilenumber: json['mobilenumber'],
        pincode: json['pincode'],
        addressStreet1: json ['addressStreet1'],
        addressStreet2: json ['addressStreet2'],
        cityValue1: json['cityValue1'],
        stateValue1: json['stateValue1'],
        countryValue1: json['countryValue1'],
        companyName: json['companyName'],
        companyAdd: json['companyAdd'],
        companyMail: json['companyMail'],
        website: json['website'],
        interestedInValue: json['interestedInValue'],
        nextStepsValue: json['nextStepsValue'],
        reachOutValue: json['reachOutValue'],
        dateOfNextStepscontroller: json['dateOfNextStepscontroller'],
        comments: json['comments'],
      );
}


/*
Future <void> pickDateOfBirth(BuildContext context) async{
  final initialDate = DateTime.now();
  final newDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? initialDate, // for selected date as it is
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context,child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.yellow,
            onPrimary: Colors.pink,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child ?? const Text(''),
      )
  );
  if(newDate == null)
  {
    return;
  }
  setState(() {
    _dateOfBirth = newDate; // for selected date as it is
    String dob = DateFormat('dd/MM/yyyy').format(newDate);
    //_dateOfBirthController.text = newDate.toIso8601String();
    _dateOfBirthController.text = dob;
  });
}
}
*/