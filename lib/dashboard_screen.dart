import 'package:craveiospro/main.dart';
import 'package:craveiospro/viewcust.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  //lets Create Dashboard Items

  Center makeDashboardItems(String title, String img, int index){
    return Center(
      child: Card(
        elevation: 20,
        margin: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(3.0, -1.0),
              colors:
              [
                Color(0xFFffffff),
                Color(0xFF00D3FF),
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF00D3FF),
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
             /*if(index == 2){
                //3. Item
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const OcrScanner()));

              }*/
              // if(index == 3){
              //   //4. Item
              //
              // }
            },
            child: Card(
              elevation: 15,
              shadowColor: const Color(0xFF00D3FF),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                verticalDirection: VerticalDirection.down,
                children: [
                      const Center(
                        child: Card(
                          //elevation: 35,
                          color: Color(0xFF00D3FF),
                          shadowColor: Color(0xFF00D3FF),
                          child: SizedBox(
                            height: double.maxFinite,
                            width: 80,
                              child: Icon(
                                  Icons.person_add,
                                  size: 50,color: Colors.white
                              ),
                          ),
                          /*child: Image.asset(
                            img,
                            height: 60,
                            width: 80,
                          ),*/
                        ),
                      ),
                      const SizedBox(width: 50),
                          Center(child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                        ],
              ),
            ),
          ),
        ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          const SizedBox(height: 200),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30,
                  right: 0,
                  bottom: 20,
                  top: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Center(
                        child: Text(
                          "Client Registration Dashboard",
                           style: TextStyle(
                             //backgroundColor: Color(0xFF00D3FF),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //SizedBox(height: 10),
                      // Text(
                      //   "Items: ",
                      //   style: TextStyle(
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.bold
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Card(
              elevation: 15,
              shadowColor: Color(0xFF00D3FF),
              child: SizedBox(height: 50),
          ),
          Expanded(
            child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 3,
            crossAxisSpacing: 10,
            padding:  const EdgeInsets.all(10),
            children: [
              makeDashboardItems("Add Client", "assets/user.png",0),
              makeDashboardItems("Client List", "assets/view.png",1),
              // makeDashboardItems("Scan", "assets/ocr.png",2),
              // makeDashboardItems("About", "assets/about.png",3),
            ],
          ),
          ),
        ],
      ),
      // appBar: AppBar(
      //   title: Text("Dashboard UI"),
      //   iconTheme: Icon(Icons.camera) ,
      // ),
    );
  }
}
