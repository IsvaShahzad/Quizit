import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

import 'home_page.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key, required this.email});
  final String email;
  final AudioPlayer player = AudioPlayer();

  Future<void> playSound() async {
    String soundPath = "sounds/click-button-app-147358.mp3";
    await player.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = kToolbarHeight; // Default app bar height

    return WillPopScope(
      onWillPop: () async => false, // Disable back navigation
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kPrimaryColor,
                const Color(0xFF006666),
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                height: appBarHeight,
                child: AppBar(
                  automaticallyImplyLeading: false,
                  clipBehavior: Clip.none,
                  backgroundColor: Colors.transparent,
                  actions: [
                    Image.asset("assets/images/man.png"),
                    SizedBox(width: screenWidth * 0.04),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.20, // Adjust spacing from top
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                              top: screenHeight * 0.02,
                              bottom: screenHeight * 0.02,
                            ),
                            width: screenWidth * 0.2,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  kPrimaryColor,
                                  const Color(0xFF006666),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Quiz details",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontSize: screenWidth * 0.06,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.08,
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(0.36),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomDetailedContainer(
                                  icon: Icons.article_outlined,
                                ),
                                CustomDetailedText(
                                  text: "1 Question",
                                ),
                                CustomDetailedContainer(
                                  icon: Icons.access_alarm,
                                ),
                                CustomDetailedText(
                                  text: "30 seconds",
                                ),
                                CustomDetailedContainer(
                                  icon: Icons.star_outline,
                                ),
                                CustomDetailedText(
                                  text: "10 Points",
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Brief explanation about quiz",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.00),
                        Expanded(
                          child: ListView(
                            children: const [
                              CustomListTile(
                                title:
                                    "10 points awarded for a correct answer and no points for an incorrect answer",
                              ),
                              CustomListTile(
                                title:
                                    "30 seconds allotted to answer one question.",
                              ),
                              CustomListTile(
                                title:
                                    "Tap on options to select the correct answer",
                              ),
                              CustomListTile(
                                title:
                                    "Tap on the button Next to move to the next question",
                              ),
                              CustomListTile(
                                title:
                                    "Click submit if you completed all the questions",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        GestureDetector(
                          onTap: () {
                            playSound();
                            Navigator.popAndPushNamed(
                              context,
                              HomePage.id,
                              arguments: email,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: screenHeight * 0.02,
                            ),
                            width: double.infinity,
                            height: screenHeight * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xff008080),
                                  Color(0xFF006666),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Let's Play",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: screenWidth * 0.04,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(
              Icons.circle,
              size: 11,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDetailedText extends StatelessWidget {
  const CustomDetailedText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.04,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class CustomDetailedContainer extends StatelessWidget {
  const CustomDetailedContainer({
    super.key,
    required this.icon,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff008080),
            Color(0xff006666),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Icon(
          icon,
          size: MediaQuery.of(context).size.width * 0.04,
          color: Colors.white,
        ),
      ),
    );
  }
}
