import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextFieldNormal extends StatelessWidget {
  String? title;

TextFieldNormal({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(bottom: 16,left: 16,right: 16),
            child: TextField(
              decoration: InputDecoration(
                labelText: title ?? "NoName"
              ),
            ),
          );
  }
  
}