import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/widgets/loading_widget.dart';

class LeaderBoardPage extends StatelessWidget {
  LeaderBoardPage({super.key, required this.email});
  final String email;

  static String id = "/LeaderBoardPage";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .orderBy("score", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: const LoadingWidget(
              color: Colors.white,
            ),
            backgroundColor: kPrimaryColor,
          );
        } else if (snapshot.hasData) {
          List<User> users = [];
          List docIds = snapshot.data!.docs;
          for (int i = 0; i < docIds.length; i++) {
            users.add(User.fromjson(docIds[i].data()));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, HomePage.id,
                          arguments: email);
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
            backgroundColor: kPrimaryColor,
            body: LayoutBuilder(
              builder: (context, constraints) {
                // Determine the layout based on the screen width
                bool isWideScreen = constraints.maxWidth > 600;

                return Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: Column(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: isWideScreen
                              ? const EdgeInsets.symmetric(horizontal: 40)
                              : const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: LeaderBoardContainer(
                                  color: const Color(0xFFC0C0C0),
                                  size: isWideScreen ? 15 : 12,
                                  rank: 2,
                                  score: users[1].score,
                                  image: "assets/icons/knight.png",
                                  name: users[1].userName,
                                  bottom: isWideScreen ? 30 : 20,
                                  width: isWideScreen ? 60 : 50,
                                  height: isWideScreen ? 60 : 50,
                                ),
                              ),
                              Expanded(
                                child: LeaderBoardContainer(
                                  color: const Color(0xFFFFD700),
                                  size: isWideScreen ? 20 : 14,
                                  rank: 1,
                                  score: users[0].score,
                                  width: isWideScreen ? 90 : 70,
                                  height: isWideScreen ? 90 : 70,
                                  bottom: isWideScreen ? 60 : 50,
                                  image: "assets/icons/kingavatar.png",
                                  name: users[0].userName,
                                ),
                              ),
                              Expanded(
                                child: LeaderBoardContainer(
                                  color: const Color(0xFFCD7F32),
                                  size: isWideScreen ? 15 : 12,
                                  width: isWideScreen ? 60 : 50,
                                  height: isWideScreen ? 60 : 50,
                                  rank: 3,
                                  score: users[2].score,
                                  bottom: isWideScreen ? 30 : 20,
                                  image: "assets/icons/jester.png",
                                  name: users[2].userName,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: isWideScreen
                              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 20)
                              : const EdgeInsets.symmetric(horizontal: 3, vertical: 20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: users.length - 3,
                            itemBuilder: (context, index) => ListTile(
                              trailing: Material(
                                elevation: 3, // Adjust the elevation as needed
                                borderRadius: BorderRadius.circular(20), // Matches the container's borderRadius
                                color: Colors.transparent, // Needed to make the shadow visible
                                child: Container(
                                  width: isWideScreen ? 80 : 60,
                                  height: isWideScreen ? 35 : 26,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xff66b2b2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${users[index + 3].score}",
                                      style: TextStyle(
                                        fontSize: isWideScreen ? 20 : 15,
                                        fontFamily: "Montserrat",
                                        color: Color(0xff2B262D),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              leading: Material(
                                elevation: 3, // Adjust the elevation as needed
                                shape: const CircleBorder(),
                                color: Colors.transparent, // Needed to make the shadow visible
                                child: Container(
                                  width: isWideScreen ? 40 : 32,
                                  height: isWideScreen ? 40 : 32,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff66b2b2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 4}",
                                      style: TextStyle(
                                        fontSize: isWideScreen ? 22 : 17,
                                        fontFamily: "Montserrat",
                                        color: Color(0xff2B262D),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                users[index + 3].userName,
                                style: TextStyle(
                                    fontSize: isWideScreen ? 22 : 18,
                                    fontFamily: "Montserrat",
                                    color: Color(0xff2B262D)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Text(snapshot.error.toString());
        }
      },
    );
  }
}

class LeaderBoardContainer extends StatelessWidget {
  const LeaderBoardContainer({
    super.key,
    required this.image,
    required this.name,
    required this.rank,
    required this.score,
    required this.size,
    required this.color,
    required this.bottom,
    required this.width,
    required this.height,
  });
  final String name, image;
  final int rank, score;
  final double size, bottom, width, height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontFamily: kFontText,
            fontSize: size,
            fontWeight: FontWeight.w600,
          ),
        ),
        Material(
          elevation: 3, // Adjust the elevation to get the desired shadow
          shape: const CircleBorder(),
          color: Colors.transparent, // Makes sure the shadow is visible
          child: Container(
            margin: const EdgeInsets.only(bottom: 10, top: 5),
            padding: const EdgeInsetsDirectional.all(10),
            decoration: BoxDecoration(
              color: const Color(0xffE4D9F8),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 3),
            ),
            child: Image.asset(
              image,
              width: width,
              height: height,
            ),
          ),
        ),
        Material(
          elevation: 4, // Adjust the elevation value to get the desired shadow
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            width: width,
            padding: EdgeInsets.only(bottom: bottom),
            decoration: const BoxDecoration(
              color: Color(0xff66b2b2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "$rank",
                    style: const TextStyle(
                      fontSize: 65,
                      fontWeight: FontWeight.bold,
                      fontFamily: "DM Sans",
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${score}pts",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: kFontText,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
