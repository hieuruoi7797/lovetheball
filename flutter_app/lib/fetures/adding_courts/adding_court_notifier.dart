import 'package:flutter/cupertino.dart';

import 'adding_court_service.dart';

class AddingCourtNotifier extends ChangeNotifier {
    AddingCourtService service = AddingCourtService();
    AddingCourtNotifier(BuildContext context) {
        service.addCourt(context, {});
    }
}