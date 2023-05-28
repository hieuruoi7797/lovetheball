import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/bb_court_model.dart';

import 'listing_court_service.dart';

class ListingCourtNotifier extends ChangeNotifier {
  List<BbCourtModel> courtsList = [];
  ListingCourtService service = ListingCourtService();

  ListingCourtNotifier(BuildContext context) {
    getCourtList(context);
  }

  Future<void> getCourtList(BuildContext context) async {
    String response = await service.getCourtList(context, {
      "offset": 0,
      "limit": 100,
      "soft_field": "update_at",
      "soft_order": "DESC"
    });

    Map responseJson = jsonDecode(response);
    List courtsListJson = responseJson['data'].toList();
    courtsListJson.forEach((element) {
      courtsList.add(BbCourtModel.fromJson(element));
    });
    print("Legth ${courtsList.length}");
    notifyListeners();
  }
}
