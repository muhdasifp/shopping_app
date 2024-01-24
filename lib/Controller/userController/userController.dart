import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser;
  final reference = FirebaseStorage.instance.ref();

  final ImagePicker picker = ImagePicker();

  RxString userEmail = ''.obs;
  RxString userName = ''.obs;
  RxString userPhone = ''.obs;
  RxString userImage = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  /// read user data from firebase
  Future<void> getUserData() async {
    userEmail.value = user!.email.toString();
    await db.collection('users').doc(user!.uid).get().then((value) {
      var userData = value.data();
      userName.value = userData!['name'];
      userPhone.value = userData['number'];
      userImage.value = userData['image'];
    });
  }

  /// to update the name and number of current user
  Future<void> updateUser() async {
    try {
      if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
        await db.collection('users').doc(user!.uid).update({
          'name': nameController.text,
          'number': phoneController.text,
        });
      } else if (nameController.text.isNotEmpty) {
        await db
            .collection('users')
            .doc(user!.uid)
            .update({'name': nameController.text});
      } else if (phoneController.text.isNotEmpty) {
        await db
            .collection('users')
            .doc(user!.uid)
            .update({'number': phoneController.text});
      } else {
        return;
      }
      getUserData();
    } finally {
      nameController.clear();
      phoneController.clear();
    }
  }

  void pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      uploadImage(File(image.path));
      Future.delayed(
        const Duration(seconds: 3),
        () {
          getUserData();
          Fluttertoast.showToast(
            msg: 'Profile Picture Updated',
            backgroundColor: Colors.green,
          );
        },
      );
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong', backgroundColor: Colors.redAccent);
    }
  }

  Future<void> uploadImage(File file) async {
    var storageRef = reference
        .child('userPicture/${FirebaseAuth.instance.currentUser!.uid}');
    UploadTask uploadTask = storageRef.putFile(file);
    await uploadTask.whenComplete(() => null);
    await storageRef.getDownloadURL().then((value) {
      db.collection('users').doc(user!.uid).update({'image': value});
    });
  }
}
