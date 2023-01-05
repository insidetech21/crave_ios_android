import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';

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
        title: const Text('Client Details'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.update,
              color: Colors.white,
            ),
            onPressed: () {
              showAlertDialog(BuildContext context) {
                // set up the buttons
                Widget cancelButton = TextButton(
                  child: const Text("Cancel"),
                  onPressed:  () {},
                );
                Widget continueButton = TextButton(
                  child: const Text("Continue"),
                  onPressed:  () {},
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: const Text("AlertDialog"),
                  content: const Text("Would you like to continue With Update this Record?"),
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
              showAlertDialog(BuildContext context) {
                // set up the buttons
                Widget cancelButton = TextButton(
                  child: const Text("Cancel"),
                  onPressed:  () {},
                );
                Widget continueButton = TextButton(
                  child: const Text("Yes"),
                  onPressed:  () {},
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
                            color: const Color.fromARGB(255, 255, 255, 255),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 5, bottom: 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Name : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0),
                                          Text(
                                            '${data['name']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Email : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['email']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const Text(
                                            'Gender : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['genderValue']}',
                                            style: const TextStyle(fontSize: 20),
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Mobile Number : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['mobilenumber']}',
                                            style: const TextStyle(fontSize: 20),
                                          )
                                          ,
                                          const SizedBox(height: 40,),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Address Street 1 : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),

                                          Text(
                                            '${data['addressStreet1']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 3,
                                          ),
                                          const SizedBox(height: 40),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Address Street 2 : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                            //maxLines: 2,
                                          ),

                                          Text(
                                            '${data['addressStreet2']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 3,
                                          ),
                                          const SizedBox(height: 40),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Pincode : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['pincode']}',
                                            style: const TextStyle(fontSize: 20),
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const Text(
                                            'City Name : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['cityValue1']}',
                                            style: const TextStyle(fontSize: 20),
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const Text(
                                            'State : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['stateValue1']}',
                                            style: const TextStyle(fontSize: 20),
                                          )
                                          ,
                                          const SizedBox(height: 40,),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Country : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['countryValue1']}',
                                            style: const TextStyle(fontSize: 20),
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'C-Name : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                            //maxLines: 2,
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['companyName']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'C-Add : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),

                                          Text(
                                            '${data['companyAdd']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'C-Mail : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),

                                          Text(
                                            '${data['companyMail']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const Text(
                                            'Website : ',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['website']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const Text(
                                            'Interested In :',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data["interestedInValue"]}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const Text(
                                            'Next Steps :',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['nextStepsValue']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const Text(
                                            'Reach Out In :',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['reachOutValue']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const Text(
                                            'D-N-S Planned :',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['dateOfNextStepscontroller']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const Text(
                                            'Comments :',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const SizedBox(width: 0,),
                                          Text(
                                            '${data['comments']}',
                                            style: const TextStyle(fontSize: 20
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 40,),
                                        ],
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
          })),

    );
  }
}
