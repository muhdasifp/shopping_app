import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/Controller/cart/cart%20controller.dart';
import '../../Constant/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart '),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView(
          children: cartController.cartList.map((cart) {
            return ListTile(
              leading: Image.asset(cart.image),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cart.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'by weight ₹${cart.price} kg',
                    style: const TextStyle(color: textLight, fontSize: 16),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            cartController.increment(cart, cart.id);
                          },
                          icon: const Icon(Icons.add),
                        ),
                        Text(
                          cart.qty.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            cartController.decrement(cart, cart.id);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              trailing: Text(
                '₹${cart.price.toString()}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/payment');
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black12,
                offset: Offset(5, 5),
                spreadRadius: 1,
              ),
            ],
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Check Out',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 18)),
              const SizedBox(width: 10),
              const Spacer(),
              const Text('Total',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20)),
              const SizedBox(width: 10),
              const Text('₹',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              Obx(
                () => Text(cartController.totalAmount.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
