import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craveiospro/update_client.dart';
import 'package:craveiospro/viewcust.dart';
import 'package:flutter/material.dart';
import 'package:craveiospro/main.dart';
import 'package:intl/intl.dart';

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
    CollectionReference users = FirebaseFirestore.instance.collection("guest2");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Details'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.update,
              color: Colors.white,
            ),
            onPressed: () {
             /* Navigator.push(context, MaterialPageRoute(
                  builder: (context) => UpdateClient(docid: widget.docid,)));*/
              showAlertDialog(BuildContext context) {
                // set up the buttons
                Widget cancelButton = TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {},
                );
                Widget continueButton = TextButton(
                  child: const Text("Continue"),
                  onPressed: () {},
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: const Text("AlertDialog"),
                  content: const Text(
                      "Would you like to continue With Update this Record?"),
                  actions: [
                    cancelButton,
                    continueButton,
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              deleteUser(widget.docid);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Data Deleted Successfully !"),
              ),
              );
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewCustomer()));
              showAlertDialog(BuildContext context) {
                // set up the buttons
                Widget cancelButton = TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {},
                );
                Widget continueButton = TextButton(
                  child: const Text("Yes"),
                  onPressed: () {},
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
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
            },
          )
        ],
        backgroundColor: const
        Color(0xFF00D3FF),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(widget.docid).get(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

              //this is for Single User View
              name1.text = '${data['name']}';
              addressStreet1_1.text = '${data['addressStreet1']}';
              addressStreet2_1.text = '${data['addressStreet2']}';
              email1.text = '${data['email']}';
              mobileNumber1.text = '${data['mobilenumber']}';
              country1.text = '${data['countryValue1']}';
              city1.text = '${data['cityValue1']}';
              state1.text = '${data['stateValue1']}';
              pincode1.text = '${data['pincode']}';
              companyAddress1.text = '${data['companyAdd']}';
              companyName1.text = '${data['companyName']}';
              companyMail1.text ='${data['companyMail']}';
              website1.text ='${data['website']}';
              comments1.text ='${data['comments']}';
              reachOutValue1.text = '${data['reachOutValue']}';
              nextStepsValue1.text = '${data['nextStepsValue']}';
              //genderValue1.text = '${data['genderValue']}';
              interestedIn1.text = '${data['interestedInValue']}';
              nextStepsPlanned1.text = '${data['dateOfNextStepscontroller']}';




              return Padding(
                padding: const EdgeInsets.all(08.0),
                child: Flexible(
                  // height: double.infinity,
                  // width: double.infinity,
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              name = data['name'];
                              email = data['email'];
                              mobilenumber = data['mobilenumber'];
                              pincode = data['pincode'];
                              addressStreet1 = data['addressStreet1'];
                              addressStreet2 = data['addressStreet2'];
                              companyName = data['companyName'];
                              website = data['website'];
                              companyAddress = data['companyAdd'];
                              companyMail = data['companyMail'];
                              comments = data['comments'];
                            //  genderValue = data['genderValue1'];
                              cityValue1 = data['cityValue1'];
                              countryValue1 = data['countryValue1'];
                              stateValue1 = data['stateValue1'];
                              interestedInValue = data['interestedInValue'];
                              nextStepsValue = data['nextStepsValue'];
                              reachOutValue = data['reachOutValue'];
                              // _dateofNextStep = data['dateOfNextStepscontroller'];
                              // DateTime parseDate =
                              // DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateOfNextStepscontroller);


                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context) =>  UpdateClient(docid: widget.docid,
                                name: name,
                                email: email,
                                addressStreet1: addressStreet1,
                                addressStreet2: addressStreet2,
                                companyName: companyName,
                                mobilenumber: mobilenumber,
                                companyAdd: companyAddress,
                                companyMail: companyMail,
                                picode: pincode,
                                comments: comments,
                                website: website,
                                    //genderValue: genderValue,
                                    cityValue1: cityValue1,
                                    stateValue1: stateValue1,
                                    countryValue1: countryValue1,
                                    InterestedInValue: interestedInValue,
                                    nextStepsValue: nextStepsValue,
                                    reachOutValue:reachOutValue,
                                    // dateofNextStep: _dateofNextStep,

                              )));

                            },
                            child: const Text('Edit Client Details'),
                          ),

                          Card(
                            //semanticContainer: true,
                            elevation: 10,
                            shadowColor: const Color(0xFF00D3FF),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                //color: Colors.greenAccent,
                                width: 1,
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.white,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, top: 5, bottom: 5),
                                  child: Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0)
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              height: 150.0,
                                            ),
                                            Center(
                                              child: Container(
                                                 height: 200.0,
                                                  width: 320.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  child: Center(
                                                    child: '${data['image']}' == null
                                                        ? const Text(
                                                      'No image selected',
                                                      style:
                                                      TextStyle(fontSize: 20),
                                                    )
                                                        : Hero(
                                                      tag: 'emimg-"${data['image']}',
                                                      child:
                                                      Container(
                                                        child: Image.network(
                                                            '${data['image']}'),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            const SizedBox(height: 40,),
                                          ],
                                        ),
                                      ),

                                      const Padding(
                                        padding: EdgeInsets.all(10),
                                      ),

                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
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
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                /*       Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(width: 1,color: const Color(0xFF00D3FF),),
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            ),
                                            child: Row(
                                              //mainAxisAlignment: MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                     const Text(
                                                      'Name : ',
                                                      style: TextStyle(fontSize: 20,
                                                          fontWeight: FontWeight.w600
                                                      ),
                                                       //textAlign: TextAlign.center,
                                                ),

                                                Text(
                                                  '${data['name']}',
                                                  style: const TextStyle(fontSize: 20
                                                  ),
                                                  maxLines: 2,
                                                ),
                                                const SizedBox(height: 40,),
                                              ],
                                            ),
                                        ),
                                      ),*/



                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
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
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child:
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: genderValue1,
                                            readOnly: true,
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
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),


                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child:
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: mobileNumber1,
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
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),


                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child:
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: addressStreet1_1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF), width: 1),
                                              ),
                                              labelText: 'Street 1',
                                              labelStyle: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child:
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: addressStreet2_1,
                                            readOnly: true,
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
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
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
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF), width: 1),
                                              ),
                                              labelText: 'PinCode',
                                              labelStyle: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),


                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child:
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: city1,
                                            readOnly: true,
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
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child:
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: state1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF), width: 1),
                                              ),
                                              labelText: 'State:',
                                              labelStyle: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child:
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: country1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF), width: 1),
                                              ),
                                              labelText: 'Country :',
                                              labelStyle: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
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
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
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
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF), width: 1),
                                              ),
                                              labelText: 'Company Address:',
                                              labelStyle: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
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
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF), width: 1),
                                              ),
                                              labelText: 'Company Mail:',
                                              labelStyle: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
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
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF), width: 1),
                                              ),
                                              labelText: 'Website :',
                                              labelStyle: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child:
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: interestedIn1,
                                            readOnly: true,
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
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child:
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: nextStepsValue1,
                                            readOnly: true,
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
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child:
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: reachOutValue1,
                                            readOnly: true,
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
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child:
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: nextStepsPlanned1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF), width: 1),
                                              ),
                                              labelText: 'Date Of Next Step Planned :',
                                              labelStyle: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),

                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
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
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF), width: 1),
                                              ),
                                              labelText: 'Comments :',
                                              labelStyle: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
          ),
      ),

    );
  }

  // For Deleting USer
  CollectionReference guests =
  FirebaseFirestore.instance.collection('guest2');


  Future<void> deleteUser(id) {
    //print("User Deleted $id");
    return guests
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete User: $error'));
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
          .collection("guest2")
          .doc(id)
          .delete();
    } catch (e) {
      return false;
    }
  }*/

}