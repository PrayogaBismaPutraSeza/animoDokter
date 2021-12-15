import 'package:animoDoc/helper/helperfunctions.dart';
import 'package:animoDoc/services/auth.dart';
import 'package:animoDoc/services/database.dart';
import 'package:animoDoc/view/chatRoomScreen.dart';
import 'package:animoDoc/view/home.dart';
import 'package:animoDoc/view/search.dart';
import 'package:animoDoc/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forgetpassword.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  SignIn(this.toggle);

  @override 
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool isLoading = false;

  signIn()async{
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((result) async{
        if (result != null) {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserByUserEmail(emailTextEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["name"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["email"]);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }else{
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        //backgroundColor: Colors.teal[700],
      ),
      body: isLoading
      ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) 
      : Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage ("assets/images/bg.jpg"),
            fit: BoxFit.cover
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val){
                            return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                            null : "Enter correct email";
                          },
                          controller: emailTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("email"),
                        ),
                        TextFormField(
                          validator:  (val){
                            return val.length < 6 ? "Enter Password 6+ characters" : null;
                          },
                          controller: passwordTextEditingController,
                          obscureText: true,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("password"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                    ],
                  ),
                  SizedBox(height: 8,),
                  GestureDetector(
                    onTap: (){
                      signIn();
                    },
                    child: Container(
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
                      child: Text("Sign In", style: simpleTextStyle(),),
                    ),
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}