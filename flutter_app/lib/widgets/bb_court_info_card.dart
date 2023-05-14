import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BBCourtInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      color: Colors.lightBlueAccent,
      child: ListView(
        shrinkWrap: true,
        children: [
          Text("Name:"),
          Text("Location:"),
          Text("Type:"),
          Text("Price:"),
          Text("Attribute:"),
        ],
      ),
    );
  }

}