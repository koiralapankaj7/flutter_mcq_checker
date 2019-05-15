// import 'package:flutter/material.dart';
// import 'package:flutter_mcq_checker/src/blocs/module_provider.dart';
// import 'package:flutter_mcq_checker/src/models/module.dart';
// import 'package:flutter_mcq_checker/src/widgets/circle_check_box.dart';

// class EditAnswerScreen extends StatelessWidget {
//   //
//   //
//   final Module module;
//   final ModuleBloc bloc;
//   // This list is used just for setting size of the list as per number of question
//   // This list is accessed by circle check box to initialize list with fixed size
//   static List<String> answersList;

//   EditAnswerScreen({this.module, this.bloc});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Text('Answers for ${module.module}'),
//       ),
//       body: buildBody(),
//     );
//   }

//   Widget buildBody() {
//     return Center(
//       child: Container(
//         margin: EdgeInsets.all(24.0),
//         child: StreamBuilder(
//           stream: bloc.answers,
//           builder:
//               (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
//             if (snapshot.hasData) {
//               return selectAnswersWidget(snapshot.data);
//             }
//             return CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }

//   Widget selectAnswersWidget(List<String> totalQuestions) {
//     answersList = totalQuestions;

//     return ListView.builder(
//       padding: EdgeInsets.all(16.0),
//       itemCount: answersList.length + 1,
//       itemBuilder: (BuildContext context, int index) {
//         // Button
//         if (index == answersList.length) {
//           return buttons();
//         }

//         return Container(
//           margin: EdgeInsets.only(bottom: 2.0),
//           color: Colors.white70,
//           child: Row(
//             children: <Widget>[
//               SizedBox(width: 16.0),
//               CircleAvatar(
//                 child: Text('${index + 1}'),
//               ),
//               SizedBox(width: 24.0),
//               CircleCheckBox(index: index, answer: 'A', answers: answersList),
//               CircleCheckBox(index: index, answer: 'B', answers: answersList),
//               CircleCheckBox(index: index, answer: 'C', answers: answersList),
//               CircleCheckBox(index: index, answer: 'D', answers: answersList),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget buttons() {
//     bool activateButton = false;
//     return Column(
//       children: <Widget>[
//         Container(
//           margin: EdgeInsets.only(top: 24.0),
//           child: StreamBuilder(
//               stream: bloc.answers,
//               builder:
//                   (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
//                 if (snapshot.hasData) {
//                   // snapshot.data.forEach((String answer) {
//                   //   if (answer == null) {
//                   //     print('Answer is $answer');
//                   //     activateButton = false;
//                   //     return;
//                   //   } else {
//                   //     activateButton = true;
//                   //   }

//                   //   print('Inside loop $answer');
//                   // });

//                   for (var ans in snapshot.data) {
//                     if (ans == null) {
//                       activateButton = false;
//                       break;
//                     } else {
//                       activateButton = true;
//                     }
//                   }

//                   // snapshot.data
//                   //     .takeWhile((String ans) => ans != null)
//                   //     .forEach((String answer) {
//                   //   if (answer == null) {
//                   //     activateButton = false;
//                   //     return;
//                   //   } else {
//                   //     activateButton = true;
//                   //   }
//                   // });
//                 }

//                 return MaterialButton(
//                   onPressed: activateButton
//                       ? () {
//                           addAnswer(context);
//                         }
//                       : null,
//                   color: Colors.lightBlue,
//                   textColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50.0),
//                   ),
//                   child: Text('Update answers'.toUpperCase()),
//                 );
//               }),
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 8.0),
//           child: MaterialButton(
//             onPressed: () {
//               bloc.changeValidTotalQuestion(null);
//               bloc.changeTotalQuestion('');
//             },
//             color: Colors.lightBlue,
//             textColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50.0),
//             ),
//             child: Text('Cancle'.toUpperCase()),
//           ),
//         ),
//       ],
//     );
//   }

//   addAnswer(BuildContext context) async {
//     try {
//       int result = await bloc.updateModule(module);

