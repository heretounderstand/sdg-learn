import 'package:flutter/material.dart';

import '../bottom_nav_bar.dart';
import '../main.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width - 16;
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset("assets/sdg.png", height: 200, width: 200),
            Text("SDG-Learn",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                )),
            const Text("Empowering Young Minds\nWith Clean Energy Knowledge.",
                textAlign: TextAlign.center, style: TextStyle()),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: FancyButton(
                width: sWidth,
                center: true,
                size: 35,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ));
                },
                child: const Text(
                  "Get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    // fontFamily: 'Gameplay',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
