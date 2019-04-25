import 'package:flutter_mcq_checker/src/resources/database_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../models/module.dart';
import '../resources/db_provider.dart';

class ModuleBloc {
  final _dbProvider = DatabaseProvider();

  // Stream Controller / Subjects
  final PublishSubject<List<Module>> _modules = PublishSubject();
  final BehaviorSubject<String> _moduleName =
      BehaviorSubject(); // Textfield module
  final BehaviorSubject<int> _year = BehaviorSubject(); // Textfield year
  final BehaviorSubject<int> _sem = BehaviorSubject(); // Textfield sem
  final BehaviorSubject<String> _group = BehaviorSubject(); // Textfield group
  final BehaviorSubject<String> _marker = BehaviorSubject(); // Textfield marker
  // BUtton for scanning correct answers
  final BehaviorSubject<Map<int, String>> _answers = BehaviorSubject();

  // Getters to stream
  // Get all modules
  Observable<List<Module>> get modules => _modules.stream;
  Observable<String> get module => _moduleName.stream;
  Observable<int> get year => _year.stream;
  Observable<int> get sem => _sem.stream;
  Observable<String> get group => _group.stream;
  Observable<String> get marker => _marker.stream;
  Observable<Map<int, String>> get answers => _answers.stream;

  // Add to Stream Controller / Subjects
  Function(String) get changeModule => _moduleName.sink.add;
  Function(int) get changeYear => _year.sink.add;
  Function(int) get changeSem => _sem.sink.add;
  Function(String) get changeGroup => _group.sink.add;
  Function(String) get changeMarker => _marker.sink.add;

  List<Module> moduleList = List<Module>();

  Future fetchAllModule() async {
    // Fetch all modules from the database and store into the instance variable moduleList.
    moduleList = await _dbProvider.fetchAllModule();
    print('Length of module list is ${moduleList.length}');
    // Add module list to the sink.
    _modules.sink.add(moduleList);
  }

  Future<int> addModule(Module module) async {
    // Update moduleList with new element.
    moduleList.add(module);
    // Add updated moduleList to the sink
    _modules.sink.add(moduleList);
    print('Adding module to database.......');
    int index = await _dbProvider.addModule(module);
    print('Module has been successfully added to database $index');
    //fetchAllModule();
    return index;
  }

  // Clear db
  clear() {
    return _dbProvider.clear();
  }

  dispose() {
    _modules.close();
    _moduleName.close();
    _year.close();
    _sem.close();
    _group.close();
    _marker.close();
    _answers.close();
    //_module.close();
  }
}
