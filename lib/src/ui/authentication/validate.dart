import 'dart:async';

mixin Validation{
  final eMailValidate =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    if (value.isNotEmpty && regExp.hasMatch(value)==false) {
      sink.addError('Email không hợp lệ');
    }
    else {
      sink.add(value);
    }
  });

  final responseValidate = StreamTransformer<String, String>.fromHandlers(handleData: (value,sink){
    if(value=='E607'){
      sink.addError('Tài khoản email này đã tồn tại');
    }
    else{
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
  final otpValidate =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink,) {
    if (value=='E610') {
      sink.addError('Mã xác thực không chính xác');
    }else if(value=='E611'){
      sink.addError('Email verification fail');
    }
    else{
      sink.add(value);
    }
  });
}