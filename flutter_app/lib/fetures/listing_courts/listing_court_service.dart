import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/fetures/listing_courts/listing_court_interface.dart';

import '../../base/api_dio.dart';

class ListingCourtService implements ListingCourtInterface {
  @override
  Future<String> getCourtList(
      BuildContext context, Map<String, dynamic> parameters) async {
    final response = await ApiDio.getInstance(context)!.createGet("/courts",
        context: context, queryParameters: parameters, showLoading: false);
    return response.toString();
  }
}
