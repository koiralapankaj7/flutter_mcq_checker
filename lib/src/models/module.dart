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
  final List<dynamic> answer;

  static final String _columnId = 'id';
  static final String _columnModule = 'module';
  static final String _columnYear = 'year';
  static final String _columnSem = 'sem';
  static final String _columnGroup = 'sgroup';
  static final String _columnMarker = 'marker';
  static final String _columnKids = 'kids';
  static final String _columnAnswer = 'answer';

  Module(String module, int year, int sem, String group, String marker,
      List<int> kids, List<int> answers)
      : this.module = module,
        this.year = year,
        this.sem = sem,
        this.group = group,
        this.marker = marker,
        this.kids = kids,
        this.answer = answers;

  // to get data from database
  Module.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson[_columnId],
        module = parsedJson[_columnModule],
        year = parsedJson[_columnYear],
        sem = parsedJson[_columnSem],
        group = parsedJson[_columnGroup],
        marker = parsedJson[_columnMarker],
        kids = jsonDecode(parsedJson[_columnKids]),
        answer = jsonDecode(parsedJson[_columnAnswer]);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _columnModule: module,
      _columnYear: year,
      _columnSem: sem,
      _columnGroup: group,
      _columnMarker: marker,
      _columnKids: jsonEncode(kids),
      _columnAnswer: jsonEncode(answer),
    };
  }
}
