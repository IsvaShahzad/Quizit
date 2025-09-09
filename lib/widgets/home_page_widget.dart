import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/constants.dart';

import 'package:quiz_app/widgets/custom_searchbar.dart';
import 'package:quiz_app/widgets/drawer_list_tile.dart';

import '../screens/details_page.dart';
import '../screens/homePage_tabs/first_tab.dart';
import '../screens/homePage_tabs/secound_tab.dart';
import '../screens/homePage_tabs/third_tab.dart';
import '../screens/leader_board_page.dart';
import '../screens/login_page.dart';
import '../screens/profile_page.dart';
import '../screens/question_setting.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    super.key,
    required this.username,
    required this.email,
    required this.score,
    required this.data,
    this.first = false,
  });

  final String? username, email;
  static String id = "/homePageWidget";
  final int score;
  final Map<String, dynamic> data;
  final bool first;

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  int selectedIndex = -1;
  int? idCat;
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  Future<void> playSound() async {
    String soundPath = "sounds/click-button-app-147358.mp3";
    await player.play(AssetSource(soundPath));
  }

  void updateIndex(int index, int? id) {
    setState(() {
      selectedIndex = index;
      idCat = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFF008080),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF008080),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/man1.png",
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.username!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${widget.score} points",
                      style: const TextStyle(
                        fontSize: 12.7,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Montserrat",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 45),

              // 🔹 Styled Drawer Tiles
              _buildStyledDrawerTile(
                context,
                icon: Icons.home,
                title: "Home",
                onTap: () {},
              ),
              _buildStyledDrawerTile(
                context,
                icon: Icons.map_outlined,
                title: "Walkthrough",
                onTap: () {
                  Navigator.of(context).push(
                    PageTransition(
                      child: AddPage(email: widget.email!),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
              _buildStyledDrawerTile(
                context,
                icon: Icons.person_outline,
                title: "Account",
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageTransition(
                      child: ProfilePage(
                        email: widget.email!,
                        data: widget.data,
                      ),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
              _buildStyledDrawerTile(
                context,
                icon: Icons.emoji_events_outlined,
                title: "Ranking Board",
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: LeaderBoardPage(email: widget.email!),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
              _buildStyledDrawerTile(
                context,
                icon: Icons.login_outlined,
                title: "Logout",
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.popAndPushNamed(context, LogInPage.id);
                },
              ),
            ],
          ),
        ),

        appBar: AppBar(
          automaticallyImplyLeading: false,
          clipBehavior: Clip.none,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.white,
                    ),
                  );
                },
              ),

            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: ProfilePage(email: widget.email!, data: widget.data),
                    type: PageTransitionType.size,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 500),
                    reverseDuration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Image.asset("assets/images/man1.png"),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Text(
                  "Hello, ${widget.username} ",
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Text(
                  "Your journey starts now!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // CustomSearchBar(email: widget.email!),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 12,
                    left: 12,
                    top: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                          width: 55,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                kPrimaryColor,
                                const Color(0xFF008080),
                              ],
                            ),
                          ),
                        ),
                        const TabBar(
                          labelPadding: EdgeInsets.all(1),
                          dividerColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          labelStyle: TextStyle(fontFamily: "Nunito", fontSize: 15),
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(color: Colors.teal, width: 3),
                          ),
                          labelColor: Colors.teal, // Set the text color for the selected tab
                          unselectedLabelColor: Colors.grey, // Optional: Set the text color for unselected tabs
                          tabs: [
                            Tab(text: "Entertainment"),
                            Tab(text: "Education"),
                            Tab(text: "Popular"),

                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              SecoundTab(updateIndex: updateIndex),
                              ThirdTab(updateIndex: updateIndex),
                              FirstTab(updateIndex: updateIndex),

                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (selectedIndex != -1) {
                              playSound();
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: CatSettingsPage(
                                    catId: idCat!,
                                    email: widget.email!,
                                  ),
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 300),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 55),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF008080),
                              borderRadius: BorderRadius.circular(1),
                            ),
                            child: const Center(
                              child: Text(
                                "Take Quiz",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
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
Widget _buildStyledDrawerTile(
    BuildContext context, {
      required IconData icon,
      required String title,
      required VoidCallback onTap,
    }) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  // Scale values relative to screen size
  double horizontalMargin = screenWidth * 0.02;
  double verticalMargin = screenHeight * 0.008;
  double fontSize = screenWidth * 0.04;
  double iconSize = screenWidth * 0.06;

  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: horizontalMargin,
      vertical: verticalMargin,
    ),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Colors.grey.shade300,
        width: 0.5,
      ),
    ),
    child: ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: Icon(
        icon,
        color: Colors.teal,
        size: iconSize,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey,
        size: iconSize * 0.8,
      ),
      onTap: onTap,
    ),
  );
}