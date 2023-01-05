import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craveiospro/singleuser.dart';
import 'package:flutter/material.dart';

class ReadUsers extends StatelessWidget {
  final String docid;
  const ReadUsers({super.key, required this.docid});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("guest");
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(docid).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (((context) =>
                            Singleuserread(docid: docid)))));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    //color: Colors.greenAccent,
                    width: 1,
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: const Color.fromARGB(255, 173, 238, 248),
                elevation: 10,
                shadowColor: const Color(0xFF00D3FF),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Text(
                    'Name : ${data['name']}\n'
                        'Email : ${data['email']}\n'
                        'Gender : ${data['genderValue']}\n'
                        'City : ${data['cityValue1']}\n'
                        'State : ${data['stateValue1']}\n'
                        'Country : ${data['countryValue1']}\n'
                        'Company : ${data['companyName']}\n',
                        //'Next Steps Planned : ${data['dateOfNextStepscontroller']}\n'
                        // 'Website : ${data['website']}\n'
                        // 'Interested In : ${data['interestedInValue']}'
                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }));
  }
}