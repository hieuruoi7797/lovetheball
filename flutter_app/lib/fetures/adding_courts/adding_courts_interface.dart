import 'package:flutter/cupertino.dart';

abstract class AddingCourtsInterface {
  Future<void> addCourt(BuildContext context, Map body);
}