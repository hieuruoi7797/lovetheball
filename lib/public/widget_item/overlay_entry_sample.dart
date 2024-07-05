import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OverlayEntryBuilder extends StatelessWidget {
  Offset offset;
  Size size;
  List<String> showingList;
  Function(int)? onPickAnItem;

  OverlayEntryBuilder({
    super.key,
    required this.offset,
    required this.size,
    required this.showingList,
    this.onPickAnItem});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5.0,
        width: size.width,
        child: Container(
          width: 100,
          // height: 100,
          color: Colors.white,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: showingList.length,
              itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onPickAnItem!(index),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xFF677986)))
                ),
                child: Center(
                    child: Text(
                  showingList[index],
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17 ,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400
                  )),

              )),
            );
          }),
        )
    );
  }

}