import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/data.dart';
import 'package:quiz_app/widgets/history_container.dart';

class SecoundProfileTab extends StatelessWidget {
   SecoundProfileTab({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;
  final LinearGradient gradient = const LinearGradient(
    colors: [
      Color(0xFF008080),
      Color(0xFF006666),
    ],
  );
  final CategoriesData catdata = CategoriesData();

  String getImageForCategory(String categoryName) {
    categoryName = categoryName.replaceFirst("Science: ", "");
    categoryName = categoryName.replaceAll("Entertainment: ", "");
    for (var category in catdata.catList) {
      if (category['name'] == categoryName) {
        return category['image'];
      }
    }
    // If category name is not found, return a default image or null
    return ''; // You can change this to return a default image path if needed
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02, // Adjust vertical padding based on screen height
        horizontal: screenWidth * 0.05, // Adjust horizontal padding based on screen width
      ),
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: data["history"].length,
        itemBuilder: (context, index) {
          int score = data["history"][index]["earnedPoints"];
          String catName = data["history"][index]["catName"];
          Timestamp date = data["history"][index]["date"];
          String dateString =
              "${date.toDate().day.toString()}/${date.toDate().month.toString()}/${date.toDate().year.toString()} | ${date.toDate().hour.toString()}:${date.toDate().minute.toString()}";
          String difficulty = data["history"][index]["difficulty"];
          int correctQuestions = data["history"][index]["correctQuestions"];
          int questionNumbers = data["history"][index]["questionNumbers"];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // Adjust vertical spacing based on screen height
            child: HistoryContainer(
              gradient: gradient,
              title: "Earned $score points on the $difficulty quiz",
              subtitle: catName,
              date: dateString,
              correct: "$correctQuestions/$questionNumbers Correct",
              image: getImageForCategory(catName),
            ),
          );
        },
      ),
    );
  }
}
