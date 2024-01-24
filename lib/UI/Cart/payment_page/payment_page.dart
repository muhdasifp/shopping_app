import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shoping_app/Constant/widget/custom_button.dart';
import 'package:shoping_app/Controller/cart/cart%20controller.dart';
import '../../../Constant/imagelist.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            const Text(
              'Cart PayOut',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Obx(
              () => Text(
                '₹${cartController.totalAmount.value.toString()}',
                style:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'Make Payment',
              onTap: () {
                if (cartController.totalAmount.value > 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(paymentDone),
                            const Text('Payment Done',
                                style: TextStyle(fontSize: 20)),
                            const SizedBox(height: 20)
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
