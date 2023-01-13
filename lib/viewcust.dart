import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craveiospro/readusers.dart';
import 'package:craveiospro/singleuser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';

final userref=FirebaseFirestore.instance.collection("guest2");
List<String> itemList = [];
List<String> distinctIds=[];
final CollectionReference _reff=FirebaseFirestore.instance.collection('guest2');

@override
void initState() {
  getUserList();
  initState();

}

class ViewCustomer extends StatefulWidget {
  const ViewCustomer({super.key});

  @override
  State<ViewCustomer> createState() => _ViewCustomerState();
}

Stream<List<Customer>> readuser() => FirebaseFirestore.instance.collection('guest2').snapshots().map((snapshot)
=>snapshot.docs.map((doc) => Customer.fromJson(doc.data())).toList() );

Widget buildUser(Customer cust) => Card(
    child:
    Column(children: [
      Text(cust.name),
      Text(cust.email),
      Text(cust.mobilenumber),
      Text(cust.pincode),
      //Text(${cust.id})

    ],)


);

//Future<List?> getUserList() async {

Future<Center> getUserList() async { // Added List? for better typing

  await FirebaseFirestore.instance.collection("guest2").get().
  then((snapshot) => snapshot.docs.forEach((element) {
    itemList.add(element.reference.id);
    distinctIds = LinkedHashSet<String>.from(itemList).toList();
  }));
  return const Center(child: CircularProgressIndicator());
}


class _ViewCustomerState extends State<ViewCustomer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Client Data')),
            backgroundColor: const Color(0xFF00D3FF),
          ),
          body: StreamBuilder(
            stream: _reff.snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot=
                    snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (((context) =>
                                    Singleuserread(docid:documentSnapshot.id)))));
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
                          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
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
                              style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                            ),
                          ),
                      ),
                    );
                  },
                );

              }
              return const Center(
                child: CircularProgressIndicator(),
              );

            },)
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


/*import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craveiospro/readusers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';

final userref=FirebaseFirestore.instance.collection("guest2");
List<String> itemList = [];
List<String> distinctIds=[];

@override
void initState() {
  getUserList();
  initState();

}

class ViewCustomer extends StatefulWidget {
  const ViewCustomer({super.key});

  @override
  State<ViewCustomer> createState() => _ViewCustomerState();
}

Stream<List<Customer>> readuser() => FirebaseFirestore.instance.collection('guest2').snapshots().map((snapshot)
=>snapshot.docs.map((doc) => Customer.fromJson(doc.data())).toList() );

Widget buildUser(Customer cust) => Card(
    child:
    Column(children: [
      Text(cust.name),
      Text(cust.email),
      Text(cust.mobilenumber),
      Text(cust.pincode),
      //Text(${cust.id})

    ],)


);

//Future<List?> getUserList() async {

Future<Center> getUserList() async { // Added List? for better typing

  await FirebaseFirestore.instance.collection("guest2").get().
  then((snapshot) => snapshot.docs.forEach((element) {
    itemList.add(element.reference.id);
    distinctIds = LinkedHashSet<String>.from(itemList).toList();
  }));
  return const Center(child: CircularProgressIndicator());
}


class _ViewCustomerState extends State<ViewCustomer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.white,
            ),
            centerTitle: true,
            title: const Center(child: Text('Client Data'),
            ),
            backgroundColor: const Color(0xFF00D3FF),
          ),
          body: FutureBuilder(
            future: getUserList(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: distinctIds.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                        title: ReadUsers(docid: distinctIds[index],)
                    );
                  }));
            },)
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}*/