//       if (result == 1) {
//         Scaffold.of(context).showSnackBar(SnackBar(
//           content: Text('Answers added successfully ..'),
//         ));
//         bloc.changeValidTotalQuestion(null);
//         bloc.changeTotalQuestion('');
//       } else {
//         Scaffold.of(context).showSnackBar(SnackBar(
//           content: Text('Something went wrong..'),
//         ));
//       }
//     } catch (e) {
//       Scaffold.of(context).showSnackBar(SnackBar(
//         content: Text(e),
//       ));
//     }
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_mcq_checker/src/blocs/module_bloc.dart';
// // import 'package:flutter_mcq_checker/src/models/module.dart';
// // import 'package:flutter_mcq_checker/src/widgets/circle_check_box.dart';
// // import 'package:flutter_mcq_checker/src/widgets/reveal_edit_textfield.dart';

// // class EditAnswerScreen extends StatelessWidget {
// //   final ModuleBloc bloc;
// //   final Module module;
// //   EditAnswerScreen({this.bloc, this.module});

// //   static List<String> answersList;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         title: Text('Edit answer'),
// //       ),
// //       body: StreamBuilder(
// //         stream: bloc.answers,
// //         builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
// //           if (snapshot.hasData) {
// //             print('Stream is called');
// //             answersList = snapshot.data;
// //             return selectAnswersWidget();
// //           } else {
// //             return Center(
// //               child: Text('You did not add answers for this module'),
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }

// //   Widget buildBody() {
// //     return ListView.builder(
// //       itemCount: answersList.length + 1,
// //       padding: EdgeInsets.all(8.0),
// //       itemBuilder: (BuildContext context, int index) {
// //         if (index == answersList.length) {
// //           return buttons();
// //         }
// //         return Container(
// //           color: Colors.grey,
// //           margin: EdgeInsets.only(bottom: 2.0),
// //           child: ListTile(
// //             leading: CircleAvatar(
// //               child: Text('${index + 1}'),
// //             ),
// //             title: Text(
// //               '${answersList[index]}',
// //               style: TextStyle(color: Colors.white),
// //             ),
// //             trailing: RevealTextField(index: index),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget selectAnswersWidget() {
// //     //answersList = List(totalQuestions);

// //     return ListView.builder(
// //       padding: EdgeInsets.all(16.0),
// //       itemCount: answersList.length + 1,
// //       itemBuilder: (BuildContext context, int index) {
// //         // Button
// //         if (index == answersList.length) {
// //           return buttons();
// //         }

// //         return Container(
// //           margin: EdgeInsets.only(bottom: 2.0),
// //           color: Colors.white70,
// //           child: Row(
// //             children: <Widget>[
// //               SizedBox(width: 16.0),
// //               CircleAvatar(
// //                 child: Text('${index + 1}'),
// //               ),
// //               SizedBox(width: 24.0),
// //               CircleCheckBox(index: index, answer: 'A'),
// //               CircleCheckBox(index: index, answer: 'B'),
// //               CircleCheckBox(index: index, answer: 'C'),
// //               CircleCheckBox(index: index, answer: 'D'),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget buttons() {
// //     bool activateBUtton = false;
// //     return Column(
// //       children: <Widget>[
// //         Container(
// //           margin: EdgeInsets.only(top: 24.0),
// //           child: StreamBuilder(
// //               stream: bloc.answers,
// //               builder:
// //                   (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
// //                 if (snapshot.hasData) {
// //                   snapshot.data.forEach((String answer) {
// //                     if (answer == null) {
// //                       activateBUtton = false;
// //                       return;
// //                     } else {
// //                       activateBUtton = true;
// //                     }
// //                   });
// //                 }
// //                 return MaterialButton(
// //                   onPressed: activateBUtton
// //                       ? () {
// //                           //addAnswer(context);
// //                         }
// //                       : null,
// //                   color: Colors.lightBlue,
// //                   textColor: Colors.white,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(50.0),
// //                   ),
// //                   child: Text('Update'.toUpperCase()),
// //                 );
// //               }),
// //         ),
// //         Container(
// //           margin: EdgeInsets.only(top: 8.0),
// //           child: MaterialButton(
// //             onPressed: () {
// //               bloc.changeValidTotalQuestion(null);
// //               bloc.changeTotalQuestion('');
// //             },
// //             color: Colors.lightBlue,
// //             textColor: Colors.white,
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(50.0),
// //             ),
// //             child: Text('Cancle'.toUpperCase()),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
