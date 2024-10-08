import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile_tabs/first_tab.dart';
import 'package:quiz_app/screens/profile_tabs/secound_tab.dart';
import 'package:quiz_app/screens/profile_tabs/third_tab.dart';

import '../constants.dart';
import 'home_page.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.email,
    required this.data,
  });

  static String id = "/ProfilePage";
  final String email;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff008080),
              Color(0xff006666),
            ],
          ),
        ),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(
                        context,
                        HomePage.id,
                        arguments: email,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/man.png",
                  width: 70,
                  height: 70,
                ),
                Center(
                  child: Text(
                    data["username"],
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TabBar(
                  indicatorPadding: const EdgeInsets.only(right: 20),
                  indicatorColor: Colors.white,
                  dividerColor: Colors.transparent,
                  padding: const EdgeInsets.only(left: 10),
                  tabs: [
                    Tab(
                      icon: Container(
                        padding: const EdgeInsets.only(right: 20),
                        height: 25,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Stats",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: kFontText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      icon: Container(
                        height: 25,
                        padding: const EdgeInsets.only(right: 26),
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "History",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: kFontText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      icon: Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: Center(
                          child: Text(
                            "Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: kFontText,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    data["history"].isEmpty
                        ? Center(
                            child: Text(
                              "There is no Stats",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: kFontText,
                              ),
                            ),
                          )
                        : FirstProfileTab(data: data),
                    data["history"].isEmpty
                        ? Center(
                            child: Text(
                              "There is no History",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: kFontText,
                              ),
                            ),
                          )
                        : SecoundProfileTab(data: data),
                    ThirdProfileTab(data: data),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
