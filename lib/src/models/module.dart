import 'dart:convert';

class Module {
  // Primary key
  int id;
  // Module name
  final String module;
  // Student year
  final int year;
  // Student sem
  final int sem;
  // Student group
  final String group;
  // Marker name
  final String marker;
  // List of students id
  final List<dynamic> kids;
  // Map of correct answers. <questionNo, Answer>
  final List<dynamic> answers;

  // Columns in database
  static final String _columnId = 'id';
  static final String _columnModule = 'module';
  static final String _columnYear = 'year';
  static final String _columnSem = 'sem';
  static final String _columnGroup = 'sGroup';
  static final String _columnMarker = 'marker';
  static final String _columnKids = 'kids';
  static final String _columnAnswer = 'answer';

  // Set answers
  void setAnswers(Map<int, String> answers) {
    this.answers.add(answers);
  }

  Module(this.module, this.year, this.sem, this.group, this.marker, this.kids,
      this.answers);

  // to get data from database
  Module.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson[_columnId],
        module = parsedJson[_columnModule],
        year = parsedJson[_columnYear],
        sem = parsedJson[_columnSem],
        group = parsedJson[_columnGroup],
        marker = parsedJson[_columnMarker],
        kids = jsonDecode(parsedJson[_columnKids]),
        answers = jsonDecode(parsedJson[_columnAnswer]);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _columnModule: module,
      _columnYear: year,
      _columnSem: sem,
      _columnGroup: group,
      _columnMarker: marker,
      _columnKids: jsonEncode(kids),
      _columnAnswer: jsonEncode(answers),
    };
  }
}
