import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoping_app/Constant/theme.dart';
import 'package:shoping_app/UI/Cart/cart_page.dart';
import 'package:shoping_app/UI/Cart/payment_page/payment_page.dart';
import 'package:shoping_app/UI/Favourite/favourite.dart';
import 'package:shoping_app/UI/LoginPage/loginpage.dart';
import 'package:shoping_app/UI/SignupPage/sign_up_page.dart';
import 'package:shoping_app/UI/homePage/HomePage.dart';
import 'package:shoping_app/UI/homePage/drawer/about/about_page.dart';
import 'package:shoping_app/UI/homePage/drawer/personal_details/account_details.dart';
import 'package:shoping_app/UI/onBoarding/on_bording.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      routes: {
        '/': (context) => OnBoarding(),
        'login': (context) => LogInPage(),
        'signup': (context) => SignUpPage(),
        'cart': (context) => CartPage(),
        'favourite': (context) => FavouritePage(),
        'homepage': (context) => HomePage(),
        '/about': (context) => AboutPage(),
        '/account': (context) => AccountDetails(),
        '/payment': (context) => PaymentPage()
      },
    );
  }
}
