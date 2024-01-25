import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping_app/Models/productmodel.dart';

class CartController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final cartCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('cart');

  late SharedPreferences preferences;

  RxList<dynamic> cartList = RxList<Product>();

  RxDouble totalAmount = 0.0.obs;
  RxDouble amount = 0.0.obs;
  RxInt badge = 0.obs;


  @override
  void onInit() {
    getCart();
    read();

    super.onInit();
  }

  ///add to cart
  Future<void> addCart(Product product) async {
    String cartId = randomAlphaNumeric(10);

    var newCart = Product(
      name: product.name,
      image: product.image,
      price: product.price,
      id: cartId,
      qty: 1,
    );

    bool result = await checkCart(product.name!);
    try {
      if (result == true) {
        Fluttertoast.showToast(
            msg: 'Already in Cart list',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orange.shade300,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        await cartCollection.doc(cartId).set(newCart.toJson());
        getCart();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to Cart Page'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            elevation: 8,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
          ),
        );
      }
    } finally {
      calculateTotal(product, cartId);
    }
  }

  ///get the cart items
  Future<void> getCart() async {
    cartList.clear();
    try {
      await cartCollection.get().then((value) {
        badge.value = value.size;
        if (value.size == 0) {
          delete();
        } else {
          for (var cart in value.docs) {
            cartList.add(Product.fromJson(cart.data()));
          }
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  ///delete the cart items
  Future<void> deleteCart(String id, Product product) async {
    await cartCollection.doc(id).delete();
    getCart();
  }

  ///condition for check item in the cart or not
  Future<bool> checkCart(String productName) async {
    return await cartCollection
        .where("name", isEqualTo: productName)
        .get()
        .then((value) => value.size > 0 ? true : false);
  }

  ///increase the item count in cart page
  Future<void> increment(Product product, String id) async {
    await cartCollection.doc(id).update({'quantity': product.qty! + 1});
    getCart();
    calculateTotal(product, id);
    return;
  }

  /// decrease the item count in cart page
  Future<void> decrement(Product product, String id) async {
    if (product.qty! > 1) {
      await cartCollection.doc(id).update({'quantity': product.qty! - 1});
      deCalculateTotal(product, id);
      getCart();
    } else {
      deleteCart(id, product);
      deCalculateTotal(product, id);
    }
  }

  ///add the total price while increasing the count
  calculateTotal(Product product, String id) async {
    amount = amount + (product.price!) as RxDouble;
    save(amount.value);
    read();
  }

  ///subtract the total price while decreasing the count
  deCalculateTotal(Product product, String id) async {
    amount = amount - (product.price!) as RxDouble;
    save(amount.value);
    read();
  }

  save(double amount) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setDouble('total', amount);
  }

  read() async {
    preferences = await SharedPreferences.getInstance();
    totalAmount.value = preferences.getDouble('total')!;
  }

  delete() async {
    preferences = await SharedPreferences.getInstance();
    preferences.remove('total');
    totalAmount.value = 0.0;
    amount.value = 0.0;
    //preferences.setDouble('total', 0.0);
  }
}
