import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoping_app/Constant/colors.dart';
import 'package:shoping_app/Constant/imagelist.dart';
import 'package:shoping_app/UI/homePage/HomePage.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(lottieAnimation),
          const SizedBox(height: 25),
          Text(
            'This apk for Education Purpose',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.grey[300]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        backgroundColor: buttonColor,
        onPressed: () {
          checkStatus();
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  checkStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
        // print('User is currently signed out!');
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
        //print('User is signed in!');
      }
    });
  }
}

// class LoadAnimation extends StatefulWidget {
//   const LoadAnimation({super.key});
//
//   @override
//   State<LoadAnimation> createState() => _LoadAnimationState();
// }
//
// class _LoadAnimationState extends State<LoadAnimation> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(
//       const Duration(seconds: 1),
//       () => Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const HomePage(),
//           ),
//           (route) => false),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Lottie.asset(loadingAnimation),
//       ),
//     );
//   }
// }
