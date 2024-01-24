import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/Controller/userController/userController.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    UserController user = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  () => Container(
                    height: 120,
                    width: 120,
                    alignment: const Alignment(1, 1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(user.userImage.value),
                      ),
                    ),
                    child: IconButton(
                        onPressed: () {
                          user.pickImage();
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.red,
                          size: 40,
                        )),
                  ),
                ),
                const SizedBox(width: 30),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(user.userName.value,
                          style: const TextStyle(fontSize: 18)),
                      Text(user.userEmail.value,
                          style: const TextStyle(fontSize: 18)),
                      Text("+91 ${user.userPhone.value}",
                          style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    user.updateUser();
                  },
                  child: const Text('Update'),
                )
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: user.nameController,
              decoration: InputDecoration(
                hintText: user.userName.value,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              controller: user.phoneController,
              decoration: InputDecoration(
                hintText: user.userPhone.value,
                prefixIcon: const Icon(Icons.phone),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
