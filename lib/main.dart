import 'package:craveiospro/dashboard_screen.dart';
import 'package:craveiospro/viewcust.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


//mohnish


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
      title: 'Crave Client Registration',
      theme: ThemeData(
        canvasColor: Colors.white70,
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Colors.blueGrey,
          background: Colors.red,
          secondary: Colors.blueGrey,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
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
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController addressStreet1 = TextEditingController();
  TextEditingController addressStreet2 = TextEditingController();
  TextEditingController addressCity = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController companyAddress = TextEditingController();
  TextEditingController companyMail = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController date = TextEditingController();

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
        padding: const EdgeInsets.only(top: 25.0, right: 0.0, bottom: 25.0, left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Name :',
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
                labelText: 'Enter Mobile Number :',
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
                labelText: 'Enter Email Id :',
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
                //iconSize: 30,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: 'Select Gender',
                  hintText: 'Gender',
                  icon: Icon(Icons.people_rounded),
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.blueGrey,),
                items: <String>['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (values) {
                  setState(() {}
                  );
                  },
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
            TextFormField(
              controller: addressStreet1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Street 1 :',
                hintText: 'Street 1 Address',
                icon: Icon(Icons.location_city),
              ),
              keyboardType: TextInputType.text,
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              controller: addressStreet2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Street 2 :',
                hintText: 'Street 2 Address',
                icon: Icon(Icons.home),
              ),
              keyboardType: TextInputType.text,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              controller: addressCity,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter City :',
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
                labelText: 'Enter Zip Code :',
                hintText: 'Zip',
                icon: Icon(Icons.pin),
              ),
              keyboardType: TextInputType.number,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              controller: state,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter State :',
                hintText: 'State',
                icon: Icon(Icons.map),
              ),
              keyboardType: TextInputType.text,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              controller: country,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Country :',
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
        padding: const EdgeInsets.only(top: 25.0, right: 0.0, bottom: 25.0, left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              controller: companyName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Company Name :',
                hintText: 'Company Name',
                icon: Icon(Icons.corporate_fare),
              ),
              keyboardType: TextInputType.text,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
            TextFormField(
              controller: companyAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter company address :',
                hintText: 'Company Address',
                icon: Icon(Icons.home),
              ),
              keyboardType: TextInputType.text,
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              controller: companyMail,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Email Id :',
                hintText: 'Company Email Id',
                icon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              controller: website,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Enter Company Website :',
                hintText: 'Company Website',
                icon: Icon(Icons.web),
              ),
              keyboardType: TextInputType.text,
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            Padding(
              padding: const EdgeInsets.all(0.0),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                //iconSize: 30,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: 'Interested In:',
                  hintText: 'Select your preference',
                  icon: Icon(Icons.interests),
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.blueGrey,),
                items: <String>['Meeting','Proposal','Workshop','Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (values) {
                  setState(() {}
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              controller: date,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: ' Select Date',
                //hintText: 'Select Date',
                icon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if(pickeddate != null){
                  setState(() {
                    //date.text = ('yyyy-MM-dd').format(pickeddate);

                  });
                }

                },
              keyboardType: TextInputType.text,
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),

            TextFormField(
              //controller: ,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Comments :',
                hintText: 'Any Comments ?',
                icon: Icon(Icons.comment),
              ),
              keyboardType: TextInputType.text,
              maxLines: 2,
            ),
          ],
        ),
      ),
    ),
    Step(
      state: StepState.complete,
      isActive: _activeStepIndex >= 2,
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Confirm\nDetails'),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Name : ${name.text}',
                style: const TextStyle(
                fontSize: 20,
                wordSpacing: 1,
                fontWeight: FontWeight.w500),
            ),
            Text('Email : ${email.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),
            Text('Mobile Number : ${mobilenumber.text}',
              style: const TextStyle(
                fontSize: 20,
                wordSpacing: 1,
                fontWeight: FontWeight.w500),
            ),
            Text('Gender: ${gender.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),
            Text('Address Street1 : ${addressStreet1.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),
            Text('Address Street2 : ${addressStreet2.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),
            Text('PinCode : ${pincode.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),
            Text('City : ${addressCity.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),
            Text('State : ${state.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),
            Text('Country : ${country.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),
            Text('Company Name : ${companyName.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),

            Text('Company Add : ${companyAddress.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),

            Text('Company Mail : ${companyMail.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),

            Text('Company Website : ${website.text}',
              style: const TextStyle(
                  fontSize: 20,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),

            // Center(
            //   child: ElevatedButton(
            //     onPressed: (){
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: ((context) =>const ViewCustomeer() ))
            //       );
            //     }, child: const Text('View Data'),),
            //
            // ),
          ],
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: ,
      backgroundColor: Colors.white,
      appBar:
      AppBar(title: const Center(child: Text('Crave Guest Registration')),
        backgroundColor: const Color(0xFF004B8D),
      ),
      //
      floatingActionButton: FloatingActionButton.extended(

        backgroundColor: const Color(0xFF004B8D),
        //icon: const Icon(Icons.save),
        onPressed: () {
          //_scanQR(); // calling a function when user click on button

          final name2 = name.text;
          final email2= email.text;
          final mobilenumber2 = mobilenumber.text;
          final addressStreet1_2 = addressStreet1.text;
          final addressStreet2_2 = addressStreet2.text;
          final pincode2=pincode.text;
          final addressCity2 = addressCity.text;
          final state2 = state.text;
          final country2 = country.text;
          final companyName2 = companyName.text;
          final companyAddress2 = companyAddress.text;
          final companyMail2 = companyMail.text;
          final website2 = website.text;

          createuser(
              name: name2,
              email:email2,
              mobilenumber: mobilenumber2,
              addressStreet1: addressStreet1_2,
              addressStreet2: addressStreet2_2,
              pincode: pincode2,
              addressCity: addressCity2,
              state: state2,
              country: country2,
              companyName: companyName2,
              companyAdd: companyAddress2,
              companyMail: companyMail2,
              website: website2,
          );
        },
        label: const Text("Submit Data"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

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
          if(_activeStepIndex == 0){
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
    required String
    name,
    email,
    mobilenumber,
    addressStreet1,
    addressStreet2,
    pincode,
    addressCity,
    state,
    country,
    companyName,
    companyAdd,
    companyMail,
    website,

  }) async {
    final docuser = FirebaseFirestore.instance.collection('guest').doc();
    final customer = Customer(
      id: docuser.id,
      name: name,
      email: email,
      mobilenumber: mobilenumber,
      addressStreet1: addressStreet1,
      addressStreet2: addressStreet2,
      pincode: pincode,
      addressCity: addressCity,
      state: state,
      country: country,
      companyName: companyName,
      companyAdd: companyAdd,
      companyMail: companyMail,
      website: website,

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
  final String addressStreet1;
  final String addressStreet2;
  final String pincode;
  final String addressCity;
  final String state;
  final String country;
  final String companyName;
  final String companyAdd;
  final String companyMail;
  final String website;


  Customer({
    this.id = '',
    required this.name,
    required this.email,
    required this.mobilenumber,
    required this.addressStreet1,
    required this.addressStreet2,
    required this.pincode,
    required this.addressCity,
    required this.state,
    required this.country,
    required this.companyName,
    required this.companyAdd,
    required this.companyMail,
    required this.website,

  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'mobilenumber': mobilenumber,
    'addressStreet1': addressStreet1,
    'addressStreet2': addressStreet2,
    'pincode': pincode,
    'addressCity': addressCity,
    'state': state,
    'country': country,
    'companyName':companyName,
    'companyAdd': companyAdd,
    'companyMail': companyMail,
    'website': website,
  };

  static Customer fromJson(Map<String, dynamic> json) =>
      Customer(
        name: json['name'],
        email: json['email'],
        mobilenumber: json['mobilenumber'],
        pincode: json['pincode'],
        addressStreet1: json ['addressStreet1'],
        addressStreet2: json ['addressStreet2'],
        addressCity: json['addressCity'],
        state: json['state'],
        country: json['country'],
        companyName: json['companyName'],
        companyAdd: json['companyAdd'],
        companyMail: json['companyMail'],
        website: json['website'],
      );
}


/*
Future <void> pickDateOfBirth(BuildContext context) async{

  final initialDate = DateTime.now();
  final newDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? initialDate, // for selected date as it is
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),

      builder: (context,child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.yellow,
            onPrimary: Colors.pink,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child ?? const Text(''),
      )
  );

  if(newDate == null)
  {
    return;
  }

  setState(() {

    _dateOfBirth = newDate; // for selected date as it is
    String dob = DateFormat('dd/MM/yyyy').format(newDate);
    //_dateOfBirthController.text = newDate.toIso8601String();
    _dateOfBirthController.text = dob;
  });
}
}

*/
