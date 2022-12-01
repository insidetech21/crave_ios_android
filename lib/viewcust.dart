import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craveiospro/readusers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';

final userref=FirebaseFirestore.instance.collection("guest");
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
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('View Data')),
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
    );
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'main.dart';
//
// class ViewGuest extends StatefulWidget {
//   const ViewGuest({super.key});
//
//   @override
//   State<ViewGuest> createState() => _ViewGuestState();
// }
//
// Stream<List<Guest>> readuser() => FirebaseFirestore.instance
//     .collection('guest')
//     .snapshots()
//     .map((snapshot)
// =>snapshot.docs.map((doc) => Guest.fromJson(doc.data())).toList());
//
// Widget buildUser(Guest guest) => Card(
//   child:
//   Column(children: [
//     Text(guest.id),
//     Text(guest.name),
//     Text(guest.email),
//     Text(guest.mobilenumber),
//     //Text(guest.gender),
//     Text(guest.addressStreet1),
//     Text(guest.addressStreet2),
//     Text(guest.pincode),
//     Text(guest.addressCity),
//     Text(guest.state),
//     Text(guest.country),
//     Text(guest.companyName),
//     Text(guest.companyAdd),
//
//     //Text('${guest.companyAdd}'),
//     //Text(${cust.id})
//   ],)
//
// );
//
//
// class _ViewGuestState extends State<ViewGuest> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('View data'),
//         ),
//         body: StreamBuilder(
//           stream: readuser(),
//           builder: ((context, snapshot) {
//             // if(snapshot.hasError){
//             //   return Text('something went wrong');
//             // }
//             if(snapshot.hasError){
//              return Text("Something Went Wrong ! ${snapshot.data}");
//             }
//             else if (snapshot.hasData){
//               final guest = snapshot.data!;
//               return ListView(
//                   children: guest.map<Widget>(buildUser).toList(),
//               );
//             }
//             else
//             {
//               return const Center(child: CircularProgressIndicator());
//               //return Text("Data");
//             }
//           }),
//         ),
//       ),
//     );
//   }
// }