// import 'dart:io';
// import 'package:mcq_checker/src/models/module.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';

// class DbProvider {
//   Database db;
//   final String _dbName = 'mcq_database.db';
//   final int _dbVersion = 1;
//   final String _studentsTable = 'students';
//   final String _modulesTable = 'modules';

//   /*
//    * Inside our constructor we cannot have asynchronous logic.
//    * That is why we are making init() function to do initial setup.
//    */
//   DbProvider() {
//     init();
//   }

//   // Setup database
//   init() async {
//     /*
//      * getApplicationDocumentsDirectory() => Path Provider Lib
//      * Directory => IO lib
//      * join => Path lib
//      * openDatabase function will either open database at given path or if there is no database at
//      * given path then its going to create new one for us. If database exist open it otherwise create it.
//      * onCreate will only called very first time user start the application
//      */
//     // Getting documents directory from mobile device
//     Directory docDirectory = await getApplicationDocumentsDirectory();

//     // Location of database
//     final String path = join(docDirectory.path, _dbName);

//     db = await openDatabase(
//       path,
//       version: _dbVersion,
//       onCreate: (Database newDb, int version) async {
//         await newDb.execute(createModuleTable());
//         await newDb.execute(createStudentsTable());
//       },
//     );
//   }

//   Future<Database> get database async {
//     if (db != null) {
//       return db;
//     }
//     db = await init();
//     return db;
//   }

//   // Query to create table for modules
//   String createModuleTable() {
//     return """
//           CREATE TABLE $_modulesTable
//           (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             module TEXT,
//             year INTEGER,
//             sem INTEGER,
//             sGroup TEXT,
//             marker TEXT,
//             kids BLOB,
//             answer BLOB
//           )
//           """;
//   }

//   // Query to create table for students
//   String createStudentsTable() {
//     return """
//           CREATE TABLE $_studentsTable
//           (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             name TEXT,
//             score INTEGER
//           )
//           """;
//   }

//   // Fetch All Module
//   Future<List<Module>> fetchAllModule() async {
//     final List<Map<String, dynamic>> maps = await db.query(
//       _modulesTable,
//       columns: null,
//     );

//     if (maps.length > 0) {
//       List<Module> moduleList = [];
//       maps.forEach((Map<String, dynamic> row) {
//         moduleList.add(Module.fromDb(row));
//       });
//       print(moduleList.length);
//       return moduleList;
//     }
//     return null;
//   }

//   // Add module
//   Future<int> addModule(Module module) async {
//     int result = await db.insert(_modulesTable, module.toMap());
//     print('Successfully inserted $result');
//     return result;
//   }

//   // Delete module
//   Future<int> deleteModule(int id) {
//     return db.delete(
//       _modulesTable,
//       where: "id = ?",
//       whereArgs: [id],
//     );
//   }

//   // Update Module
//   Future<int> updateModule(Module module) async {
//     return await db.update(
//       _modulesTable,
//       module.toMap(),
//       where: "id = ?",
//       whereArgs: [module.id],
//     );
//   }

//   // Clear Module Table
//   Future<int> clear() {
//     return db.delete(_modulesTable);
//   }

// }

// final DbProvider dbProvider = DbProvider();
