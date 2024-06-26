import 'dart:async';

mixin Validation{
  final eMailValidate =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    if (value.isNotEmpty && !regExp.hasMatch(value)) {
      sink.addError('Email không hợp lệ');
    }
    else {
      sink.add(value);
    }
  });

  final responseValidate = StreamTransformer<String, String>.fromHandlers(handleData: (value,sink){
    if(value == 'E000'){
      sink.addError("Vui lòng nhập email");
    }
    else if(value == 'P000'){
      sink.addError("Vui lòng nhập mật khẩu");
    }
    else if(value=='E607'){
      sink.addError('Tài khoản email này đã tồn tại');
    }
    else if(value =='E611'){
      sink.addError('Xác thực email thất bại. Vui lòng thử lại!');
    }
    else if(value=='E616'){
      sink.addError('Thông tin đăng nhập không chính xác. Vui lòng thử lại');
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
    final digitsRegex = RegExp(r'[0-9]');
    if (value.length < 8 && !digitsRegex.hasMatch(value)){
      sink.addError('all');
    }
    else if (value.isNotEmpty && value.length < 8) {
      sink.addError('Mật khẩu phải có ít nhất 8 ký tự');
    }
    else if (value.isNotEmpty && !digitsRegex.hasMatch(value)){
      sink.addError('Mật khẩu phải có ít nhất 1 chữ số');
    }
    else {
      sink.add(value);
    }
  });
  final otpValidate =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink,) {
    if(value == 'M000'){
      sink.addError('Vui lòng nhập mã xác thực');
    }
    else if (value=='E610') {
      sink.addError('Mã xác thực không chính xác');
    }else if(value=='E611'){
      sink.addError('Xác thực email thất bại, vui lòng thử lại!');
    }
    else{
      sink.add(value);
    }
  });

  final nickNameValidate =
      StreamTransformer<String, String>.fromHandlers(handleData:  (value, sink){
        final patternRegex = RegExp(r"[a-zA-Z]+|\s");
        final specialCharactersRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
        if(patternRegex.hasMatch(value) && specialCharactersRegex.hasMatch(value)){
          sink.addError('Không có ký tự đặc biệt');
        }
        if(value.isNotEmpty && !patternRegex.hasMatch(value)){
          sink.addError('Bao gồm cả họ và tên');
        }
        else if (value.isNotEmpty && specialCharactersRegex.hasMatch(value)){
          sink.addError('Không có ký tự đặc biệt');
        }
        else if(!patternRegex.hasMatch(value)&& specialCharactersRegex.hasMatch(value)){
          sink.add('all');
        }
        else{
          sink.add(value);
        }
      });
}