import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/bb_court_model.dart';

class BBCourtInfoCard extends StatelessWidget {
  BbCourtModel basketballCourt;

  BBCourtInfoCard({required this.basketballCourt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.lightBlueAccent,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Text("Name: ${basketballCourt.name}"),
          Text("Location:  ${basketballCourt.location}"),
          Text("Type: ${basketballCourt.type}"),
          Text("Price: ${basketballCourt.price}"),
          Text("Attribute: ${basketballCourt.attributes}"),
        ],
      ),
    );
  }
}
