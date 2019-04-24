import 'dart:async';

class ValidationMixin {
  final StreamTransformer validateModule =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String module, EventSink<String> sink) {
    if (module.length > 4) {
      sink.add(module);
    } else {
      sink.addError("Please enter valid module name");
    }
  });
}
