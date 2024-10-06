import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bottom_nav_bar.dart';
import '../../main.dart';
import '../../provider/select_correct_image_game.dart';
import '../games/select_correct_image.dart';
import '../what_to_learn.dart';

class StartGameScreen extends StatefulWidget {
  final int ind;
  final Map<String, dynamic> list;
  const StartGameScreen({super.key, required this.list, required this.ind});

  @override
  State<StartGameScreen> createState() => _StartGameScreenState();
}

class _StartGameScreenState extends State<StartGameScreen> {
  // String? selected;
  late int answer;
  List<String> values = [];
  TextEditingController textcontroller = TextEditingController();
  bool selected = false;
  int mapp = 0;

  @override
  void initState() {
    super.initState();
    mapp = Random().nextInt(widget.list["data"].length);
    answer = widget.list["data"][mapp]["proposition"]["Vrai"];
    values = [
      widget.list["data"][mapp]["proposition"]["intitule0"],
      widget.list["data"][mapp]["proposition"]["intitule1"],
      widget.list["data"][mapp]["proposition"]["intitule2"],
      widget.list["data"][mapp]["proposition"]["intitule3"],
    ];
    context.read<ImageSelect>().initializeEverything();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavBar(),
                            ));
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                    // Linear Progress Indicator
                    Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        FancyButton(
                          size: 6,
                          circle: true,
                          color: Colors.grey,
                          child: Container(
                            height: 12,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        FancyButton(
                          onPressed: () {},
                          size: 10,
                          circle: true,
                          color: const Color.fromARGB(255, 70, 222, 75),
                          child: Container(
                            height: 14,
                            width: MediaQuery.of(context).size.width *
                                0.2 *
                                (widget.ind),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 70, 222, 75),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        )
                        // Container(
                        //   height: 12,
                        //   width: MediaQuery.of(context).size.width * 0.8,
                        //   decoration: BoxDecoration(
                        //       color: Colors.grey,
                        //       borderRadius: BorderRadius.circular(12)),
                        // ),
                        // Container(
                        //   height: 14,
                        //   width:
                        //       MediaQuery.of(context).size.width * 0.7 * (0.5),
                        //   decoration: BoxDecoration(
                        //     color: Colors.blue,
                        //     borderRadius: BorderRadius.circular(12),
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //       colors: [
                        //         Color.fromARGB(255, 70, 222, 75),
                        //         // Colors.green.shade400,
                        //         Colors.green.shade300,
                        //         // Colors.green.shade100,
                        //       ],
                        //     ),
                        //   ),
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectCorrectImageGame(
                values: values,
                answer: answer,
                explanation: widget.list["data"][mapp]["explanation"],
                intitule: widget.list["data"][mapp]["intitule"],
                type: widget.list["data"][mapp]["type"],
                corrected: (bool value) {
                  if (value) {
                    if (widget.ind != 4) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartGameScreen(
                              list: widget.list,
                              ind: widget.ind + 1,
                            ),
                          ));
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNavBar(),
                          ));
                    }
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StartGameScreen(
                            list: widget.list,
                            ind: widget.ind,
                          ),
                        ));
                  }
                },
              ),
              // child: ImageToTextGame(values: values, textcontroller: textcontroller, answer: answer),
              // child: Column(children: [
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: const Text(
              //       "Tap the matching pair",
              //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              //   MatchPairsCards(),
              //   MatchPairsCards(),
              //   MatchPairsCards(),
              //   MatchPairsCards(),
              // ]),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> showAnswer(BuildContext context) {
    bool correct = context.watch<ImageSelect>().selected == answer;
    // bool correct = true;
    return showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment:
            //     MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: correct
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 30,
                          )
                        : const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 30,
                          ),
                  ),
                  Text(
                    correct ? 'Great Job' : "Incorrect",
                    style: TextStyle(
                        color: correct ? Colors.green : Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "${widget.list["data"][mapp]["explanation"]}",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                      color: correct ? Colors.green : Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 22,
                    left: 8,
                    right: 8,
                    top: 8,
                  ),
                  child: FancyButton(
                    width: MediaQuery.of(context).size.width,
                    center: true,
                    size: 35,
                    color: correct
                        ? const Color.fromARGB(255, 70, 222, 75)
                        : Colors.red,
                    onPressed: () {
                      if (correct) {
                        Navigator.pop(context);
                        if (widget.ind != 4) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StartGameScreen(
                                  list: widget.list,
                                  ind: widget.ind + 1,
                                ),
                              ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomNavBar(),
                              ));
                        }
                      } else {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartGameScreen(
                                list: widget.list,
                                ind: widget.ind + 1,
                              ),
                            ));
                      }
                      // Navigator.push(
                      //     context,
                      //     CupertinoPageRoute(
                      //       builder: (context) =>
                      //           const WhatToLearnScreen(),
                      //     ));
                    },
                    child: Text(
                      correct ? "Continue" : "Got it",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        // fontFamily: 'Gameplay',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MatchPairsCards extends StatefulWidget {
  const MatchPairsCards({
    super.key,
  });

  @override
  State<MatchPairsCards> createState() => _MatchPairsCardsState();
}

