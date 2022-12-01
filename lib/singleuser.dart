import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Singleuserread extends StatefulWidget {
  final String docid;
  Singleuserread({required this.docid});

  @override
  State<Singleuserread> createState() => _SingleuserreadState();
}

class _SingleuserreadState extends State<Singleuserread> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("guest");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single User View'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(widget.docid).get(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              //color: Colors.greenAccent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Color.fromARGB(255, 198, 243, 238),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Name: ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(width: 0,),
                                        Text(
                                          '${data['name']}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 50,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Email: ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          '${data['email']}',
                                          style: TextStyle(fontSize: 20),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Mobile Number: ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          '${data['mobilenumber']}',
                                          style: TextStyle(fontSize: 20),
                                        )
                                        ,
                                        SizedBox(height: 50,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Pincode: ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          '${data['pincode']}',
                                          style: TextStyle(fontSize: 20),
                                        )
                                        ,
                                        SizedBox(height: 50,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'State: ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          '${data['state']}',
                                          style: TextStyle(fontSize: 20),
                                        )
                                        ,
                                        SizedBox(height: 50,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Country: ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          '${data['country']}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 50,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Company Name: ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          '${data['companyName']}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 50,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Company Address: ',
                                          style: TextStyle(fontSize: 20),
                                        ),

                                        Text(
                                          '${data['companyAdd']}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 50,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'City Address: ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          '${data['addressCity']}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 50,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Address Street 1: ',
                                          style: TextStyle(fontSize: 20),
                                        ),

                                        Text(
                                          '${data['addressStreet1']}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 50,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Address Street 2: ',
                                          style: TextStyle(fontSize: 20),
                                        ),

                                        Text(
                                          '${data['addressStreet1']}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 10,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Mobile Number: ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(
                                          '${data['mobilenumber']}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 50,),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          })),
    );
  }
}
