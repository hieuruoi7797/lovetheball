import 'dart:async';

mixin Validation{
  final eMailValidate =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {

    if (value.isNotEmpty && !value.contains('@')) {
      sink.addError('The e-mail is invalid!');
    }
    else {
      sink.add(value);
    }
  });

  final optionalError=
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {

    if (value.isNotEmpty) {
      sink.addError(value);
    }
    else {
      sink.add(value);
    }
  });

  final passwordValidate =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isEmpty) {
      sink.addError('Enter the password');
    } else if (value.length < 6) {
      sink.addError('The password must have at least 6 characters');
    } else {
      sink.add(value);
    }
  });
}