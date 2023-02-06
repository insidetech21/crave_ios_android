import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../UI/Stepper/update_client .dart';
import '../customer.dart';
import '../UI/singleuser.dart';

class Firebase_Database with ChangeNotifier {
  final docuser = FirebaseFirestore.instance.collection('guest').doc();

  final CollectionReference _reff =
      FirebaseFirestore.instance.collection('guest');

  Future createuser({
    required String image,
    name,
    email,
    genderValue,
    mobilenumber,
    addressStreet1,
    //addressStreet2,
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
    final customer = Customer(
      id: docuser.id,
      image: image,
      name: name,
      email: email,
      genderValue: genderValue,
      mobilenumber: mobilenumber,
      addressStreet1: addressStreet1,
      //addressStreet2: addressStreet2,
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
    notifyListeners();
  }

  StreamBuilder<QuerySnapshot<Object?>> Listallusers() {
    return StreamBuilder(
      stream: _reff.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (((context) =>
                              Singleuserread(docid: documentSnapshot.id)))));
                },
                child: Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color(0xFF00D3FF),
                      width: 1,
                      //color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  shadowColor: const Color(0xFF00D3FF),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      'Name : ${documentSnapshot['name']}\n'
                      'Email : ${documentSnapshot['email']}\n'
                      // 'Gender : ${documentSnapshot['genderValue']}\n'
                      'City : ${documentSnapshot['cityValue1']}\n'
                      // 'State : ${documentSnapshot['stateValue1']}\n'
                      // 'Country : ${documentSnapshot['countryValue1']}\n'
                      'Company : ${documentSnapshot['companyName']}\n',
                      //'Next Steps Planned : ${data['dateOfNextStepscontroller']}\n'
                      // 'Website : ${data['website']}\n'
                      // 'Interested In : ${data['interestedInValue']}'
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              );
            },
          );
        }
        notifyListeners();
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  FutureBuilder<DocumentSnapshot<Object?>> ListSingleuser(
    TextEditingController name1,
    TextEditingController addressStreet1_1,
    TextEditingController email1,
    TextEditingController mobileNumber1,
    TextEditingController country1,
    TextEditingController city1,
    TextEditingController state1,
    TextEditingController pincode1,
    TextEditingController companyAddress1,
    TextEditingController companyName1,
    TextEditingController companyMail1,
    TextEditingController website1,
    TextEditingController comments1,
    TextEditingController reachOutValue1,
    TextEditingController nextStepsValue1,
    TextEditingController genderValue1,
    TextEditingController interestedIn1,
    TextEditingController nextStepsPlanned1,
    String docid,
  ) {
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
    String addressStreet1 = '';
    String addressStreet2 = '';
    String pincode = '';
    String companyName = '';
    String companyAddress = '';
    String companyMail = '';
    String website = '';
    String comments = '';
    String old_image = "";
    String dateOfNextStepPlanned = "";

    return FutureBuilder<DocumentSnapshot>(
      future: _reff.doc(docid).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          //this is for Single User View
          name1.text = '${data['name']}';
          addressStreet1_1.text = '${data['addressStreet1']}';
          //addressStreet2_1.text = '${data['addressStreet2']}';
          email1.text = '${data['email']}';
          mobileNumber1.text = '${data['mobilenumber']}';
          country1.text = '${data['countryValue1']}';
          city1.text = '${data['cityValue1']}';
          state1.text = '${data['stateValue1']}';
          pincode1.text = '${data['pincode']}';
          companyAddress1.text = '${data['companyAdd']}';
          companyName1.text = '${data['companyName']}';
          companyMail1.text = '${data['companyMail']}';
          website1.text = '${data['website']}';
          comments1.text = '${data['comments']}';
          reachOutValue1.text = '${data['reachOutValue']}';
          nextStepsValue1.text = '${data['nextStepsValue']}';
          genderValue1.text = '${data['genderValue']}';
          interestedIn1.text = '${data['interestedInValue']}';
          nextStepsPlanned1.text = '${data['dateOfNextStepscontroller']}';

          return Padding(
            padding: const EdgeInsets.all(08.0),
            child: Column(
              children: [
                Flexible(
                  // height: double.infinity,
                  // width: double.infinity,
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
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
                                                    child: '${data['image']}' ==
                                                            null
                                                        ? const Text(
                                                            'No image selected',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )
                                                        : Hero(
                                                            tag:
                                                                'emimg-"${data['image']}',
                                                            child: Container(
                                                              child: Image.network(
                                                                  '${data['image']}'),
                                                            ),
                                                          ),
                                                  )),
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(10),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: name1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: email1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: genderValue1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: mobileNumber1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: addressStreet1_1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
                                              ),
                                              labelText: 'Address :',
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
                                      /* Card(
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
                                          ),*/

                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: pincode1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: city1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: state1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: country1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: companyName1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: companyAddress1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: companyMail1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: website1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: interestedIn1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: nextStepsValue1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: reachOutValue1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: nextStepsPlanned1,
                                            readOnly: true,
                                            //expands: trguestue,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
                                              ),
                                              labelText:
                                                  'Date Of Next Step Planned :',
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 15,
                                        shadowColor: const Color(0xFF00D3FF),
                                        margin: const EdgeInsets.all(05),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: comments1,
                                            readOnly: true,
                                            //expands: true,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF00D3FF),
                                                    width: 1),
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
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
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

                    name = data['name'];
                    email = data['email'];
                    mobilenumber = data['mobilenumber'];
                    pincode = data['pincode'];
                    addressStreet1 = data['addressStreet1'];
                    //addressStreet2 = data['addressStreet2'];
                    companyName = data['companyName'];
                    website = data['website'];
                    companyAddress = data['companyAdd'];
                    companyMail = data['companyMail'];
                    comments = data['comments'];
                    genderValue = data['genderValue'];
                    cityValue1 = data['cityValue1'];
                    countryValue1 = data['countryValue1'];
                    stateValue1 = data['stateValue1'];
                    interestedInValue = data['interestedInValue'];
                    nextStepsValue = data['nextStepsValue'];
                    reachOutValue = data['reachOutValue'];
                    old_image = data['image'];
                    dateOfNextStepPlanned = data['dateOfNextStepscontroller'];

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateClient(
                                  docid: docid,
                                  name: name,
                                  email: email,
                                  addressStreet1: addressStreet1,
                                  //addressStreet2: addressStreet2,
                                  companyName: companyName,
                                  mobilenumber: mobilenumber,
                                  companyAdd: companyAddress,
                                  companyMail: companyMail,
                                  picode: pincode,
                                  comments: comments,
                                  website: website,
                                  genderValue: genderValue,
                                  cityValue1: cityValue1,
                                  stateValue1: stateValue1,
                                  countryValue1: countryValue1,
                                  InterestedInValue: interestedInValue,
                                  nextStepsValue: nextStepsValue,
                                  reachOutValue: reachOutValue,
                                  old_image: old_image,
                                  dateofNextStep: dateOfNextStepPlanned,
                                  // dateofNextStep: _dateofNextStep,
                                )));
                  },
                  child: const Text('Edit Client Details'),
                ),
              ],
            ),
          );
          
        }
        notifyListeners();
        return const Center(child: CircularProgressIndicator());
        
      }),
      
    );
  
  }

  Future<void> deleteUser(id) {
    //print("User Deleted $id");
    
    return _reff
        .doc(id)
        .delete()
        .then((value) => notifyListeners())
        .catchError((error) => print('Failed to Delete User: $error'));
        
  }

  void update(
    String docid,
    TextEditingController name1,
    TextEditingController email1,
    TextEditingController mobilenumber1,
    String genderValue_1,
    TextEditingController addressStreet11,
    TextEditingController pincode1,
    String cityValue1_1,
    String stateValue1_1,
    String countryValue1_1,
    TextEditingController companyName1,
    TextEditingController companyAddress1,
    TextEditingController companyMail1,
    TextEditingController website1,
    String interestedInValue_1,
    String nextStepsValue_1,
    String reachOutValue_1,
    TextEditingController dateOfNextStepscontroller,
    TextEditingController comments1,
    String urlDownload,
  ) {
    final docuser22 = FirebaseFirestore.instance.collection('guest').doc(docid);
    docuser22.update({
      'name': '${name1.text}',
      'email': '${email1.text}',
      'mobilenumber': '${mobilenumber1.text}',
      'gendervalue': '${genderValue_1}',
      'addressStreet1': '${addressStreet11.text}',
      /* 'addressStreet2':
              '${addressStreet21.text}',*/
      'pincode': '${pincode1.text}',
      'city': '${cityValue1_1}',
      'state': '${stateValue1_1}',
      'country': '${countryValue1_1}',
      'companyName': '${companyName1.text}',
      'companyAdd': '${companyAddress1.text}',
      'companyMail': '${companyMail1.text}',
      'website': '${website1.text}',
      'interestedInValue': '${interestedInValue_1}',
      'nextStepsValue': '${nextStepsValue_1}',
      'reachOutValue': '${reachOutValue_1}',
      'dateOfNextStepscontroller': '${dateOfNextStepscontroller.text}',
      'comments': '${comments1.text}',
      'image': '${urlDownload}',
    });
    notifyListeners();
  }
}
