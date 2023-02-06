import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craveiospro/Database/firebase_database.dart';
import 'package:craveiospro/UI/dashboard_screen.dart';
import 'package:craveiospro/UI/viewcust.dart';
import '../UI/Stepper/update_client .dart';
import 'package:flutter/material.dart';
import 'package:craveiospro/main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Singleuserread extends StatefulWidget {

  final String docid;

  Singleuserread({required this.docid});

  @override
  State<Singleuserread> createState() => _SingleuserreadState();
}

class _SingleuserreadState extends State<Singleuserread> {

  Uint8List? _bytesImage;

  String genderValue = '';
  String cityValue1 = '';
  String stateValue1 = '';
  String countryValue1 = '';
  String interestedInValue = '';
  String nextStepsValue = '';
  String reachOutValue = '';
  String name = "";
  String email = '';
  String mobilenumber = '';
  String addressStreet1 ='';
  String addressStreet2 = '';
  String pincode = '';
  String companyName = '';
  String companyAddress = '';
  String companyMail = '';
  String website = '';
  String comments = '';
  String old_image = "";
  String dateOfNextStepPlanned = "";

  // String dateOfNextStepscontroller = '';
  //
  // DateTime? _dateofNextStep;


  //this Controller is for Single User View
  TextEditingController name1 = TextEditingController();
  TextEditingController email1 = TextEditingController();
  TextEditingController mobileNumber1 = TextEditingController();
  TextEditingController state1 = TextEditingController();
  TextEditingController city1 = TextEditingController();
  TextEditingController country1 = TextEditingController();
  TextEditingController genderValue1 = TextEditingController();
  TextEditingController companyName1 = TextEditingController();
  TextEditingController companyMail1 = TextEditingController();
  TextEditingController companyAddress1 = TextEditingController();
  TextEditingController website1 = TextEditingController();
  TextEditingController comments1 = TextEditingController();
  TextEditingController pincode1 = TextEditingController();
  TextEditingController addressStreet1_1= TextEditingController();
  TextEditingController addressStreet2_1 = TextEditingController();
  TextEditingController reachOutValue1 = TextEditingController();
  TextEditingController nextStepsValue1 = TextEditingController();
  TextEditingController nextStepsPlanned1 = TextEditingController();
  TextEditingController interestedIn1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("guest");
    final fr=Provider.of<Firebase_Database>(context,listen: false);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Details'),
        actions: <Widget>[
          /*IconButton(
            icon: const Icon(
              Icons.update,
              color: Colors.white,
            ),
            onPressed: () {
             *//* Navigator.push(context, MaterialPageRoute(
                  builder: (context) => UpdateClient(docid: widget.docid,)));*//*
            },
          ),*/
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              //Navigator.pop(context);
              showAlertDialog_delete(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewCustomer()));
            },
          )
        ],
        backgroundColor: const
        Color(0xFF00D3FF),
      ),
      body: fr.ListSingleuser(name1,
       addressStreet1_1, email1,
        mobileNumber1, country1, city1, 
        state1, pincode1, companyAddress1,
         companyName1, companyMail1, website1, 
         comments1, reachOutValue1, nextStepsValue1,
          genderValue1, interestedIn1, nextStepsPlanned1, widget.docid)

    );
  }

  

  showAlertDialog_delete(BuildContext context) {
    // set up the buttons
    
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        //Navigator.of(context).pop();
        //duration: const Duration(seconds: 2);
        //alertDialog.actions?.clear();
        // alertDialogue
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        final fr=Provider.of<Firebase_Database>(context,listen: false);
        fr.deleteUser(widget.docid);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Data Deleted Successfully !"),
          //duration: Duration(seconds: 2),
        ),
        );

        },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("AlertDialog"),
      content: const Text("Do You Want to Delete this record ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context ) {
        return alert;
      },
      barrierDismissible: true,
    );
  }

/*  Future<void> pickDateOfBirth(BuildContext context) async {
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
      _dateofNextStep = newDate;
      String dob = DateFormat('dd/MM/yyy').format(newDate);

      // dateOfNextStepscontroller = dob;
    });
  }*/

/* Future deleteUser(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("guest")
          .doc(id)
          .delete();
    } catch (e) {
      return false;
    }
  }*/

}