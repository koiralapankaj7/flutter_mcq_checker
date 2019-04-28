import 'package:flutter_mcq_checker/src/models/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/module.dart';
import 'dart:io';

class DatabaseProvider {
  // Singleton DatabaseProvider
  // This will be initialize only once during whole life cycle
  // Single instance of the DatabaseProvider
  static DatabaseProvider _databaseProvider;
  static Database _database;

  final String _dbName = 'database_mcq.db';
  final int _dbVersion = 1;
  final String _studentsTable = 'students';
  final String _modulesTable = 'modules';

  // Named constructor to reate an instance of DatabaseProvider
  DatabaseProvider._createInstance();

  // Factory constructor will help us to return some value from the constructor
  factory DatabaseProvider() {
    if (_databaseProvider == null) {
      // Calling named constructor
      // If databaseProvider is null only then initialised
      // This will executed only once / singleton object
      _databaseProvider = DatabaseProvider._createInstance();
    }

    return _databaseProvider;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    // Open/create the database at a given path
    Database mcqDatabase = await openDatabase(path,
        version: _dbVersion, onCreate: _createDatabase);

    return mcqDatabase;
  }

  void _createDatabase(Database db, int version) async {
    await db.execute(createModuleTable());
    await db.execute(createStudentsTable());
  }

  // Query to create table for modules
  String createModuleTable() {
    return """ 
          CREATE TABLE $_modulesTable
          (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            module TEXT,
            year INTEGER,
            sem INTEGER,
            sGroup TEXT,
            marker TEXT,
            kids BLOB,
            answer BLOB
          )
          """;
  }

  // Query to create table for students
  String createStudentsTable() {
    return """
          CREATE TABLE $_studentsTable
          (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            answers BLOB
          )
          """;
  }

  // Fetch All Modules
  Future<List<Module>> fetchAllModule() async {
    print("Fetch all module called from db provider");

    Database db = await this.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _modulesTable,
      columns: null,
    );

    if (maps.length > 0) {
      List<Module> moduleList = [];
      maps.forEach((Map<String, dynamic> row) {
        moduleList.add(Module.fromDb(row));
      });

      return moduleList;
    }

    // Return empty list insted of null.
    // This method will called while running application at the beginning
    // If we return null then we cannot use ModuleList to update its value because
    // ModuleList will be set as null
    // In ModuleBloc while adding module ModuleList shouldnt be null
    return null;
  }

  // Add module
  Future<int> addModule(Module module) async {
    Database db = await this.database;
    int result = await db.insert(_modulesTable, module.toMap());
    return result;
  }

  // Delete module
  Future<int> deleteModule(int id) async {
    Database db = await this.database;
    return db.delete(
      _modulesTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Update Module
  Future<int> updateModule(Module module) async {
    Database db = await this.database;
    return await db.update(
      _modulesTable,
      module.toMap(),
      where: "id = ?",
      whereArgs: [module.id],
    );
  }

  // Clear Module Table
  Future<int> clearModule() async {
    Database db = await this.database;
    return db.delete(_modulesTable);
  }

  // Fetch all Students
  Future<List<Student>> fetchAllStudent() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _studentsTable,
      columns: null,
    );

    if (maps.length > 0) {
      List<Student> studentList = [];
      maps.forEach((Map<String, dynamic> row) {
        studentList.add(Student.fromDb(row));
      });

      return studentList;
    }

    return null;
  }

  // Add student
  Future<int> addStudent(Student student) async {
    Database db = await this.database;
    int result = await db.insert(_studentsTable, student.toMap());
    return result;
  }

  // Delete student
  Future<int> deleteStudent(int id) async {
    Database db = await this.database;
    return db.delete(
      _studentsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update Student
  Future<int> updateStudent(Student student) async {
    Database db = await this.database;
    return await db.update(
      _studentsTable,
      student.toMap(),
      where: "id = ?",
      whereArgs: [student.id],
    );
  }

  // Clear Student Table
  Future<int> clearStudent() async {
    Database db = await this.database;
    return db.delete(_studentsTable);
  }
}
