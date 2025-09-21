import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/question_page.dart';
import 'home_page.dart';

class CatSettingsPage extends StatefulWidget {
  const CatSettingsPage({
    super.key,
    required this.catId,
    required this.email,
  });

  final int catId;
  final String email;

  @override
  State<CatSettingsPage> createState() => _CatSettingsPageState();
}

class _CatSettingsPageState extends State<CatSettingsPage> {
  String? difficulty;
  String? type;
  int? questionNumbers;

  int difficultySelectedindex = -1;
  int typeSelectedIndex = -1;
  int questionIndex = -1;

  final AudioPlayer player = AudioPlayer();
  final AudioPlayer player2 = AudioPlayer();

  Future<void> playSound2() async {
    await player2.play(AssetSource("sounds/456601__bumpelsnake__select10.wav"));
  }

  Future<void> playSound() async {
    await player.play(AssetSource("sounds/click-button-app-147358.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseWidth = 400; // Design reference width
    final double scaleFactor = screenSize.width / baseWidth;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Montserrat'),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 8 * scaleFactor, vertical: 5 * scaleFactor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.popAndPushNamed(
                        context,
                        HomePage.id,
                        arguments: widget.email,
                      ),
                      icon: Icon(Icons.arrow_back, size: 28 * scaleFactor),
                    ),
                    SizedBox(width: 48 * scaleFactor),
                  ],
                ),
              ),

              // Progress indicator
              LinearProgressIndicator(
                value: 0.66,
                backgroundColor: Colors.grey.shade300,
                color: Colors.teal,
                minHeight: 5 * scaleFactor,
              ),

              SizedBox(height: 20 * scaleFactor),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16 * scaleFactor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategoryContainer(
                        scaleFactor: scaleFactor,
                        icon: Icons.bolt,
                        title: "Difficulty",
                        trailing: Text(
                          "Pick a challenge level",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11 * scaleFactor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: Wrap(
                          spacing: 8 * scaleFactor,
                          runSpacing: 8 * scaleFactor,
                          children: [
                            _buildSelectableChip(
                              scaleFactor: scaleFactor,
                              label: "Expert",
                              isSelected: difficultySelectedindex == 0,
                              onTap: () {
                                playSound2();
                                setState(() {
                                  difficultySelectedindex =
                                  difficultySelectedindex == 0 ? -1 : 0;
                                  difficulty = difficultySelectedindex == -1
                                      ? null
                                      : "hard";
                                });
                              },
                            ),
                            _buildSelectableChip(
                              scaleFactor: scaleFactor,
                              label: "Standard",
                              isSelected: difficultySelectedindex == 1,
                              onTap: () {
                                playSound2();
                                setState(() {
                                  difficultySelectedindex =
                                  difficultySelectedindex == 1 ? -1 : 1;
                                  difficulty = difficultySelectedindex == -1
                                      ? null
                                      : "medium";
                                });
                              },
                            ),
                            _buildSelectableChip(
                              scaleFactor: scaleFactor,
                              label: "Beginner",
                              isSelected: difficultySelectedindex == 2,
                              onTap: () {
                                playSound2();
                                setState(() {
                                  difficultySelectedindex =
                                  difficultySelectedindex == 2 ? -1 : 2;
                                  difficulty = difficultySelectedindex == -1
                                      ? null
                                      : "easy";
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16 * scaleFactor),

                      _buildCategoryContainer(
                        scaleFactor: scaleFactor,
                        icon: Icons.help_outline,
                        title: "Question Mode",
                        trailing: Text(
                          "Select format",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11 * scaleFactor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: Center(
                          child: Wrap(
                            spacing: 8 * scaleFactor,
                            runSpacing: 8 * scaleFactor,
                            children: [
                              _buildSelectableChip(
                                scaleFactor: scaleFactor,
                                label: "True/False",
                                isSelected: typeSelectedIndex == 0,
                                onTap: () {
                                  playSound2();
                                  setState(() {
                                    typeSelectedIndex =
                                    typeSelectedIndex == 0 ? -1 : 0;
                                    type = typeSelectedIndex == -1
                                        ? null
                                        : "boolean";
                                  });
                                },
                              ),
                              _buildSelectableChip(
                                scaleFactor: scaleFactor,
                                label: "Multiple Choice",
                                isSelected: typeSelectedIndex == 1,
                                onTap: () {
                                  playSound2();
                                  setState(() {
                                    typeSelectedIndex =
                                    typeSelectedIndex == 1 ? -1 : 1;
                                    type = typeSelectedIndex == -1
                                        ? null
                                        : "multiple";
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16 * scaleFactor),

                      _buildCategoryContainer(
                        scaleFactor: scaleFactor,
                        icon: Icons.quiz_outlined,
                        title: "Questions",
                        trailing: Text(
                          "Choose total",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11 * scaleFactor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: Center(
                          child: Wrap(
                            spacing: 8 * scaleFactor,
                            runSpacing: 8 * scaleFactor,
                            children: [
                              _buildSelectableChip(
                                scaleFactor: scaleFactor,
                                label: "5 Questions",
                                isSelected: questionIndex == 0,
                                onTap: () {
                                  playSound2();
                                  setState(() {
                                    questionIndex = questionIndex == 0 ? -1 : 0;
                                    questionNumbers =
                                    questionIndex == -1 ? null : 5;
                                  });
                                },
                              ),
                              _buildSelectableChip(
                                scaleFactor: scaleFactor,
                                label: "10 Questions",
                                isSelected: questionIndex == 1,
                                onTap: () {
                                  playSound2();
                                  setState(() {
                                    questionIndex = questionIndex == 1 ? -1 : 1;
                                    questionNumbers =
                                    questionIndex == -1 ? null : 10;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10 * scaleFactor),

                      const Divider(thickness: 0.4, color: Colors.grey),

                      if (difficulty != null ||
                          type != null ||
                          questionNumbers != null)
                        Padding(
                          padding: EdgeInsets.only(top: 8 * scaleFactor),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Setup: ",
                                style: TextStyle(
                                  fontSize: 14 * scaleFactor,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 5 * scaleFactor),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (difficulty != null)
                                      _buildSetupChip(
                                          difficulty!.capitalize(), scaleFactor),
                                    if (type != null)
                                      _buildSetupChip(type!, scaleFactor),
                                    if (questionNumbers != null)
                                      _buildSetupChip(
                                          "$questionNumbers Questions",
                                          scaleFactor),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16 * scaleFactor),
                child: SizedBox(
                  width: screenSize.width * 0.45, // ✅ Responsive width
                  height: 50 * scaleFactor,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.play_arrow,
                        color: Colors.white, size: 22 * scaleFactor),
                    label: Text(
                      "Start",
                      style: TextStyle(fontSize: 16 * scaleFactor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2 * scaleFactor),
                      ),
                    ),
                    onPressed: (difficulty != null &&
                        type != null &&
                        questionNumbers != null)
                        ? () {
                      playSound();
                      Navigator.push(
                        context,
                        PageTransition(
                          child: QuestionPage(
                            email: widget.email,
                            type: type!,
                            catId: widget.catId.toString(),
                            questionNumber: questionNumbers.toString(),
                            difficulty: difficulty!,
                          ),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 300),
                        ),
                      );
                    }
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryContainer({
    required IconData icon,
    required String title,
    required Widget child,
    Widget? trailing,
    required double scaleFactor,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25 * scaleFactor),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16 * scaleFactor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.teal, size: 22 * scaleFactor),
              SizedBox(width: 8 * scaleFactor),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18 * scaleFactor,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              if (trailing != null) trailing,
            ],
          ),
          SizedBox(height: 30 * scaleFactor),
          child,
        ],
      ),
    );
  }

  Widget _buildSelectableChip({
    required String label,
    String? subLabel,
    required bool isSelected,
    required VoidCallback onTap,
    required double scaleFactor,
  }) {
    return ChoiceChip(
      label: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 13 * scaleFactor,
            ),
          ),
          if (subLabel != null)
            Text(
              subLabel,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 10 * scaleFactor,
                color: Colors.grey,
              ),
            ),
        ],
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: isSelected ? Colors.teal : Colors.grey,
          width: 0.5,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: Colors.teal.shade100,
      backgroundColor: Colors.grey.shade200,
      showCheckmark: false,
    );
  }

  Widget _buildSetupChip(String text, double scaleFactor) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * scaleFactor),
        child: Chip(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18 * scaleFactor),
          ),
          label: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13 * scaleFactor,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}

extension StringCasing on String {
  String capitalize() =>
      isEmpty ? this : "${this[0].toUpperCase()}${substring(1)}";
}
