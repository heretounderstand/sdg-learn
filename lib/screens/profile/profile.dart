import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../what_to_learn.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Momos",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(1000),
                  onTap: () {
                    if (AdaptiveTheme.of(context).mode ==
                        AdaptiveThemeMode.dark) {
                      AdaptiveTheme.of(context).setLight();
                    } else {
                      AdaptiveTheme.of(context).setDark();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon((AdaptiveTheme.of(context).mode ==
                            AdaptiveThemeMode.dark)
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded),
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Statistics",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            // Container(
            //   height: 150,
            //   color: Colors.blue,
            //   child: GridView.count(
            //       primary: false,
            //       shrinkWrap: true,
            //       padding: const EdgeInsets.all(8),
            //       crossAxisSpacing: 16,
            //       mainAxisSpacing: 16,
            //       crossAxisCount: 2,
            //       children: [

            //       ]),
            // )
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      // height: 50,
                      width: 150,
                      child: BorderedContainer(
                          margin: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/streak.png",
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "2",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "Day Streak",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      child: BorderedContainer(
                          margin: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/gems.png",
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "200",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Total XP",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      child: BorderedContainer(
                          margin: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/rice.png",
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "20 mins",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Max Duration",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      child: BorderedContainer(
                          margin: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/streak.png",
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "2",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "Day Streak",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Achievements",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            BorderedContainer(
                radius: 16,
                child: Column(
                  children: [
                    _dailyQuestCard(
                        context: context, imageAsset: "assets/streak.png"),
                    const Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                    _dailyQuestCard(
                        context: context,
                        imageAsset: "assets/gems.png",
                        color: Colors.purple),
                    const Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                    _dailyQuestCard(
                        context: context,
                        imageAsset: "assets/trophy.png",
                        color: Colors.blue),
                    // Divider(
                    //   color: Colors.grey,
                    //   thickness: 2,
                    // )
                  ],
                ))
          ],
        ),
      )),
    );
  }

  Row _dailyQuestCard(
      {required BuildContext context,
      required String imageAsset,
      Color color = Colors.red}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FancyButton(
            size: 30,
            circle: true,
            color: color,
            child: Image.asset(
              imageAsset,
              height: 70,
              width: 70,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                "WildFire",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                "Reach a 3 day Streak",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    FancyButton(
                      size: 6,
                      circle: true,
                      color: Colors.grey,
                      child: Container(
                        height: 5,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    FancyButton(
                      size: 10,
                      circle: true,
                      color: Colors.amber,
                      child: Container(
                        height: 7,
                        width: MediaQuery.of(context).size.width * 0.4 * (0.5),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  "2/3",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
