import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/Constant/colors.dart';
import 'package:shoping_app/Controller/cart/cart%20controller.dart';
import 'package:shoping_app/Models/productmodel.dart';
import '../../Controller/favController/favouriteController.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    FavoriteController favController = Get.put(FavoriteController());
    CartController cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(product.image!),
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name!,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'by Farm fresh veg shop',
                      style: TextStyle(fontSize: 14, color: textLight),
                    ),
                  ],
                ),
                const Spacer(),
                Obx(
                  () => IconButton(
                    onPressed: () {
                      favController.addFav(product);
                    },
                    icon: favController.added.value
                        ? const Icon(
                            Icons.favorite_outlined,
                            color: Colors.red,
                            size: 30,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            size: 30,
                            color: Colors.red,
                          ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                      ),
                      Text('4.7'),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            const Text(
                'Lorem ipsum dolor sit amet, consecrate disciplining elite. Present in exposure dui. In hac habilitates platea dictum. Morbid vitae tincidunt leo. Esam id libero at turps mollies exposure consecrate. '),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Text(
                  'Price:₹',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 5),
                Text(
                  product.price.toString(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(width: 10),
            MaterialButton(
              onPressed: () async {
                bool result = await cartController.checkCart(product.name!);
                if (result == false) {
                  cartController.addCart(product);
                  Navigator.pushNamed(context, 'cart');
                } else {
                  Navigator.pushNamed(context, 'cart');
                }
              },
              height: 40,
              minWidth: 130,
              elevation: 3,
              color: iconButtonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: const Text('Buy Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
