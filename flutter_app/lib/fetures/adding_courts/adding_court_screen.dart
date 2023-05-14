import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/textfield_normal.dart';
import 'package:go_router/go_router.dart';

class AddingCourtScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddingCourtState();
}

class _AddingCourtState extends State<AddingCourtScreen> {
  @override
  Widget build(BuildContext) {
    return Scaffold(
        appBar: AppBar(title: const Text("Adding Basketball Court")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go("/listing_court_screen");
            // Add your onPressed code here!
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.navigation),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: ListView(children: [
            TextFieldNormal(
              title: "Name*",
            ),
            TextFieldNormal(
              title: "Loaction*",
            ),
            TextFieldNormal(
              title: "Type",
            ),
            const Center(child: Text("PRICE:")),
            TextFieldNormal(title: "Hour"),
            TextFieldNormal(title: "Day"),
            TextFieldNormal(title: "Week"),
            TextFieldNormal(title: "Month"),
            const Center(child: Text("ATTRIBUTE:")),
            TextFieldNormal(title: "Length"),
            TextFieldNormal(title: "Width"),
            TextFieldNormal(title: "Hoop Height"),
            TextFieldNormal(title: "Backboard Size"),
          ]),
        ));
  }
}