class _MatchPairsCardsState extends State<MatchPairsCards> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: BorderedContainer(
        margin: 0,
        color: selected ? Colors.blue : null,
        containerColor: selected ? Colors.blue.withOpacity(0.2) : null,
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Text("Sushi"),
        ),
      ),
    );
  }
}

class ImageToTextGame extends StatelessWidget {
  const ImageToTextGame({
    super.key,
    required this.values,
    required this.textcontroller,
    required this.answer,
    required this.explanation,
    required this.ind,
    required this.list,
  });

  final List<String> values;
  final TextEditingController textcontroller;
  final int answer;
  final String explanation;
  final int ind;
  final Map<String, dynamic> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Choose the answer",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        CustomBorderedButton(
            selected: context.watch<ImageSelect>().selected,
            onpressed: () {
              // context.read<ImageSelect>().changeSelected(values[0]);
            },
            name: answer,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/water.png",
                    height: 150,
                    width: 150,
                  ),
                ),
                const Text(
                  "Water",
                  // style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(14)),
            child: TextField(
              controller: textcontroller,
              decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  fillColor: const Color.fromARGB(255, 83, 110, 123),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide: BorderSide(
                    //   color: Colors.white,
                    //   width: 4,
                    // ),
                    borderSide: BorderSide.none,
                  )),
            ),
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: FancyButton(
              width: MediaQuery.of(context).size.width,
              center: true,
              size: 35,
              color: const Color.fromARGB(255, 70, 222, 75),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StartGameScreen(
                        list: list,
                        ind: ind + 1,
                      ),
                    ));

                bool correct = textcontroller.text.trim().toLowerCase() ==
                    "${values[answer].toLowerCase()}\n$explanation";
                showModalBottomSheet<void>(
                  context: context,
                  isDismissible: false,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // mainAxisAlignment:
                        //     MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: correct
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                              ),
                              Text(
                                correct ? 'Great Job' : "Incorrect",
                                style: TextStyle(
                                    color: correct ? Colors.green : Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Correct Answer: $answer",
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: correct ? Colors.green : Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 22,
                                left: 8,
                                right: 8,
                                top: 8,
                              ),
                              child: FancyButton(
                                width: MediaQuery.of(context).size.width,
                                center: true,
                                size: 35,
                                color: correct
                                    ? const Color.fromARGB(255, 70, 222, 75)
                                    : Colors.red,
                                onPressed: () {
                                  if (correct) {
                                  } else {
                                    Navigator.pop(context);
                                  }
                                  // Navigator.push(
                                  //     context,
                                  //     CupertinoPageRoute(
                                  //       builder: (context) =>
                                  //           const WhatToLearnScreen(),
                                  //     ));
                                },
                                child: Text(
                                  correct ? "Continue" : "Got it",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    // fontFamily: 'Gameplay',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text(
                "Check",
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
    );
  }
}

class CustomBorderedButton extends StatelessWidget {
  const CustomBorderedButton({
    super.key,
    this.selected,
    this.name,
    required this.child,
    required this.onpressed,
  });
  final int? selected;
  final int? name;
  final Widget child;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onpressed,
        child: Container(
            // margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                color: selected == name
                    ? Colors.blue.withOpacity(0.2)
                    : Colors.transparent,
                border: Border.all(
                  color: selected == name ? Colors.blue : Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: child),
      ),
    );
  }
}
