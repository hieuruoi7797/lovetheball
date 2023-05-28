import 'package:flutter/material.dart';
import 'package:flutter_app/fetures/adding_courts/adding_court_notifier.dart';
import 'package:flutter_app/widgets/textfield_normal.dart';
import 'package:provider/provider.dart';

class AddingCourtScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddingCourtState();
}

class _AddingCourtState extends State<AddingCourtScreen> {
  late AddingCourtNotifier presenter;

  @override
  Widget build(BuildContext context) {
    presenter = Provider.of<AddingCourtNotifier>(context);
    return Scaffold(
        appBar: AppBar(title: const Text("Adding Basketball Court")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            presenter.addingCourt(context);
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
              textController: presenter.nameController,
            ),
            TextFieldNormal(
              title: "Location*",
              textController: presenter.locationController,
            ),
            TextFieldNormal(
              title: "Type",
              textController: presenter.typeController,
            ),
            const Center(child: Text("PRICE:")),
            TextFieldNormal(
              title: "Hour",
              textController: presenter.hourController,
            ),
            TextFieldNormal(
              title: "Day",
              textController: presenter.dayController,
            ),
            TextFieldNormal(
              title: "Week",
              textController: presenter.weekController,
            ),
            TextFieldNormal(
                title: "Month", textController: presenter.monthController),
            const Center(child: Text("ATTRIBUTE:")),
            TextFieldNormal(
                title: "Length", textController: presenter.lengthController),
            TextFieldNormal(
                title: "Width", textController: presenter.widthController),
            TextFieldNormal(
                title: "Hoop Height",
                textController: presenter.hoopHeightController),
            TextFieldNormal(
                title: "Backboard Size",
                textController: presenter.backBoardSizeController),
          ]),
        ));
  }
}
