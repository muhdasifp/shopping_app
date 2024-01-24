import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:shoping_app/Models/productmodel.dart';

class FavoriteController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final favouriteCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('favourite');

  RxBool added = false.obs;

  RxList<dynamic> addFavList = RxList<Product>();

  BuildContext get context => context;

  @override
  void onInit() {
    getFav();
    super.onInit();
  }

  /// add to cart
  Future<void> addFav(Product product) async {
    String userid = randomAlphaNumeric(10);
    var newProduct = Product(
      name: product.name,
      image: product.image,
      price: product.price,
      id: userid,
    );
    bool result = await checkCart(product.name!);
    try {
      if (result == true) {
        Fluttertoast.showToast(
            msg: 'Already in Favourite list',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orange.shade300,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        added.value = true;
        await favouriteCollection.doc(userid).set(newProduct.toJson());
        getFav();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to Favourite Page'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
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

  /// get cart
  Future<void> getFav() async {
    addFavList.clear();
    try {
      await favouriteCollection.get().then((favs) {
        for (var fav in favs.docs) {
          addFavList.add(Product.fromJson(fav.data()));
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  /// delete cart
  Future<void> deleteFav(String id) async {
    await favouriteCollection.doc(id).delete();
    added.value = false;
    getFav();
  }

  /// check condition for is item in the cart or not?
  Future<bool> checkCart(String productName) async {
    return await favouriteCollection
        .where("name", isEqualTo: productName)
        .get()
        .then((value) => value.size > 0 ? true : false);
  }
}
