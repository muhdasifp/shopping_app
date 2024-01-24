import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/Constant/imagelist.dart';
import 'package:shoping_app/Controller/cart/cart%20controller.dart';
import 'package:shoping_app/UI/homePage/widget/drawer.dart';
import 'package:shoping_app/UI/homePage/widget/homeGrid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'favourite');
              },
              icon: const Icon(Icons.favorite_border, size: 30),
            ),
            Badge(
              largeSize: 16,
              alignment: const Alignment(0.5, -0.5),
              label: Obx(() => Text(cartController.badge.toString())),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'cart');
                },
                icon: const Icon(Icons.shopping_cart_checkout),
              ),
            )
          ],
        ),
        drawer: const HomeDrawer(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              const Text(
                'Everything in your\ndoor step',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Image.asset(promo),
              const SizedBox(height: 10),
              const Text(
                'Fruits & Vegetables',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              HomeGrid()
            ],
          ),
        ));
  }
}
