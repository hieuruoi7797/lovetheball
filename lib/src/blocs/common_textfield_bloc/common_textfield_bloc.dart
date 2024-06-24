import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/src/ui/authentication/validate.dart';

class CommonTextFieldBloc with Validation {

  CommonTextFieldBloc() {
    changeVisiblePassword(false);
  }
  ///Init
  bool _passwordLoginVisible = false;
  final _emailBehavior = BehaviorSubject<String>();
  final _passwordBehavior = BehaviorSubject<String>();
  final _msgCodeBehavior = BehaviorSubject<String>();
  final _optionalErrorBehavior = BehaviorSubject<String>();
  final _visiblePasswordBehavior = BehaviorSubject<bool>();
  final _sendOTPBehavior = BehaviorSubject<String>();

  ///Getter
  bool get passwordLoginVisible => _passwordLoginVisible;
  Stream<String> get emailValidateBehavior => _emailBehavior.stream.transform(eMailValidate);
  Stream<String> get passwordValidateBehavior => _passwordBehavior.stream.transform(passwordValidate);
  Stream<String> get optionalErrorStream => _optionalErrorBehavior.stream.transform(optionalError);
  Stream<String> get responseErrorStream => _msgCodeBehavior.stream.transform(responseValidate);
  Stream<bool> get visiblePassword => _visiblePasswordBehavior;
  Stream<String> get emailBehavior => _emailBehavior;
  Stream<String> get otpValidateBehavior => _sendOTPBehavior.stream.transform(otpValidate);

  ///Setter
  void enterPassword(String value) => enteringPassword(value);
  void addOptionalError(String value) => _optionalErrorBehavior.sink.add(value);
  void enterEmail(String value) => _emailBehavior.sink.add(value);
  void enterMsgCode(String value) => _msgCodeBehavior.sink.add(value);
  void enterResVerifyOtp(String value) => _sendOTPBehavior.sink.add(value);
  void changeVisiblePassword(bool value) => _visiblePasswordBehavior.sink.add(value);
  String get emailTxt => _emailBehavior.value;
  void clearEmail() => _emailBehavior.sink.add("");

  enteringPassword(String value) {
    _passwordBehavior.sink.add(value);
    _optionalErrorBehavior.sink.add("");
  }
}

CommonTextFieldBloc commonTextFieldBloc = CommonTextFieldBloc();