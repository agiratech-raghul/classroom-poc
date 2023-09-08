import 'package:classroom_poc/homeScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.red,
          child: const Center(
              child: Text(
            "ClassRoom",
            style: TextStyle(
                fontSize: 35, color: Colors.white, fontWeight: FontWeight.w700),
          ))),
    );
  }

  void _timer() {
    Future.delayed(const Duration(seconds: 3), _nextPage);
  }

  Future<void> _nextPage() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ));
  }
}
