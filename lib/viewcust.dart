import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'main.dart';

class ViewCustomeer extends StatefulWidget {
  const ViewCustomeer({super.key});

  @override
  State<ViewCustomeer> createState() => _ViewCustomeerState();
}

Stream<List<Customer>> readuser() => FirebaseFirestore.instance.collection('guest').snapshots().map((snapshot) 
=>snapshot.docs.map((doc) => Customer.fromJson(doc.data())).toList() );

Widget buildUser(Customer cust) => Card(
  
  child:
  Column(children: [
    Text('${cust.name}'),
    Text('${cust.email}'),
    Text('${cust.mobilenumber}'),
    Text('${cust.pincode}'),
    //Text(${cust.id})

  ],)
  

);

class _ViewCustomeerState extends State<ViewCustomeer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('view data'),
          
        ),
        body: StreamBuilder(
          stream: readuser(),
          builder: ((context, snapshot) {
            // if(snapshot.hasError){
            //   return Text('something went wrong');
            // }
            if(snapshot.hasData){
              dynamic cust=snapshot.data!;
              return ListView(
                children: cust.map<Widget>(buildUser).toList(),
            );
              
            }
            else{
              return Text("data");
            }
          }
          ),
        ),
      ),
    );
  }
}