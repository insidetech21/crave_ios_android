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
import 'package:path/path.dart' as p;

import 'dashboard_screen.dart';



class UpdateClient extends StatefulWidget {


  final String docid;
  final String name;
  final String email;
  final String mobilenumber;
  final String picode;
  final String addressStreet1;
  //final String addressStreet2;
  final String companyName;
  final String companyAdd;
  final String companyMail;
  final String comments;
  final String website;
  final String genderValue;
  final String cityValue1;
  final String stateValue1;
  final String countryValue1;
  final String InterestedInValue;
  final String nextStepsValue;
  final String reachOutValue;
  final String old_image;
  final String dateofNextStep;


  const UpdateClient(
      {super.key,
        required this.docid,
        required this.name,
        required this.email,
        required this.mobilenumber,
        required this.picode,
        required this.addressStreet1,
        //required this.addressStreet2,
        required this.companyName,
        required this.companyAdd,
        required this.companyMail,
        required this.comments,
        required this.website,
        required this.genderValue,
        required this.cityValue1,
        required this.stateValue1,
        required this.countryValue1,
        required this.InterestedInValue,
        required this.nextStepsValue,
        required this.reachOutValue,
        required this.old_image,
        required this.dateofNextStep,
      });

/*  final String docid;
  const UpdateClient({super.key, required this.docid});*/

  @override
  State<UpdateClient> createState() => _UpdateClientState();
}

class _UpdateClientState extends State<UpdateClient> {

  TextEditingController gender = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController interestedIn = TextEditingController();
  TextEditingController nextSteps = TextEditingController();
  TextEditingController reachOutIn = TextEditingController();
  TextEditingController nextStepsPlanned = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection("guest");
  TextEditingController name1 = TextEditingController();
  TextEditingController email1 = TextEditingController();
  TextEditingController mobilenumber1 = TextEditingController();
  TextEditingController addressStreet11 = TextEditingController();
  //TextEditingController addressStreet21 = TextEditingController();
  TextEditingController pincode1 = TextEditingController();
  TextEditingController companyName1 = TextEditingController();
  TextEditingController companyAddress1 = TextEditingController();
  TextEditingController companyMail1 = TextEditingController();
  TextEditingController website1 = TextEditingController();
  TextEditingController comments1 = TextEditingController();
  TextEditingController countryValue1 = TextEditingController();
  TextEditingController stateValue1 = TextEditingController();
  TextEditingController cityValue1 = TextEditingController();

  TextEditingController nextStepPlanned1 = TextEditingController();





