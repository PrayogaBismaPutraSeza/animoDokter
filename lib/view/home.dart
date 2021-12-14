import 'package:animoDoc/helper/authenticate.dart';
import 'package:animoDoc/services/auth.dart';
import 'package:animoDoc/view/chatRoomScreen.dart';
import 'package:animoDoc/view/maps.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Authenticate()
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app)
            ),
          ),
        ],
        //backgroundColor: Colors.teal[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage ("assets/images/bg.jpg"),
            fit: BoxFit.cover
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom()
                  ));
                },
                child: Text("Konsultasi", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MapsPage()
                  ));
                },
                child: Text("Pet Shop Terdekat", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}