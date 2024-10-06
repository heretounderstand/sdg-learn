import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bottom_nav_bar.dart';
import '../main.dart';

class WhatToLearnScreen extends StatefulWidget {
  const WhatToLearnScreen({super.key});

  @override
  State<WhatToLearnScreen> createState() => _WhatToLearnScreenState();
}

class _WhatToLearnScreenState extends State<WhatToLearnScreen> {
  var lang = [
    "Japanese",
    "Chinese",
    "Hindi",
    "English",
    "German",
    "Italian",
    "Russian",
    "Korean",
  ];
  bool taken = false;

  late String selected = lang.first;
  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width - 16;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF263238),
          elevation: 0,
          title: Text("Fluent",
              style: GoogleFonts.anton(
                color: Colors.blue,
                fontSize: 22,
                // fontWeight: FontWeight.bold,
              )),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                    ),
                    BorderedContainer(
                      child: Text(
                        'What would you like to learn?',
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: lang.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: index == lang.length - 1
                          ? const EdgeInsets.fromLTRB(8.0, 8, 8, 100)
                          : const EdgeInsets.all(8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            selected = lang[index];
                            if (selected == lang[index]) {
                              taken = true;
                            } else {
                              taken = false;
                            }
                          });
                        },
                        child: BorderedButton(
                            name: lang[index], selected: selected),
                      ),
                    );
                  },
                ))
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 22),
                child: FancyButton(
                  width: sWidth,
                  center: true,
                  size: 35,
                  color: const Color.fromARGB(255, 70, 222, 75),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const BottomNavBar(),
                        ));
                  },
                  child: const Text(
                    "Continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      // fontFamily: 'Gameplay',
                    ),
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

class BorderedButton extends StatelessWidget {
  const BorderedButton({
    super.key,
    required this.name,
    required this.selected,
  });
  final String name;
  final String selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          color: selected == name
              ? Colors.blue.withOpacity(0.2)
              : Colors.transparent,
          border: Border.all(
              color: selected == name ? Colors.blue : Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            Image.asset("assets/japan.png", height: 50, width: 50),
            const SizedBox(
              width: 16,
            ),
            Text(
              name,
              style: GoogleFonts.acme(
                fontSize: 20,
                color: selected == name ? Colors.blue : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BorderedContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double radius;
  final double margin;
  final Color? containerColor;
  const BorderedContainer({
    super.key,
    required this.child,
    this.color,
    this.radius = 8,
    this.margin = 15,
    this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: color ?? Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(radius),
        color: containerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
