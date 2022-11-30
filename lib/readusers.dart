import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ReadUsers extends StatelessWidget {
  final String docid;
  ReadUsers({required this.docid});

  @override
  Widget build(BuildContext context) {
    CollectionReference users=FirebaseFirestore.instance.collection("guest");
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(docid).get(),
        builder: ((context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done){
            Map<String, dynamic> data=snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Card(
                  child: Text(
                      'name: ${data['name']}'
                          +'\nMobile number: ${data['mobilenumber']}'
                          +'\nEmail: ${data['email']}'
                          +'\nPincode: ${data['Pincode']}'
                          +'\nAdressStreet1: ${data['addressStreet1']}'
                          +'\nAddressStreet2: ${data['addressStreet2']}'
                          +'\nCity: ${data['addressCity']}'
                          +'\nState: ${data['state']}'
                          +'\nCountry: ${data['country']}'
                          +'\nComapny Name: ${data['comapnyName']}'
                          +'\nComapny Address: ${data['comapanyAdd']}'



                  ),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }));
  }
}