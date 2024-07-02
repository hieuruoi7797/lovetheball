import 'package:flutter/material.dart';

class MatchSettingBloc {
  OverlayEntry? overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool matchTypeVisible = false;


  void createOverlayEntry(BuildContext context,GlobalKey entryKey) {
    RenderBox renderBox = entryKey.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    if (matchTypeVisible == false){
      overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 5.0,
              width: size.width,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              )
          )
      );
      Overlay.of(context).insert(overlayEntry!);
      matchTypeVisible = true;
    }else{
      matchTypeVisible = false;
      overlayEntry?.remove();
    }
  }
}

MatchSettingBloc matchSettingBloc = MatchSettingBloc();