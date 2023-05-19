import 'package:flutter/cupertino.dart';

import 'adding_court_service.dart';

class AddingCourtNotifier extends ChangeNotifier {
    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    TextEditingController hourController = TextEditingController();
    TextEditingController dayController = TextEditingController();
    TextEditingController weekController = TextEditingController();
    TextEditingController monthController = TextEditingController();
    TextEditingController yearController = TextEditingController();
    TextEditingController lengthController = TextEditingController();
    TextEditingController widthController = TextEditingController();
    TextEditingController hoopLengthController = TextEditingController();
    TextEditingController backBoardSizeController = TextEditingController();
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