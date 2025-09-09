import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/widgets/loading_widget.dart';
import 'home_page.dart';

class LeaderBoardPage extends StatelessWidget {
  final String email;
  LeaderBoardPage({super.key, required this.email});

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
            backgroundColor: kPrimaryColor,
            body: const LoadingWidget(color: Colors.white),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Scaffold(
            backgroundColor: kPrimaryColor,
            body: const Center(
              child: Text(
                "No players yet!",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          );
        }

        // Convert docs to User model
        List<User> users =
        snapshot.data!.docs.map((e) => User.fromjson(e.data())).toList();

        return Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, HomePage.id,
                    arguments: email);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 600;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // 🔹 Podium Row
                  Positioned(
                    top: isWide ? -50 : -40, // adjust this to give space from top
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (users.length > 1)
                          PodiumCard(
                            user: users[1],
                            rank: 2,
                            size: isWide ? 80 : 65,
                            height: isWide ? 190 : 150,
                          ),
                        if (users.isNotEmpty)
                          PodiumCard(
                            user: users[0],
                            rank: 1,
                            size: isWide ? 100 : 85,
                            height: isWide ? 230 : 180,
                            crown: true,
                          ),
                        if (users.length > 2)
                          PodiumCard(
                            user: users[2],
                            rank: 3,
                            size: isWide ? 80 : 65,
                            height: isWide ? 170 : 140,
                          ),
                      ],
                    ),
                  ),

                  // 🔹 Leaderboard List Container
// 🔹 Leaderboard List Container
                  Positioned(
                    top: isWide ? 10 : 310, // slightly overlaps podium
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: users.length > 3 ? users.length - 3 : 0,
                        itemBuilder: (context, index) {
                          final user = users[index + 3];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xfff5fafa),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // 🔹 Rank circle with outline
                                Container(
                                  width: isWide ? 46 : 40,
                                  height: isWide ? 46 : 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xff66b2b2),
                                    border: Border.all(
                                      color: Colors.teal, // outline color
                                      width: 0.8,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${index + 4}",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: isWide ? 18 : 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // 🔹 Name
                                Expanded(
                                  child: Text(
                                    user.userName,
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: isWide ? 18 : 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff2B262D),
                                    ),
                                  ),
                                ),

                                // 🔹 Score
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff66b2b2),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.teal, // outline color
                                      width: 0.8,
                                    ),
                                  ),
                                  child: Text(
                                    "${user.score} pts",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: isWide ? 16 : 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

// 🔥 Podium Card Widget
class PodiumCard extends StatelessWidget {
  final User user;
  final int rank;
  final double size;
  final double height;
  final bool crown;

  const PodiumCard({
    super.key,
    required this.user,
    required this.rank,
    required this.size,
    required this.height,
    this.crown = false,
  });

  @override
  Widget build(BuildContext context) {
    String avatarPath;
    if (rank == 1) {
      avatarPath = "assets/icons/first.png";
    } else if (rank == 2) {
      avatarPath = "assets/icons/second.png";
    } else if (rank == 3) {
      avatarPath = "assets/icons/third.png";
    } else {
      avatarPath = "assets/images/man1.png";
    }

    return Column(
      children: [
        if (crown)
          const Icon(Icons.emoji_events,
              color: Colors.amber, size: 40), // Crown for 1st

        CircleAvatar(
          radius: size / 2,
          backgroundColor: const Color(0xff66b2b2),
          backgroundImage: AssetImage(avatarPath),
        ),
        const SizedBox(height: 6),
        Text(
          user.userName,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontSize: size * 0.25,
            color: Colors.white,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: height,
          width: size * 1.3,
          decoration: BoxDecoration(
            gradient: rank == 1
                ? const LinearGradient(
              colors: [
                Color(0xFF5eead4),
                Color(0xFF14b8a6),
                Color(0xFF0f766e),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
                : const LinearGradient(
              colors: [
                Color(0xff66b2b2),
                Color(0xff4e9999),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2, // reduced blur
                offset: Offset(0, 1), // smaller offset
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$rank",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "${user.score} pts",
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
