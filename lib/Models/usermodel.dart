import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  final String? name;
  final String? image;
  final String? email;
  String? address;
  String? number;

  UserModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.address,
    this.number,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "image": image,
      "address": address,
      "number": number,
    };
  }

  UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = FirebaseAuth.instance.currentUser!.uid,
        name = snapshot.data()!["name"],
        email = snapshot.data()!["email"],
        image = snapshot.data()!["image"],
        number = snapshot.data()!['number'],
        address = snapshot.data()!["address"];
}
