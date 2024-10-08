import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/data.dart';
import 'package:quiz_app/widgets/stats_container.dart';

class FirstProfileTab extends StatelessWidget {
   FirstProfileTab({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> historyList = [];
  final List<Map<String, dynamic>> strongestCat = [];
  final List<Map<String, dynamic>> weakestCat = [];
  final LinearGradient gradient = const LinearGradient(
    colors: [
      Color(0xFF008080),
      Color(0xFF006666),
    ],
  );
  bool exist = false;
  int? index;
  final CategoriesData catdata = CategoriesData();

  String getImageForCategory(String categoryName) {
    categoryName = categoryName.replaceFirst("Science: ", "");
    categoryName = categoryName.replaceFirst("Entertainment: ", "");
    for (var category in catdata.catList) {
      if (category['name'] == categoryName) {
        return category['image'];
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    List<dynamic> history = data["history"];
    historyList.add({
      'catName': history[0]["catName"],
      'correctQuestions': history[0]["correctQuestions"],
      'questionNumbers': history[0]["questionNumbers"],
    });
    for (int i = 1; i < history.length; i++) {
      bool exist = false;
      for (int j = 0; j < historyList.length; j++) {
        if (history[i]["catName"] == historyList[j]["catName"]) {
          exist = true;
          index = j;
          break;
        }
      }
      if (!exist) {
        historyList.add({
          'catName': history[i]["catName"],
          'correctQuestions': history[i]["correctQuestions"],
          'questionNumbers': history[i]["questionNumbers"],
        });
      } else {
        historyList[index!]['correctQuestions'] +=
        history[i]["correctQuestions"];
        historyList[index!]['questionNumbers'] += history[i]["questionNumbers"];
      }
    }
    for (int i = 0; i < historyList.length; i++) {
      double percentage = (historyList[i]["correctQuestions"] * 100) /
          historyList[i]["questionNumbers"];
      if (percentage >= 50) {
        strongestCat.add({
          "catName": historyList[i]["catName"],
          "percentage": percentage.round(),
          "image": getImageForCategory(historyList[i]["catName"])
        });
      } else {
        weakestCat.add({
          "catName": historyList[i]["catName"],
          "percentage": percentage.round(),
          "image": getImageForCategory(historyList[i]["catName"])
        });
      }
    }
    final double accuracy =
        (data["correctAnswer"] * 100) / data["totalQuestions"];
    final double progress = (data["totalQuestions"] * 100) / 19206;
    final double averageScore = data["score"] / data["totalQuestions"];

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.03, // Adjust vertical padding
        horizontal: screenWidth * 0.05, // Adjust horizontal padding
      ),
      child: ListView(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatsContainer(
                color: const Color(0xffFEA704).withOpacity(0.2),
                image: "assets/icons/search 1.png",
                subTitle: "Quizzes",
                title: "${data["quizTaken"]}",
              ),
              StatsContainer(
                color: const Color(0xffD1AEE5).withOpacity(0.35),
                image: "assets/icons/bar.png",
                subTitle: "Avg.Score",
                title: "${averageScore.round()}",
                size: screenWidth * 0.03, // Adjust text size
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02), // Adjust spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatsContainer(
                color: const Color(0xff02BC7D).withOpacity(0.15),
                image: "assets/icons/checkmark.png",
                subTitle: "Accuracy",
                title: "${accuracy.round()}%",
              ),
              StatsContainer(
                color: const Color(0xff4DC3FF).withOpacity(0.15),
                image: "assets/icons/rise 1.png",
                subTitle: "Progress",
                title: progress.toStringAsFixed(2) + '%',
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03), // Adjust spacing
          strongestCat.isEmpty
              ? Container()
              : Text(
            "PERFORMANCEe",
            style: TextStyle(
              fontSize: screenWidth * 0.04, // Adjust font size
              fontWeight: FontWeight.w600,
              fontFamily: kFontText,
              color: Colors.white,
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // Adjust spacing
          strongestCat.isEmpty
              ? Container()
              : Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, // Adjust vertical padding
              horizontal: screenWidth * 0.03, // Adjust horizontal padding
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffA6ABBD).withOpacity(0.8),
                  spreadRadius: 0,
                  blurRadius: 18.5,
                  offset: const Offset(2.5, 2.5), // changes position of shadow
                ),
                BoxShadow(
                  color: const Color(0xffFAFBFF).withOpacity(0.4),
                  offset: const Offset(-1.24, -1.24),
                  blurRadius: 16,
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: strongestCat.length,
              itemBuilder: (context, index) => ProgressStatContainer(
                gradient: gradient,
                gradientPercentage: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xffFFD894),
                    Color(0xffFFD388),
                    Color(0xffFFB33E),
                    Color(0xffFF9801),
                    Color(0xffFFA113),
                    Color(0xffFFA318),
                    Color(0xffFF9900),
                  ],
                ),
                catName: strongestCat[index]["catName"],
                image: strongestCat[index]["image"],
                percentage: strongestCat[index]["percentage"],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03), // Adjust spacing
          weakestCat.isEmpty
              ? Container()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PERFORMANCE",
                style: TextStyle(
                  fontSize: screenWidth * 0.04, // Adjust font size
                  fontWeight: FontWeight.w600,
                  fontFamily: kFontText,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Adjust spacing
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02, // Adjust vertical padding
                  horizontal: screenWidth * 0.03, // Adjust horizontal padding
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffA6ABBD).withOpacity(0.8),
                      spreadRadius: 0,
                      blurRadius: 18.5,
                      offset: const Offset(2.5, 2.5), // changes position of shadow
                    ),
                    BoxShadow(
                      color: const Color(0xffFAFBFF).withOpacity(0.4),
                      offset: const Offset(-1.24, -1.24),
                      blurRadius: 16,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: weakestCat.length,
                  itemBuilder: (context, index) => ProgressStatContainer(
                    gradient: gradient,
                    gradientPercentage: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xff77CDFA),
                        Color(0xff2E7599),
                      ],
                    ),
                    catName: weakestCat[index]["catName"],
                    image: weakestCat[index]["image"],
                    percentage: weakestCat[index]["percentage"],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressStatContainer extends StatelessWidget {
  const ProgressStatContainer({
    super.key,
    required this.gradient,
    required this.percentage,
    required this.catName,
    required this.gradientPercentage,
    required this.image,
  });

  final LinearGradient gradient, gradientPercentage;
  final String image, catName;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.03), // Adjust margin
      child: Row(
        children: [
          Image.asset(
            image,
            width: screenWidth * 0.12, // Adjust image width
            height: screenWidth * 0.1, // Adjust image height
          ),
          SizedBox(width: screenWidth * 0.02), // Adjust spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (rect) => gradient.createShader(rect),
                      child: Text(
                        catName,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, // Adjust font size
                          fontFamily: "Oldenburg",
                        ),
                      ),
                    ),
                    Text(
                      "$percentage% Correct",
                      style: TextStyle(
                          color: const Color(0xffBDBDBD),
                          fontSize: screenWidth * 0.03, // Adjust font size
                          fontFamily: kFontText,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.02), // Adjust spacing
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  barRadius: const Radius.circular(15),
                  lineHeight: 16,
                  percent: percentage / 100,
                  backgroundColor: const Color(0xffDEDEDE),
                  linearGradient: gradientPercentage,
                  padding: EdgeInsets.zero,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
