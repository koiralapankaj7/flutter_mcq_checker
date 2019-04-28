import 'dart:convert';

class Student {
  // Primary key
  int id;
  // Student name
  final String name;
  // Answers provided by student Map<int, String> i.e Map of <QuestionNo, Answer>
  final List<dynamic> answers;

  // Columns in database
  static final String _columnId = 'id';
  static final String _columnName = 'name';
  static final String _columnAnswer = 'answers';

  Student(this.name, this.answers);

  Student.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson[_columnId],
        name = parsedJson[_columnName],
        answers = jsonDecode(parsedJson[_columnAnswer]);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _columnName: name,
      _columnAnswer: answers,
    };
  }
}
