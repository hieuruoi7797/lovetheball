import 'package:flutter/cupertino.dart';

class TagInfo extends StatelessWidget {
  String? value;
  String? label;
  TagInfo({super.key, this.value, this.label});
  @override
  Widget build(BuildContext context) {
   return Container(
     margin: EdgeInsets.only(right: 8),
     padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
     decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
         color: Color(0xFFECF3FB)
     ),
     child: Row(
         mainAxisSize: MainAxisSize.min,
         children: [
           Text(value??"12",
             style: const TextStyle(
                 fontWeight: FontWeight.w700,
                 color: Color(0xFF313A3E)),),
           Text(label??" Danh hiệu",
              style: const TextStyle(
                color: Color(0xFF62737A)
              ),)
         ]
     ),
   );
  }

}