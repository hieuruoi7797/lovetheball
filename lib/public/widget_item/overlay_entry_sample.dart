import 'package:flutter/material.dart';

class OverlayEntryBuilder extends StatelessWidget {
  Offset offset;
  Size size;

  OverlayEntryBuilder({super.key, required this.offset, required this.size});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5.0,
        width: size.width,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.blue,
        )
    );
  }

}