// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// class Quiz extends StatefulWidget {
//   final List<Map<String, dynamic>> questions;
//
//   const Quiz({super.key, required this.questions});
//
//   @override
//   _QuizState createState() => _QuizState();
// }
//
// class _QuizState extends State<Quiz> {
//   int _currentQuestion = 0;
//   int _score = 0;
//   int _timeLeft = 30; // Adjust time limit as needed
//   Timer? _timer;
//
//   void startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _timeLeft--;
//       });
//       if (_timeLeft == 0) {
//         nextQuestion();
//       }
//     });
//   }
//
//   void stopTimer() {
//     _timer?.cancel();
//     _timer = null;
//   }
//
//   void nextQuestion() {
//     stopTimer();
//     _timeLeft = 30; // Reset timer for the next question
//
//     if (_currentQuestion + 1 < widget.questions.length) {
//       setState(() {
//         _currentQuestion++;
//       });
//       startTimer();
//     } else {
//       // Submit quiz if last question
//       submitQuiz();
//     }
//   }
//
//   void submitQuiz() {
//     // Implement your logic to submit the quiz results (e.g., show score)
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Quiz Submitted'),
//           content: Text('Your score: $_score out of ${widget.questions.length}'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     stopTimer();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_currentQuestion >= widget.questions.length) return Container();
//
//     final question = widget.questions[_currentQuestion];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Question ${_currentQuestion + 1} of ${widget.questions.length}'),
//                 Text('Time Left: $_timeLeft seconds'),
//               ],
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               question['question'],
//               style: TextStyle(fontSize: 18.0),
//             ),
//             SizedBox(height: 16.0),
//             for (int i = 0; i < question['options'].length; i++)
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle answer selection logic here (check answer, update score)
//                   setState(() {
//                     _score += (question['answer'] == i) ? 1 : 0; // Update score based on answer
//                   });
//                   nextQuestion();
//                 },
//                 child: Text(question['options'][i]),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:easy_quiz_game/easy_quiz_game.dart';
// import 'package:edmax/constants/quiz.dart';
// import 'package:edmax/screens/notifications.dart';
// import 'package:edmax/screens/side_menu.dart';
// import 'package:edmax/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Quiz extends StatefulWidget {
//   const Quiz({super.key});
//
//   @override
//   State<Quiz> createState() => _QuizState();
// }
//
// class _QuizState extends State<Quiz> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size(0, 130),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
//               child: Text(
//                 "Quiz",
//                 style: TextStyle(
//                   fontSize: 30,
//                 ),
//               ),
//             ),
//             const Divider(
//               indent: 15,
//               endIndent: 15,
//             ),
//           ],
//         ),
//       ),
//       drawer: SideMenu(),
//       body: EasyQuizGameApp(
//         quizCategories: data,
//         // primaryColor: Theme.of(context).primaryColor,
//         primaryColor: Colors.white,
//         menuLogoPath: 'assets/logo.jpg',
//         buttonPath: 'assets/button.png',
//         labelPath: 'assets/images/label.png',
//         bgImagePath: 'assets/images/bg.png',
//         gradient: LinearGradient(
//           stops: const [0, 1],
//           begin: const Alignment(1, -1),
//           end: const Alignment(0, 1),
//           colors: [Theme.of(context).primaryColor, const Color(0xff753bc6)],
//         ),
//         secondaryColor: const Color(0xff753bc6),
//       ),
//     );
//   }
// }

import 'package:edmax/constants/strings.dart';
import 'package:edmax/widgets/next_button.dart';
import 'package:edmax/widgets/option_card.dart';
import 'package:edmax/widgets/result_box.dart';
import 'package:flutter/material.dart';
import 'package:edmax/utils/colors.dart';
import 'package:edmax/models/question_model.dart';
import 'package:edmax/screens/question_widget.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Question> _questions = [
    Question(
      id: "10",
      title: "What is 2 + 2?",
      options: {'5': false, '44': false, '4': true, '22': false},
    ),
    Question(
      id: "11",
      title: "What is 10 + 12?",
      options: {'4': false, '1012': false, '6': false, '22': true},
    ),
  ];

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  void nextQuestion() {
    if (index == _questions.length - 1) {
      showDialog(context: context, builder: (ctx) => ResultBox(result: score, questionLength: _questions.length,));
    } else {
      if (isPressed == true) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Please Select atleast one option",
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 140.0, horizontal: 75.0),
          ),
        );
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
        setState(() {
          isPressed = true;
          isAlreadySelected = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 130),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
                  child: Text(
                    "Quiz",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Text(
                    'Score: $score',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            QuestionWidget(
                question: _questions[index].title,
                indexAction: index,
                totalQuestions: _questions.length),
            Divider(
              color: neutral,
            ),
            const SizedBox(
              height: 25.0,
            ),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap: () => checkAnswerAndUpdate(
                    _questions[index].options.values.toList()[i]),
                child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral,
                ),
              )
          ],
        ),
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: NextButton(nextQuestion: nextQuestion)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
