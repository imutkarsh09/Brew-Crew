import 'package:brew_crew/Models/brew.dart';
import 'package:brew_crew/Models/uzer.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import "dart:async";
class DatabaseService
{

  final String uid;

  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async{

    return await brewCollection.doc(uid).set({

      "sugars":sugars,
      "name" : name,
      "strength": strength,
    });
  }
  // Brew List from Snapshot
  List<Brew>_brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
        name : doc.data()["name"] ?? "",
        strength: doc.data()["strength"]?? 0,
        sugars: doc.data()["sugars"] ?? 0,
      );
    }).toList();
}

// User Data From SnapShots....

  UserData _userDataFromSnapshots(DocumentSnapshot snapshot){
    return UserData(
      uid:uid,
      name :snapshot.data()["name"],
      sugars:snapshot.data()["sugars"],
      strength:snapshot.data()["strength"],
    );
  }

// Get Brews Stream....
Stream<List<Brew>> get brews {
  return brewCollection.snapshots().map(_brewListFromSnapshot);
}

// Get User Doc Stream.....

Stream<UserData>get userData{
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshots);
}

}