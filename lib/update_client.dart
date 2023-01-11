import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:craveiospro/SelectPhotoOptionsScreen.dart';
import 'package:craveiospro/utility.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'custom_date_picker_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class UpdateClient extends StatefulWidget {
  final String docid;
  const UpdateClient({super.key, required this.docid});

  @override
  State<UpdateClient> createState() => _UpdateClientState();
}

class _UpdateClientState extends State<UpdateClient> {

  late DatabaseReference dbRef; // for Getting Data

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



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('guest2');
  }

  void getClientData() async{
    DataSnapshot snapshot = await dbRef.child(widget.docid).once() as DataSnapshot;
    Map client = snapshot.value as Map;

    name.text = client['name'];
    email.text = client['email'];
    addressStreet1.text = client['addressStreet1'];
    addressStreet2.text = client['addressStreet2'];
    pincode.text = client['pincode'];
    companyName.text = client['companyName'];
    companyAddress.text = client['companyAddress'];
    companyMail.text = client['companyMail'];
    website.text = client['website'];
    comments.text = client['comments'];
    dateOfNextStepscontroller.text = client['dateOfNextStepscontroller'];
    genderValue = client['genderValue'];
    cityValue1 = client['cityValue1'];
    stateValue1 = client['stateValue1'];
    countryValue1 = client['countryValue1'];
    interestedInValue = client['interestedInValue'];
    nextStepsValue = client['nextStepsValue'];
    reachOutValue = client['reachOutValue'];

  }

  String selectedImagePath = ""; // For Image Picker
  //XFile? image; // For Image Picker

  Uint8List? _bytesImage;
  String imgString = "";

  //final ImagePicker picker = ImagePicker(); // For Image Picker

  bool isCompleted = false; //Check completeness of input
  /* final _formKey = GlobalKey<
      FormState>();*/ // form object to be used for form validation

  int _activeStepIndex = 0;

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

    List<Step> stepList() =>
        [
          Step(
            state: _activeStepIndex <= 0 ? StepState.editing : StepState
                .complete,
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
                      //initialValue: name.text,
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
                            child: Card(
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
                          child: Card(
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
                          child: Card(
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
                          child: Card(
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
                                Border.all(color: const Color(0xFF00D3FF),
                                    width: 1)),

                            ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                            disabledDropdownDecoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5)),
                                color: Colors.grey.shade200,
                                border:
                                Border.all(color: Colors.grey.shade500,
                                    width: 1)),

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

                            onCityChanged: (value) {
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
                                        image: Image
                                            .memory(setImage(imgString))
                                            .image,
                                        fit: BoxFit.cover,
                                      ),
                                      // your own shape
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  /*CircleAvatar(
                                backgroundImage: FileImage(_image!),
                                radius: 100.0,
                                          */ /*backgroundColor: Colors.yellow,*/ /*
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
            state: _activeStepIndex <= 1 ? StepState.editing : StepState
                .complete,
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
                          child: Card(
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
                          child: Card(
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
                            child: Card(
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
                            child: Card(
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
                        items: <String>[
                          'Meeting',
                          'Proposal',
                          'Workshop',
                          'Other'
                        ]
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
                            child: Card(
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
                          child: Card(
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
                                image: Image
                                    .memory(setImage(imgString))
                                    .image,
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
          Text('Crave Client Update')
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

            Map<String, String> client ={
              'name':name.text,
              'email': email.text,

            };

            dbRef.child(widget.docid).update(client)
            .then((value) => {
              Navigator.pop(context)
            });

            uploadFile();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Data Updated Successfully !"),
            ));
            //_scanQR(); // calling a function when user click on button
          },
          label: const Text("Update Data"),

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
                  ],
                );
              }
          ),
        ),

      );
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

  setImage(String img) {
    _bytesImage = const Base64Decoder().convert(img);
    return _bytesImage;
  }


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

}

