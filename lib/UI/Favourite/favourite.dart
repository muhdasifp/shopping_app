import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/Controller/favController/favouriteController.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteController favoriteController = Get.put(FavoriteController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite '),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: favoriteController.addFavList
              .map(
                (fav) => Column(
                  children: [
                    ListTile(
                      leading: Image.asset(fav.image),
                      title: Text(
                        fav.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '₹ ${fav.price.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          favoriteController.deleteFav(fav.id);
                          favoriteController.added.value = false;
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
