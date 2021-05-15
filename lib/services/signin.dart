import 'package:brew_crew/loading.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared.dart';
import 'package:brew_crew/wrapper.dart';
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final _formkey = GlobalKey<FormState>();
  String error = "";

  // Text Field State

  String email ="";
  String password = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = new AuthService();
    return loading? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign In To Java Squad"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
            onPressed:  () => widget.toggleView(),

          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:50.0),
        child:Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height:20.0,
              ),
              TextFormField(
                decoration: textDecoration.copyWith(hintText: "Email"),
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
                child:Text("Sign In",
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
                    setState(() {
                      loading= true;
                    });
                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null)
                    {
                      setState(() {
                        loading = false;
                        error = "COULD NOT SIGN IN WITH THOSE CREDENTIALS";
                      });
                    }
                  }
                },
              ),
              SizedBox(
                height:12.0,
              ),
              Text("$error",
              style:TextStyle(
                color: Colors.red,
              )
              ),
            ],
          )
        )
      )
    );
  }
}
