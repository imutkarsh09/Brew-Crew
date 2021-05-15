import 'package:brew_crew/Models/brew.dart';
import 'package:brew_crew/screens/brew_list.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/setting_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:brew_crew/services/database.dart";
import "package:provider/provider.dart";
import "package:firebase_core/firebase_core.dart";
class Home extends StatelessWidget {
  final AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel(){
      showModalBottomSheet(context: context, builder:(context){
        return Container(
          padding:EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child:SettingsForm(),
        );
      });
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Java Squad"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon:Icon(Icons.person),
              label: Text("Logout"),
              onPressed: () async{
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon : Icon(Icons.settings),
              label: Text("Settings"),
              onPressed:() => _showSettingPanel(),
            )
          ],
        ),
        body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage("assets/coffee_bg.png"),
              fit:BoxFit.cover,
            )
          ),
            child: BrewList()
        ),
      ),
    );
  }
}
