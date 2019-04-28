import 'package:flutter_mcq_checker/src/models/student.dart';
import 'package:flutter_mcq_checker/src/resources/database_provider.dart';
import 'package:rxdart/rxdart.dart';

class StudentBloc {
  //
  //
  // Database provider instance
  final _dbProvider = DatabaseProvider();

  // =================STREAM CONTROLLER / SUBJECT START=============
  // Stream controller / subject for list of student
  final PublishSubject<List<Student>> _students = PublishSubject();
  // =================STREAM CONTROLLER / SUBJECT END=============

  // =================GETTERS TO STREAM START=============
  Observable<List<Student>> get students => _students.stream;
  // =================GETTERS TO STREAM END=============

  // This list will be used to display data in Result Page
  List<Student> studentList;

  // Fetch all student from local database
  Future fetchAllStudent() async {
    // Fetch all modules from the database and store into the instance variable moduleList.
    studentList = await _dbProvider.fetchAllStudent();
    // Add module list to the sink.
    _students.sink.add(studentList);
  }

  // Add student to local database and studentList
  Future<int> addStudent(Student student) async {
    // Check either studentList is null or not
    // If student list is null then instantiated with empty list.
    if (studentList == null) {
      studentList = [];
    }

    // Update studentList with new element.
    studentList.add(student);

    // Add updated studentList to the sink
    _students.sink.add(studentList);

    // Add student to database
    int index = await _dbProvider.addStudent(student);
    return index;
  }

  // Add student button submit action
  submit() async {
    // final String studentName = _moduleName.value;
    // final List<Map<int, String>> answers = _answers.value;

    // Student student = Student(studentName, answers);

    // await addStudent(student);
  }

  // Clear db
  clearStudent() {
    return _dbProvider.clearStudent();
  }

  dispose() {
    _students.close();
  }
}
