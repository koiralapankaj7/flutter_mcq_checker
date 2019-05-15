// import 'package:flutter/material.dart';
// import 'package:flutter_mcq_checker/src/blocs/module_provider.dart';
// import 'package:flutter_mcq_checker/src/models/module.dart';
// import 'package:flutter_mcq_checker/src/widgets/circle_check_box.dart';

// class AddAnswer extends StatelessWidget {
//   //
//   //
//   final Module module;
//   final ModuleBloc bloc;
//   // This list is used just for setting size of the list as per number of question
//   // This list is accessed by circle check box to initialize list with fixed size
//   static List<String> answersList;

//   AddAnswer({this.module, this.bloc});

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
//           stream: bloc.validTotalQuestion,
//           builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//             if (snapshot.hasData) {
//               return selectAnswersWidget(snapshot.data);
//             }
//             return totalNoOfQuestionWidget();
//           },
//         ),
//       ),
//     );
//   }

//   Widget totalNoOfQuestionWidget() {
//     return StreamBuilder(
//       stream: bloc.totalQuestions,
//       builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//         return Row(
//           children: <Widget>[
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: TextField(
//                   onChanged: bloc.changeTotalQuestion,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     hintText: '10',
//                     labelText: 'Number of questions',
//                     errorText: snapshot.error,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             CircleAvatar(
//               child: IconButton(
//                 onPressed: snapshot.data == null
//                     ? null
//                     : () {
//                         bloc.changeValidTotalQuestion(int.parse(snapshot.data));
//                       },
//                 icon: Icon(Icons.add),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget selectAnswersWidget(int totalQuestions) {
//     answersList = List(totalQuestions);

//     return ListView.builder(
//       padding: EdgeInsets.all(16.0),
//       itemCount: totalQuestions + 1,
//       itemBuilder: (BuildContext context, int index) {
//         // Button
//         if (index == totalQuestions) {
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
//                   //     activateButton = false;
//                   //     return;
//                   //   } else {
//                   //     activateButton = true;
//                   //   }
//                   // });
//                   for (var ans in snapshot.data) {
//                     if (ans == null) {
//                       activateButton = false;
//                       break;
//                     } else {
//                       activateButton = true;
//                     }
//                   }
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
//                   child: Text('Add answers'.toUpperCase()),
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
