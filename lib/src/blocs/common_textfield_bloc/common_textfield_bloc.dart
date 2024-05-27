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
  final _incorrectEmailPassBehavior = BehaviorSubject<String>();
  final _visiblePasswordBehavior = BehaviorSubject<bool>();


  ///Getter
  bool get passwordLoginVisible => _passwordLoginVisible;
  Stream<String> get emailValidateBehavior => _emailBehavior.stream.transform(eMailValidate);
  Stream<String> get passwordValidateBehavior => _passwordBehavior.stream.transform(passwordValidate);
  Stream<String> get incorrectEmailPasswordStream => _incorrectEmailPassBehavior.stream.transform(incorrectEmailOrPassword);
  Stream<bool> get visiblePassword => _visiblePasswordBehavior;
  Stream<String> get emailBehavior => _emailBehavior;

  ///Setter
  void enterPassword(String value) => enteringPassword(value);
  void incorrectEmailPass(String value) => _incorrectEmailPassBehavior.sink.add(value);
  void enterEmail(String value) => _emailBehavior.sink.add(value);
  void changeVisiblePassword(bool value) => _visiblePasswordBehavior.sink.add(value);
  String get emailTxt => _emailBehavior.value;
  void clearEmail() => _emailBehavior.sink.add("");

  enteringPassword(String value) {
    _passwordBehavior.sink.add(value);
    _incorrectEmailPassBehavior.sink.add("");
  }
}

CommonTextFieldBloc commonTextFieldBloc = CommonTextFieldBloc();