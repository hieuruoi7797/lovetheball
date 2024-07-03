import 'package:flutter/cupertino.dart';

class DetailMatchSettingItem extends StatelessWidget {
  String? title;
  Widget? widget;
  DetailMatchSettingItem({
    super.key,
    this.title,
    this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title ?? "The thuc"),
        const Spacer(),
        widget ?? const SizedBox()
      ],
    );
  }

}