import 'package:brew_crew/loading.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared.dart';
import "package:flutter/material.dart";


class Register extends StatefulWidget {

  final Function toggleView;

  Register({this.toggleView});



  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = new AuthService();
  final _formkey = GlobalKey<FormState>();

  String email ="";
  String password = "";
  String error = "";
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Sign Up To Java Squad"),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Sign In"),
              onPressed: () {
                widget.toggleView();
              }
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:50.0),
            child:Form(
              key : _formkey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height:20.0,
                    ),
                    TextFormField(
                      decoration: textDecoration.copyWith(hintText:"Email"),
                      validator: (val) => val.isEmpty ? "Enter an Email" : null,
                      onChanged: (val) {
                        setState(() {
                          email= val;
                        });
                      },
                    ),
                    SizedBox(
                      height:20.0,
                    ),
                    TextFormField(
                      decoration: textDecoration.copyWith(hintText: "Password"),
                      validator: (val) => val.length < 6 ? "Enter a password 6+ chars long" : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(
                      height:20.0,
                    ),
                    RaisedButton(
                      color: Colors.pink[400],
                      child:Text("Register",
                        style:TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async{
                        setState(() {
                          loading = true;
                        });
                        if(_formkey.currentState.validate())
                          {
                           dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                           if(result == null)
                             {
                               loading = false;
                               setState(() {
                                 error = "Please Enter A Valid Email";
                               });
                             }
                          }
                      },
                    ),
                    SizedBox(
                      height:12.0,
                    ),
                    Text("$error"),
                  ],
                )
            )
        )
    );
  }
}

