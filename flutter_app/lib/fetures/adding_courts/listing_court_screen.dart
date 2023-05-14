import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListingCourtScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _ListingCourtState();
}

class _ListingCourtState extends State<ListingCourtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(child: const Icon(Icons.arrow_back_ios_rounded),onTap: ()=>Navigator.pop(context),),
        title: Text("Basketball courts"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: ListView(
          children: [
            Container(
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
            )
          ],
        ),
      ),
    );
  }
}