import 'package:flutter/material.dart';
import 'package:frontend/auth/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    'https://th.bing.com/th/id/R.57abd564bdc8ff6070e35ec4067421ab?rik=zm788oTvfxpTiA&pid=ImgRaw&r=0',
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
