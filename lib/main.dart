import 'package:craveiospro/viewcust.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
   const MyApp()
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crave Guest Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  int _activeStepIndex = 0;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  //TextEditingController gender = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

//
//   String result = "Hello World...!";
//   Future _scanQR() async {
//     var cameraStatus = await Permission.camera.status;
//     if(cameraStatus.isGranted)
//     {
//       String? qrdata = await scanner.scan();
//       print(qrdata);
//     }
//     else{
//       var isGrant = await Permission.camera.request();
//
//       if(isGrant.isGranted){
//         String? qrdata = await scanner.scan();
//         print(qrdata);
//       }
//     }
//     try {
//       String? cameraScanResult = await scanner.scan();
//       setState(() {
//         result = cameraScanResult!; // setting string result with cameraScanResult
//       });
//     } on PlatformException catch (e) {
//       print(e);
//     }
//

  List<Step> stepList()=> [
    Step(
      state: _activeStepIndex<= 0? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Personal\nDetails'),
      content: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 25.0, right: 30.0, bottom: 25.0, left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Name',
                hintText: 'Full Name',
                icon: Icon(Icons.person),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
            TextFormField(
              controller: mobilenumber,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Mobile Number',
                hintText: 'Mobile Number',
                icon: Icon(Icons.call),
              ),
              keyboardType: TextInputType.number,
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Email Id',
                hintText: 'Email Id',
                icon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            // TextFormField(
            //   controller: email,
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     filled: true,
            //     labelText: 'Select Gender',
            //     hintText: 'Gender',
            //     icon: Icon(Icons.people),
            //   ),
            //   keyboardType: TextInputType.text,
            // ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                iconSize: 32,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: 'Select Gender',
                  hintText: 'Gender',
                  icon: Icon(Icons.people_rounded),
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent,),
                items: <String>['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );

                }).toList(),
                onChanged: (values) {setState(() {

                });},
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
            TextFormField(
              controller: address,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Street 1:',
                hintText: 'Street 1 Address',
                icon: Icon(Icons.location_city),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Street 2:',
                hintText: 'Street 2 Address',
                icon: Icon(Icons.home),
              ),
              keyboardType: TextInputType.number,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter City:',
                hintText: 'City',
                icon: Icon(Icons.location_city),
              ),
              keyboardType: TextInputType.text,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              controller: pincode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Zip Code:',
                hintText: 'Zip',
                icon: Icon(Icons.pin),
              ),
              keyboardType: TextInputType.text,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter State:',
                hintText: 'State',
                icon: Icon(Icons.map),
              ),
              keyboardType: TextInputType.text,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Country:',
                hintText: 'Country',
                icon: Icon(Icons.flag),
              ),
              keyboardType: TextInputType.text,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),


          ],
        ),
      ),
),


    // Step(
    //   state: _activeStepIndex<= 1? StepState.editing : StepState.complete,
    //   isActive: _activeStepIndex >= 1,
    //   title: const Text('Full\nAddress'),
    //   content: SingleChildScrollView(
    //     padding: const EdgeInsets.only(top: 25.0, right: 30.0, bottom: 25.0, left: 10.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.end,
    //       children: <Widget>[
    //
    //       ],
    //     ),
    //   ),
    // ),

    Step(
      state: _activeStepIndex<= 1? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 1,
      title: const Text('Company\nDetails'),
      content: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 25.0, right: 30.0, bottom: 25.0, left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Company Name',
                hintText: 'Company Name',
                icon: Icon(Icons.local_post_office),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Mobile Number',
                hintText: 'Mobile Number',
                icon: Icon(Icons.call),
              ),
              keyboardType: TextInputType.number,
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Email Id',
                hintText: 'Email Id',
                icon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
          ],
        ),
      ),
    ),
    Step(
      state: StepState.complete,
      isActive: _activeStepIndex >= 2,
      title: const Text('Confirm\nDetails'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Name: ${name.text}'),
          Text('Email: ${email.text}'),
          Text('Mobile Number: ${mobilenumber.text}'),
          //Text('Gender: ${email.text}'),
          Text('Address : ${address.text}'),
          Text('PinCode : ${pincode.text}'),

          Center(
            child: ElevatedButton(onPressed: (){
              Navigator.push(context,
                    MaterialPageRoute(builder: ((context) =>const ViewCustomeer() ))
                    );
            }, child: const Text('View Data'),),
          ),
        ],
      ))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Center(child: Text('Crave Guest Registration')),),
      //
      floatingActionButton: FloatingActionButton.extended(
          //icon: const Icon(Icons.save),
          onPressed: () {
            //_scanQR(); // calling a function when user click on button

            final name2 = name.text;
            final email2= email.text;
            final mobilenumber2 = mobilenumber.text;
            final pin=pincode.text;

            createuser(
                name: name2,
                email:email2,
                mobilenumber: mobilenumber2,
                pincode:pin,
            );
          },
          label: const Text("Submit Data")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
      //
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            _activeStepIndex += 1;
          }
          setState(() {

          },);
        },
        onStepCancel: (){
          if(_activeStepIndex ==0){
            return;
          }
          _activeStepIndex -=1;
          setState(() {

          });
        },
      ),
    );
    }
    

    Future createuser( {
      required String name,email,pincode,mobilenumber
      
      }) async {
    final docuser = FirebaseFirestore.instance.collection('guest').doc();
    final customer = Customer(
      id: docuser.id,
      name: name,
      email:email,
      mobilenumber: mobilenumber,
      pincode:pincode
    );
    final json = customer.toJson();
    await docuser.set(json);
  }      
  }

  class Customer {
  String id;
  final String name;
  final String email;
  final String mobilenumber;
  final String pincode;

  Customer({
    this.id = '',
    required this.name,
    required this.email,
    required this. mobilenumber,
    required this.pincode,
  });

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email,'mobilenumber': mobilenumber, 'pincode':pincode};

  static Customer fromJson(Map<String, dynamic> json) =>
      Customer(name: json['name'], email: json['email'],mobilenumber: json['mobilenumber'],pincode: json['pincode']);
}
  
