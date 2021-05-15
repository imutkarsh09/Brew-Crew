import 'package:brew_crew/Models/uzer.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/wrapper.dart';
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Uzer>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
