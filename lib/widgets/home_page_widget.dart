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
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF008080),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/man.png",
                      width: 74,
                      height: 74,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.username!,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: kFontText,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " ${widget.score} points",
                      style: TextStyle(
                        fontSize: 12.7,
                        fontWeight: FontWeight.w300,
                        fontFamily: kFontText,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 45),
              DrawerListTile(
                onTap: () {

                },
                icon: Icons.home,
                title: "Home",


              ),
              const SizedBox(height: 15),
              DrawerListTile(
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
                icon: Icons.help_outline,
                title: "Game Guide",
              ),
              const SizedBox(height: 15),
              DrawerListTile(
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
                icon: Icons.person_outline,
                title: "Account",
              ),
              const SizedBox(height: 15),
              DrawerListTile(
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
                icon: Icons.emoji_events_outlined,
                title: "Leaderboard",
              ),
              const SizedBox(height: 15),
              DrawerListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.popAndPushNamed(context, LogInPage.id);
                },
                icon: Icons.logout,
                title: "Logout",
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
              child: Image.asset("assets/images/man.png"),
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
                  "Test out your knowledge!",
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
                      borderRadius: BorderRadius.circular(32),
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
                            Tab(text: "Popular"),
                            Tab(text: "Entertainment"),
                            Tab(text: "Education"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              FirstTab(updateIndex: updateIndex),
                              SecoundTab(updateIndex: updateIndex),
                              ThirdTab(updateIndex: updateIndex),
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
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF008080),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Start Test",
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
