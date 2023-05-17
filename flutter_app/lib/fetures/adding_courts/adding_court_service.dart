import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/base/api_dio.dart';
import 'package:flutter_app/fetures/adding_courts/adding_courts_interface.dart';

class AddingCourtService implements AddingCourtsInterface {
  @override
  Future<void> addCourt(
      BuildContext context, Map<dynamic, dynamic> body) async {
    final response = await ApiDio.getInstance(context)!
        .createPost("/courts", context: context, body: body);
    return response;
  }
}
