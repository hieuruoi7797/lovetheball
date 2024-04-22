import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';

Widget CommonTextField(BuildContext context,
    {
      String? labelText,
      bool? enableEmailValidator,
    }){
  final _controllerEmail = TextEditingController();


  return StreamBuilder<Object>(
    stream: enableEmailValidator == true ?
              authenticationBloc.emailValidateBehavior:
                null,
    builder: (context, snapshot) {
      return TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              width: 2,
              style: BorderStyle.none,
              color: color_main,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
                width: 1, style: BorderStyle.none, color: color_main),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              width: 1,
              style: BorderStyle.none,
              color: color_main,
            ),
          ),
          hintText: labelText ?? "Email",
          suffixIcon: _controllerEmail.text != ""
              ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _controllerEmail.clear();
              })
              : null,
          alignLabelWithHint: false,
          filled: true,
          errorText:snapshot.error?.toString(),
        ),
        onChanged: (value) {
          authenticationBloc.setEmail(value);
        },
        controller: _controllerEmail,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      );
    }
  );
}