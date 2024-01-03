import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internflutter/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[50],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final double scale =
                    0.5 + 0.5 * _controller.value; // Scale up from 0.5 to 1.0
                final double offsetY = -50 * _controller.value; // Move upwards

                return Transform.translate(
                  offset: Offset(0, offsetY),
                  child: Transform.scale(
                    scale: scale,
                    child: const Center(
                      child: Image(
                        height: 200,
                        width: 200,
                        image: AssetImage('assets/images/splash.jpg'),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .0,
            ),
            const Align(
                alignment: Alignment.center,
                child: Text(
                  "Happy Shopping",
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Dancing Script', // Use the correct family name
                    color: Colors.white,
                  ),
                ))
          ],
        ));
  }
}
