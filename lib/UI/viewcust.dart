import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craveiospro/Database/firebase_database.dart';
import 'package:craveiospro/readusers.dart';
import 'package:craveiospro/UI/singleuser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '../customer.dart';
import '../main.dart';

final userref=FirebaseFirestore.instance.collection("guest");
List<String> itemList = [];
List<String> distinctIds=[];
final CollectionReference _reff=FirebaseFirestore.instance.collection('guest');
//Firebase_Database fr=Firebase_Database();

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

Stream<List<Customer>> readuser() => FirebaseFirestore.instance.collection('guest').snapshots().map((snapshot)
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

  await FirebaseFirestore.instance.collection("guest").get().
  then((snapshot) => snapshot.docs.forEach((element) {
    itemList.add(element.reference.id);
    distinctIds = LinkedHashSet<String>.from(itemList).toList();
  }));
  return const Center(child: CircularProgressIndicator());
}


class _ViewCustomerState extends State<ViewCustomer> {
  @override
  Widget build(BuildContext context) {
    final fr=Provider.of<Firebase_Database>(context,listen: false);
    return Scaffold(
          appBar: AppBar(
            title: const Text('Client Data'),
            backgroundColor: const Color(0xFF00D3FF),
          ),
          body: fr.Listallusers(),
      );
      //debugShowCheckedModeBanner: false,
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

