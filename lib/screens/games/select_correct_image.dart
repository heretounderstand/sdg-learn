import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../provider/select_correct_image_game.dart';
import '../home/start_game.dart';

class SelectCorrectImageGame extends StatelessWidget {
  const SelectCorrectImageGame({
    super.key,
    // required this.selected,
    required this.values,
    required this.answer,
    required this.type,
    required this.intitule,
    required this.explanation,
    required this.corrected,
  });

  // final String? selected;
  final List<String> values;
  final int answer;
  final String type;
  final String intitule;
  final String explanation;
  final ValueChanged<bool> corrected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Select the correct answer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(intitule),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: type == "text"
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomBorderedButton(
                                    selected:
                                        context.watch<ImageSelect>().selected,
                                    onpressed: () {
                                      context
                                          .read<ImageSelect>()
                                          .changeSelected(0);
                                    },
                                    name: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Text(values[0])),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomBorderedButton(
                                    selected:
                                        context.watch<ImageSelect>().selected,
                                    onpressed: () {
                                      context
                                          .read<ImageSelect>()
                                          .changeSelected(1);
                                    },
                                    name: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Text(values[1])),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomBorderedButton(
                                    selected:
                                        context.watch<ImageSelect>().selected,
                                    onpressed: () {
                                      context
                                          .read<ImageSelect>()
                                          .changeSelected(2);
                                    },
                                    name: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Text(values[2])),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomBorderedButton(
                                    selected:
                                        context.watch<ImageSelect>().selected,
                                    onpressed: () {
                                      context
                                          .read<ImageSelect>()
                                          .changeSelected(3);
                                    },
                                    name: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Text(values[3])),
                                    )),
                              ),
                            ])
                      : GridView.count(
                          primary: false,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          crossAxisCount: 2,
                          children: <Widget>[
                            CustomBorderedButton(
                                selected: context.watch<ImageSelect>().selected,
                                onpressed: () {
                                  context.read<ImageSelect>().changeSelected(0);
                                },
                                name: 0,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      values[0],
                                      fit: BoxFit.cover,
                                    ))),
                            CustomBorderedButton(
                                selected: context.watch<ImageSelect>().selected,
                                onpressed: () {
                                  context.read<ImageSelect>().changeSelected(1);
                                },
                                name: 1,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      values[1],
                                      fit: BoxFit.cover,
                                    ))),
                            CustomBorderedButton(
                                selected: context.watch<ImageSelect>().selected,
                                onpressed: () {
                                  context.read<ImageSelect>().changeSelected(2);
                                },
                                name: 2,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      values[2],
                                      fit: BoxFit.cover,
                                    ))),
                            CustomBorderedButton(
                                selected: context.watch<ImageSelect>().selected,
                                onpressed: () {
                                  context.read<ImageSelect>().changeSelected(3);
                                },
                                name: 3,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      values[3],
                                      fit: BoxFit.cover,
                                    ))),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: FancyButton(
              width: MediaQuery.of(context).size.width,
              center: true,
              size: 35,
              color: context.watch<ImageSelect>().selected == null
                  ? Colors.grey
                  : const Color.fromARGB(255, 70, 222, 75),
              onPressed: context.watch<ImageSelect>().selected == null
                  ? null
                  : () {
                      // Navigator.push(
                      //     context,
                      //     CupertinoPageRoute(
                      //       builder: (context) =>
                      //           const WhatToLearnScreen(),
                      //     ));

                      // showAnswer(
                      //   context,
                      // );

                      bool correct =
                          context.read<ImageSelect>().selected! == answer;
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
                                              size: 26,
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
                                          color: correct
                                              ? Colors.green
                                              : Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    explanation,
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            correct ? Colors.green : Colors.red,
                                        fontSize: 16,
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
                                          ? const Color.fromARGB(
                                              255, 70, 222, 75)
                                          : Colors.red,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        corrected(correct);
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
