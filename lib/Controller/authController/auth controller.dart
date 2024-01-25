import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shoping_app/Models/usermodel.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController name = TextEditingController();

  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  var secure = true.obs;


  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    loginEmail.dispose();
    loginPassword.dispose();
    super.dispose();
  }

  /// signup with email and password
  Future<void> signupWithEmail() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await saveUser(
        UserModel(
          id: credential.user!.uid,
          email: auth.currentUser!.email,
          image:
              'https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png',
          name: name.text,
        ),
      );
      email.clear();
      password.clear();
      User? user = credential.user;
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, 'homepage', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something Went Wrong Please try again'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.orange,
            elevation: 8,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.orange,
            elevation: 8,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('The account already exists for that email'),
            backgroundColor: Colors.red,
            elevation: 8,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
          ),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> loginWithEmail() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmail.text,
        password: loginPassword.text,
      );
      loginEmail.clear();
      loginPassword.clear();
      Navigator.pushNamedAndRemoveUntil(context, 'homepage', (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('No user found for that email.'),
            backgroundColor: Colors.red,
            elevation: 8,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Wrong password provided for that user.'),
            backgroundColor: Colors.red,
            elevation: 8,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white),
                SizedBox(width: 5),
                Text('Invalid Email or Password'),
              ],
            ),
            backgroundColor: Colors.orange,
            elevation: 8,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
          ),
        );
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

  Future saveUser(UserModel userModel) async {
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(userModel.toJson());
  }
}