  _buildtext(TextEditingController controller, String labelText) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }

  final TextEditingController dateOfNextStepscontroller = TextEditingController();
  DateTime? _dateofNextStep;

  String genderValue_1 = '';
  String cityValue1_1 = '';
  String stateValue1_1 = '';
  String countryValue1_1 = '';
  String interestedInValue_1 = '';
  String nextStepsValue_1 = '';
  String reachOutValue_1 = '';
  String old_image1 = '';


  var getResult = '';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClientData();
    //dbRef = FirebaseDatabase.instance.ref().child('guest');
  }

  void getClientData() async{

    CollectionReference ref = FirebaseFirestore.instance.collection("guest");
    name1.text=widget.name;
    email1.text=widget.email;
    mobilenumber1.text=widget.mobilenumber;
    addressStreet11.text=widget.addressStreet1;
    //addressStreet21.text=widget.addressStreet2;
    pincode1.text=widget.picode;
    companyName1.text=widget.companyName;
    companyAddress1.text=widget.companyAdd;
    companyMail1.text=widget.companyMail;
    website1.text=widget.website;
    comments1.text=widget.comments;
    genderValue_1 =widget.genderValue;
    stateValue1_1=widget.stateValue1;
    countryValue1_1= widget.countryValue1;
    cityValue1_1=widget.cityValue1;
    interestedInValue_1=widget.InterestedInValue;
    nextStepsValue_1=widget.nextStepsValue;
    reachOutValue_1= widget.reachOutValue;

    gender.text = genderValue_1;
    //companyMail.text = companyMail1;
    gender.text = genderValue_1;
    interestedIn.text = interestedInValue_1;
    nextSteps.text = nextStepsValue_1;
    reachOutIn.text = reachOutValue_1;



    old_image1 = widget.old_image;

    countryValue1.text = countryValue1_1;
    stateValue1.text = stateValue1_1;
    cityValue1.text = cityValue1_1;
    nextStepPlanned1.text = widget.dateofNextStep;


    // _dateofNextStep=widget.dateofNextStep;


    // DataSnapshot snapshot = await dbRef.child(widget.docid).once() as DataSnapshot;
    // Map client = snapshot.value as Map;
    //
    // name.text = client['name'];
    // email.text = client['email'];
    // addressStreet1.text = client['addressStreet1'];
    // addressStreet2.text = client['addressStreet2'];
    // pincode.text = client['pincode'];
    // companyName.text = client['companyName'];
    // companyAddress.text = client['companyAddress'];
    // companyMail.text = client['companyMail'];
    // website.text = client['website'];
    // comments.text = client['comments'];
    // dateOfNextStepscontroller.text = client['dateOfNextStepscontroller'];
    // genderValue = client['genderValue'];
    // cityValue1 = client['cityValue1'];
    // stateValue1 = client['stateValue1'];
    // countryValue1 = client['countryValue1'];
    // interestedInValue = client['interestedInValue'];
    // nextStepsValue = client['nextStepsValue'];
    // reachOutValue = client['reachOutValue'];

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
        old_image1 = Utility.base64String(_image!.readAsBytesSync());
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
                      controller: name1,
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
                      controller: mobilenumber1,
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
                      controller: email1,
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
                        value: genderValue_1,
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
                            genderValue_1 = values!;
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
                      controller: addressStreet11,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF00D3FF), width: 1),
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Enter Address :',
                        hintText: 'Full Address',
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
                          return 'Please Enter Full Address';
                        }
                        return null;
                      },
                    ),
                  ),

                /*  const Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    child: TextFormField(
                      controller: addressStreet21,
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
                  ),*/
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
                      controller: pincode1,
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

                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    child: TextFormField(
                      controller: countryValue1,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF00D3FF), width: 1),
                        ),
                        filled: true,
                        //fillColor: Color(0xFF004B8D),
                        labelText: 'Country:',
                        //hintText: 'Zip',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Card(
                            color: Color(0xFF00D3FF),
                            child: SizedBox(
                              height: 58,
                              width: 48,
                              child: Icon(
                                Icons.flag,
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

                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    child: TextFormField(
                      controller: stateValue1,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF00D3FF), width: 1),
                        ),
                        filled: true,
                        //fillColor: Color(0xFF004B8D),
                        labelText: 'State:',
                        //hintText: 'Zip',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Card(
                            color: Color(0xFF00D3FF),
                            child: SizedBox(
                              height: 58,
                              width: 48,
                              child: Icon(
                                Icons.flag,
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

                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    child: TextFormField(
                      controller: cityValue1,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF00D3FF), width: 1),
                        ),
                        filled: true,
                        //fillColor: Color(0xFF004B8D),
                        labelText: 'City:',
                        //hintText: 'Zip',
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
                      keyboardType: TextInputType.number,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Zip Code';
                        }
                        return null;
                      },
                    ),
                  ),

                  /* showCountryPicker(
                  context: context,
                  countryFilter: <String>['CD', 'CG', 'KE', 'UG'], // only specific countries
                  onSelect: (){},
                ),*/

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
                                child: old_image1 == null
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
                                      height: 200.0,
                                      width: 320.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Center(
                                        child: '${old_image1}' == null
                                            ? const Text(
                                          'No image selected',
                                          style:
                                          TextStyle(fontSize: 20),
                                        )
                                            : Hero(
                                          tag: 'emimg-"${[old_image1]}',
                                          child:
                                          Image.network(old_image1),
                                        ),
                                      )),
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
                      controller: companyName1,
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
                      controller: companyAddress1,
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
                      controller: companyMail1,
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
                      controller: website1,
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
                        value :interestedInValue_1,
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
                            interestedInValue_1 = values!;
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
                        value :nextStepsValue_1,
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
                            nextStepsValue_1 = values!;
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
                        controller: nextStepPlanned1,
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
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: DropdownButtonFormField<String>(
                        value :reachOutValue_1,
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

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Select your preference';
                          }
                          return null;
                        },

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
                            reachOutValue_1 = values!;
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
                      //controller: ,
                      controller: comments1,
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
              child: Text('Review'),
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    child: SizedBox(
                        height: 150.0,
                        width: 300.0,
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
                  ),

                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: name1,
                        readOnly: true,
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: email1,
                        readOnly: true,
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: mobilenumber1,
                        readOnly: true,
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                     SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: gender,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                          gender.text = genderValue_1;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Gender',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: addressStreet11,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Address :',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          prefixIcon: Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Card(
                              color: Color(0xFF00D3FF),
                              child: SizedBox(
                                height: 58,
                                width: 48,
                                child: Icon(
                                  Icons.area_chart,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                 /* const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: addressStreet21,
                        readOnly: true,
                        *//* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*//*
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Street 2',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),*/

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: pincode1,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Pin Code',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: cityValue1,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'City',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          prefixIcon: Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Card(
                              color: Color(0xFF00D3FF),
                              child: SizedBox(
                                height: 58,
                                width: 48,
                                child: Icon(
                                  Icons.map,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: cityValue1,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'State',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: countryValue1,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Country',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          prefixIcon: Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Card(
                              color: Color(0xFF00D3FF),
                              child: SizedBox(
                                height: 58,
                                width: 48,
                                child: Icon(
                                  Icons.flag,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: companyName1,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Company Name:',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          prefixIcon: Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Card(
                              color: Color(0xFF00D3FF),
                              child: SizedBox(
                                height: 58,
                                width: 48,
                                child: Icon(
                                  Icons.meeting_room,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: companyAddress1,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Company Add:',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                     SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: companyMail1,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Company Mail',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                     SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: website1,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'C Website',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                     SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: interestedIn,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Interested In:',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                     SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: nextSteps,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Next Steps:',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
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
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: nextStepPlanned1,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Next Steps Planned',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          prefixIcon: Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Card(
                              color: Color(0xFF00D3FF),
                              child: SizedBox(
                                height: 58,
                                width: 48,
                                child: Icon(
                                  Icons.date_range,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: reachOutIn,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Reach Out In:',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          prefixIcon: Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Card(
                              color: Color(0xFF00D3FF),
                              child: SizedBox(
                                height: 58,
                                width: 48,
                                child: Icon(
                                  Icons.area_chart,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(6),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    shadowColor: const Color(0xFF00D3FF),
                    margin: const EdgeInsets.all(05),
                    child:
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: comments1,
                        readOnly: true,
                        /* onChanged: (values){
                        setState(() {
                          genderValue = values!;
                        });
                      },*/
                        //expands: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF00D3FF), width: 1),
                          ),
                          labelText: 'Comments',
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          prefixIcon: Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Card(
                              color: Color(0xFF00D3FF),
                              child: SizedBox(
                                height: 58,
                                width: 48,
                                child: Icon(
                                  Icons.text_format,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 20,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(6),
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
          onPressed: () async {
            final docuser22 =
            FirebaseFirestore.instance
                .collection('guest')
                .doc(widget.docid);
                docuser22.update({
              'name': '${name1.text}',
              'email': '${email1.text}',
              'mobilenumber':
              '${mobilenumber1.text}',
              'gendervalue':
              '${genderValue_1}',
              'addressStreet1':
              '${addressStreet11.text}',
             /* 'addressStreet2':
              '${addressStreet21.text}',*/
              'pincode':
              '${pincode1.text}',
              'city': '${cityValue1_1}',
              'state': '${stateValue1_1}',
              'country': '${countryValue1_1}',
              'companyName':
              '${companyName1.text}',
              'companyAdd':
              '${companyAddress1.text}',
              'companyMail':
              '${companyMail1.text}',
              'website':
              '${website1.text}',
              'interestedInValue':
              '${interestedInValue_1}',
              'nextStepsValue':
              '${nextStepsValue_1}',
              'reachOutValue':
              '${reachOutValue_1}',
              'dateOfNextStepscontroller':
              '${dateOfNextStepscontroller.text}',
              'comments':
              '${comments1.text}',
              'image':
              '${urlDownload}',
            });

            Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Data Updated Successfully !"),
            ));
            await uploadFile(_image!.path);
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
                canvasColor: const Color(0xFFD4FCFF),
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: const Color(0xFF00D3FF),
                  background: Colors.red,
                  secondary: const Color(0xFFD4F8FF),
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

  Future uploadFile(String path) async {
    /*final file = File(_image!.path);
    final path = "visiting_cards/${_image!.path}";

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => null);

    urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link:$urlDownload');
    //Image.network(urlDownload);
    setState(() {

      uploadTask = null;
    });*/
    final ref=FirebaseStorage.instance.ref().child('images').child('${DateTime.now().toIso8601String()+p.basename(path)}');
    final result=await ref.putFile(File(path));
    final fileurl=await result.ref.getDownloadURL();
    setState(() {
      urlDownload=fileurl;
    });
  }
}

