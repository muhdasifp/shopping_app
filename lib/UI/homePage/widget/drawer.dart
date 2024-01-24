import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/Controller/authController/auth%20controller.dart';
import 'package:shoping_app/Controller/userController/userController.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    UserController userController = Get.put(UserController());

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
              child: Obx(
            () => Column(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(userController.userImage.value),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userController.userEmail.toString(),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                )
              ],
            ),
          )),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Account Details'),
            onTap: () => Navigator.pushNamed(context, '/account'),
          ),
          const ListTile(
              leading: Icon(Icons.shopping_bag_outlined),
              title: Text('Orders')),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.error_outline),
            title: const Text('About'),
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Sign Out'),
            onTap: () {
              authController.signOut();
            },
          ),
        ],
      ),
    );
  }
}
