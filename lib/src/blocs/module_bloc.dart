import 'package:flutter_mcq_checker/src/blocs/validation_mixin.dart';
import 'package:flutter_mcq_checker/src/resources/database_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../models/module.dart';

class ModuleBloc with ValidationMixin {
  //
  //
  // Database provider instance
  final _dbProvider = DatabaseProvider();

  // =================STREAM CONTROLLER / SUBJECT START=============
  // Stream controller / subject for list of module class
  final PublishSubject<List<Module>> _modules = PublishSubject();
  // Stream controller / subject for module name from text field
  final BehaviorSubject<String> _moduleName = BehaviorSubject();
  // Stream controller / subject for year from text field
  final BehaviorSubject<String> _year = BehaviorSubject();
  // Stream controller / subject for sem from text field
  final BehaviorSubject<String> _sem = BehaviorSubject();
  // Stream controller / subject for group from text field
  final BehaviorSubject<String> _group = BehaviorSubject();
  // Stream controller / subject for marker name from text field
  final BehaviorSubject<String> _marker = BehaviorSubject();
  // Stream controller / subject for  scanning correct answers / Button
  final BehaviorSubject<List<Map<int, String>>> _answers = BehaviorSubject();
  // =================STREAM CONTROLLER / SUBJECT END=============

  // =================GETTERS TO STREAM START=============
  Observable<List<Module>> get modules => _modules.stream;
  // Get module name from text field
  Observable<String> get module => _moduleName.stream.transform(validateModule);
  // Get year from text field
  Observable<String> get year => _year.stream.transform(validateYear);
  // Get sem from text field
  Observable<String> get sem => _sem.stream.transform(validateSem);
  // Get group from text field
  Observable<String> get group => _group.stream.transform(validateGroup);
  // Get marker name from text field
  Observable<String> get marker => _marker.stream.transform(validateMarker);
  // Scan answer
  Observable<List<Map<int, String>>> get answers =>
      _answers.stream.transform(validateAnswer);
  // Validation for add module button
  Observable<bool> get addModuleValidation => Observable.combineLatest5(
        module,
        year,
        sem,
        group,
        marker,
        (String m, String y, String s, String g, String ma) => true,
      );
  // =================GETTERS TO STREAM END=============

  // =================ADD TO SINK START=============
  // Add module name to stream
  Function(String) get changeModule => _moduleName.sink.add;
  // Add year to stream
  Function(String) get changeYear => _year.sink.add;
  // Add sem to stream
  Function(String) get changeSem => _sem.sink.add;
  // Add group to stream
  Function(String) get changeGroup => _group.sink.add;
  // Add marker name to stream
  Function(String) get changeMarker => _marker.sink.add;
  // Add answer to stream
  Function(List<Map<int, String>>) get changeAnswer => _answers.sink.add;
  // =================ADD TO SINK END=============

  // This list will be used to display data in Module Page
  List<Module> moduleList;

  // Fetch all module from local database
  Future fetchAllModule() async {
    // Fetch all modules from the database and store into the instance variable moduleList.
    moduleList = await _dbProvider.fetchAllModule();
    // Add module list to the sink.
    _modules.sink.add(moduleList);
  }

  // Add module to local database and moduleList
  Future<int> addModule(Module module) async {
    // Check either moduleList is null or not
    // If module list is null then instantiated with empty list.
    if (moduleList == null) {
      moduleList = [];
    }

    // Update moduleList with new element.
    moduleList.add(module);

    // Add updated moduleList to the sink
    _modules.sink.add(moduleList);

    // Add module to database
    int index = await _dbProvider.addModule(module);
    return index;
  }

  // Add module button submit action
  submit() async {
    final String moduleName = _moduleName.value;
    final int year = int.parse(_year.value);
    final int sem = int.parse(_sem.value);
    final String group = _group.value;
    final String marker = _marker.value;
    final List<int> kids = [];
    final List<Map<int, String>> answers = _answers.value;

    Module module = Module(moduleName, year, sem, group, marker, kids, answers);

    await addModule(module);
  }

  // Clear db
  clearModule() {
    return _dbProvider.clearModule();
  }

  // Dispose all subject / Stream controller
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
