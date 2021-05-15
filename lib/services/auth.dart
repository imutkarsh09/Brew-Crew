import 'package:brew_crew/Models/uzer.dart';
import 'package:brew_crew/services/database.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create User based on FirebaseUser

  Uzer _userFromFirebaseUser(User user)
  {
    if(user!=null)
    {
      return Uzer(uid:user.uid);
    }
    else
      return null;
  }


  // Auth Change User Stream

  Stream<Uzer> get user {
    return _auth.authStateChanges()
        //.map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }
  // Signing In Anonymously

  Future signInAnon() async{
    try{
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e);
      return null;
    };
  }

  // Sign In With Email And Password

  Future signInWithEmailAndPassword(String email, String password) async{

    try{

      UserCredential result =await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // Create a new document for user with the uid

      await DatabaseService(uid: user.uid).updateUserData("0", "New Crew Member", 100);

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }



  // Register With Email And Password

  Future registerWithEmailAndPassword(String email, String password) async{

    try{

      UserCredential result =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      await DatabaseService(uid: user.uid).updateUserData("0", "New Crew Member", 100);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }




  // Signing Out

  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    };
  }

}