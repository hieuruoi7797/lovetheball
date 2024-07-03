import 'package:flutter/material.dart';
import 'package:splat_mobile/public/widget_item/overlay_entry_sample.dart';

class MatchSettingBloc {
  OverlayEntry? overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool matchTypeVisible = false;


  void showOverlayEntry(BuildContext context,GlobalKey entryKey) {
    RenderBox renderBox = entryKey.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    if (matchTypeVisible == false){
      overlayEntry = OverlayEntry(
          builder: (context) => OverlayEntryBuilder(offset: offset, size: size)
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