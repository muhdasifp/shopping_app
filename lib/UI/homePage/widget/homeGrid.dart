import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/Controller/cart/cart%20controller.dart';
import 'package:shoping_app/UI/DetailsPage/detailspage.dart';
import '../../../Constant/colors.dart';
import '../../../Constant/imagelist.dart';
import '../../../Models/productmodel.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});
  @override
  Widget build(BuildContext context) {
    List<Product> product = [
      Product(name: 'Banana', image: Banana, price: 40.0),
      Product(name: 'Cabbage', image: Cabbage, price: 50.0),
      Product(name: 'Tomato', image: Tomato, price: 60.0),
      Product(name: 'Egg Plant', image: EggPlan, price: 80.0),
      Product(name: 'Lettuce', image: Lettue, price: 120.0),
      Product(name: 'Potato', image: Pottato, price: 70.0),
    ];

    CartController cartController = Get.put(CartController());
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: product.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(product: product[index]),
                  ));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(product[index].image!),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product[index].name!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'by weight Rs. ${product[index].price} kg',
                    style: const TextStyle(color: textLight, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text('Rs.'),
                      const SizedBox(width: 5),
                      Text(
                        product[index].price.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: iconButtonColor,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              cartController.addCart(product[index]);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
