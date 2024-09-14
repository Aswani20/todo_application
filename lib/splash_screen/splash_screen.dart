import 'package:flutter/material.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/my_theme.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash_screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateTOHome();
  }

  _navigateTOHome() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 6,
            ),
            Image.asset("assets/images/logo.png"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            CircularProgressIndicator(
              color: MyTheme.primaryLightColor,
            ),
            const Spacer(
              flex: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Powered By",
                style:
                    TextStyle(fontSize: 20, color: MyTheme.primaryLightColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Route",
                style: TextStyle(
                    fontSize: 30,
                    color: MyTheme.primaryLightColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
