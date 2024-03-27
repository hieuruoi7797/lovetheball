import 'dart:async';

mixin Validation{
  final eMailValidate =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {

    if (value != "" &&!value.contains('@')) {
      sink.addError('The e-mail is invalid!');
    }
    else {
      sink.add(value);
    }
  });

  final passwordValidate =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.length == 0) {
      sink.addError('Enter the password');
    } else if (value.length < 6) {
      sink.addError('The password must have at least 6 characters');
    } else {
      sink.add(value);
    }
  });
}