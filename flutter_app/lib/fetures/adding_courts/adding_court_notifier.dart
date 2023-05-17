import 'package:flutter/cupertino.dart';

import 'adding_court_service.dart';

class AddingCourtNotifier extends ChangeNotifier {
    AddingCourtService service = AddingCourtService();
    AddingCourtNotifier(BuildContext context) {
        service.addCourt(context, {
            "name": "string",
            "location": "string",
            "type_": 0,
            "price": {
                "hour": "string",
                "day": "string",
                "week": "string",
                "month": "string",
                "year": "string"
            },
            "attributes": {
                "length": "string",
                "width": "string",
                "hoop_height": "string",
                "backboard_size": "string"
            }
        });
    }
}