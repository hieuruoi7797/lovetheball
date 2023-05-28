import 'package:flutter/material.dart';

abstract class ListingCourtInterface {
  Future<void> getCourtList(BuildContext context, Map<String, dynamic> parameters);
}
