import 'dart:async';

class ValidationMixin {
  // Validation for module
  final StreamTransformer validateModule =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String module, EventSink<String> sink) {
      if (module.length > 4) {
        sink.add(module);
      } else {
        sink.addError("Please enter valid module name");
      }
    },
  );

  // Validation for year
  final StreamTransformer validateYear =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String year, EventSink<String> sink) {
      if ((year.length == 4) && (num.tryParse(year) != null)) {
        sink.add(year);
      } else {
        sink.addError('Please enter valid year.');
      }
    },
  );

  // Validation for sem
  StreamTransformer validateSem =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String sem, EventSink<String> sink) {
      if ((sem.length == 1) && (int.tryParse(sem) != null)) {
        sink.add(sem);
      } else {
        sink.addError('Semester value must be like 1, 2, 3 ...');
      }
    },
  );

  // Validation for group
  StreamTransformer validateGroup =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String sem, EventSink<String> sink) {
      if (sem.length > 0) {
        sink.add(sem);
      } else {
        sink.addError('Group should not be empty.');
      }
    },
  );

  // Validation for marker name
  StreamTransformer validateMarker =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String marker, EventSink<String> sink) {
      if (marker.length > 0) {
        sink.add(marker);
      } else {
        sink.addError('Marker name must not be empty.');
      }
    },
  );

  // Validation for answer
  StreamTransformer validateAnswer = StreamTransformer<List<Map<int, String>>,
      List<Map<int, String>>>.fromHandlers(
    handleData: (List<Map<int, String>> answer,
        EventSink<List<Map<int, String>>> sink) {
      if (answer.isNotEmpty) {
        sink.add(answer);
      } else {
        sink.addError(
            'Sorry ! could not scan the image. Try different image or enter answer manually');
      }
    },
  );
}
