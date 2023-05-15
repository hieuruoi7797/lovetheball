import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextFieldNormal extends StatelessWidget {
  String? title;
  TextEditingController? textController;

TextFieldNormal({this.title, this.textController});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(bottom: 16,left: 16,right: 16),
            child: TextField(
              controller: textController ?? TextEditingController(),
              decoration: InputDecoration(
                labelText: title ?? "NoName"
              ),
            ),
          );
  }
  
}