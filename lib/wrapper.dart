import 'package:brew_crew/Models/uzer.dart';
import 'package:brew_crew/screens/authenticate.dart';
import 'package:brew_crew/screens/home.dart';
import 'package:brew_crew/services/signin.dart';
import"package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Uzer>(context);
    if(user==null)
      {
        return Authenticate();
      }
    else
      {
        return Home();
      }
  }
}
