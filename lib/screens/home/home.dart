import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../what_to_learn.dart';
import 'start_game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map jsonD = {};

  void readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    jsonD = await json.decode(response);
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  void openPDF(String pdf) async {
    final ByteData bytes = await rootBundle.load(pdf);
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/mon_document.pdf');
    await file.writeAsBytes(bytes.buffer.asUint8List());

    if (await file.exists()) {
      await launchUrl(Uri.parse(file.path));
    }
  }

  int completedChaps = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: Visibility(
        //   child: FloatingActionButton(
        //     onPressed: () {},
        //   ),
        // ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images.png",
                    height: 40,
                    width: 40,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/streak.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                    const Text(
                      "2",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/gems.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                    const Text(
                      "200",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                )
              ],
            ),
            const Divider(
              thickness: 3,
            ),
            Expanded(
              child: PageView.builder(
                itemCount: 3,
                reverse: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return pageViewCard(context, index + 1);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Column pageViewCard(BuildContext context, int i) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          // color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Unit $i",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        i == 1
                            ? jsonD["unit1"]["name"]
                            : i == 2
                                ? jsonD["unit2"]["name"]
                                : i == 3
                                    ? jsonD["unit3"]["name"]
                                    : jsonD["unit4"]["name"],
                        style: const TextStyle(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              BorderedContainer(
                radius: 16,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.book_rounded),
                    onPressed: () {
                      openPDF(
                        i == 1
                            ? "assets/Lesson 1.pdf"
                            : i == 2
                                ? "assets/Lesson 2.pdf"
                                : "assets/Lesson 3.pdf",
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      chapterCard(index: 0, otherIndex: i),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: chapterCard(
                            alignment: Alignment.topLeft,
                            index: 1,
                            otherIndex: i),
                      ),
                      chapterCard(index: 2, otherIndex: i),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: chapterCard(
                            alignment: Alignment.topRight,
                            index: 3,
                            otherIndex: i),
                      ),
                      chapterCard(index: 4, otherIndex: i),
                    ],
                  ),
                ))),
        Container(
          height: MediaQuery.of(context).size.height * 0.02,
          // color: Colors.grey,
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        )
      ],
    );
  }

  Align chapterCard(
      {AlignmentGeometry alignment = Alignment.center,
      int index = 0,
      int otherIndex = 0}) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Visibility(
              visible: index <= completedChaps,
              child: const SizedBox(
                height: 75,
                width: 75,
                child: CircularProgressIndicator(
                  value: 0.4,
                  strokeWidth: 8,
                  color: Colors.yellow,
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: index <= completedChaps
                  ? FancyButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartGameScreen(
                                list: otherIndex == 1
                                    ? jsonD["unit1"]
                                    : otherIndex == 2
                                        ? jsonD["unit2"]
                                        : otherIndex == 3
                                            ? jsonD["unit3"]
                                            : jsonD["unit4"],
                                ind: 0,
                              ),
                            ));
                      },
                      size: 35,
                      circle: true,
                      color: Colors.lightGreen,
                      child: const Icon(
                        Icons.star_rate_rounded,
                        color: Colors.white,
                        size: 35,
                      ))
                  : const FancyButton(
                      // onPressed: () {
                      //   print("Tapped on the button");
                      // },
                      size: 75,
                      circle: true,
                      color: Colors.grey,
                      // onPressed: () {
                      //   print("Tapped on the button");
                      // },
                      child: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 35,
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
