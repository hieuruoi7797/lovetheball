import 'package:flutter/material.dart';
import 'package:flutter_app/fetures/listing_courts/listing_court_notifier.dart';
import 'package:provider/provider.dart';

import '../../widgets/bb_court_info_card.dart';

class ListingCourtScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListingCourtState();
}

class _ListingCourtState extends State<ListingCourtScreen> {
  late ListingCourtNotifier presenter;

  @override
  Widget build(BuildContext context) {
    presenter = Provider.of<ListingCourtNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_rounded),
          onTap: () => Navigator.pop(context),
        ),
        title: Text("Basketball courts"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: ListView.builder(
            itemCount: presenter.courtsList.length,
            itemBuilder: (BuildContext context, int index) {
              return BBCourtInfoCard(
                basketballCourt: presenter.courtsList[index],
              );
            }),
      ),
    );
  }
}
