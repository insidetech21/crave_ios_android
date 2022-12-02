import 'package:craveiospro/main.dart';
import 'package:craveiospro/qr_scanner.dart';
import 'package:craveiospro/viewcust.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  //lets Create Dashboard Items

  Card makeDashboardItems(String title, String img, int index){
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(3.0, -1.0),
            colors:
            [
              Color(0xFF004B8D),
              Color(0xFFffffff)
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 3,
              offset: Offset(2, 2),
            )],
        ),
        child: InkWell(
          onTap: (){
            if (index == 0) {

              //1.Item

              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
            }

            if(index == 1){
              //2. Item
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewCustomer()));

            }
            if(index == 2){
              //3. Item
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MyCustomWidget()));

            }
            if(index == 3){
              //4. Item

            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(
                height: 50,),
              Center(
                child: Image.asset(
                  img,
                  height: 50,
                  width: 50,
                ),
              ),

              const SizedBox(height: 20),
              Center(child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ),
            ],
          ),
        ),
      ),

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 170, 193, 232),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Padding(padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(
                      child: Text(
                        "Crave User Registration Dashboard",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    SizedBox(height: 4,),

                    // Text(
                    //   "Items: ",
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 20),
          Expanded(child: GridView.count(crossAxisCount: 2,padding:  const EdgeInsets.all(2),
            children: [
              makeDashboardItems("Insert Data", "assets/user.png", 0),
              makeDashboardItems("View Data", "assets/view.png", 1),
              makeDashboardItems("Scan", "assets/barcode-scan.png", 2),
              makeDashboardItems("About", "assets/about.png", 3)


            ],))
        ],
      ),
      // appBar: AppBar(
      //   title: Text("Dashboard UI"),
      //   iconTheme: Icon(Icons.camera) ,
      // ),
    );
  }
}
