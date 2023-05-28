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
    TextEditingController hoopHeightController = TextEditingController();
    TextEditingController backBoardSizeController = TextEditingController();
    AddingCourtService service = AddingCourtService();
    AddingCourtNotifier(BuildContext context);
    Future<void> addingCourt(BuildContext context) async {
        await service.addCourt(context, {
            "name": nameController.text,
            "location": locationController.text,
            "type_": 0,
            "price": {
                "hour": hourController.text,
                "day": dayController.text,
                "week": weekController.text,
                "month": monthController.text,
                "year": yearController.text
            },
            "attributes": {
                "length": lengthController.text,
                "width": widthController.text,
                "hoop_height": hoopHeightController.text,
                "backboard_size": backBoardSizeController.text
            }
        }).then((value) =>  Navigator.pushNamed(context, '/listing'));

    }
}