import 'package:flutter/cupertino.dart';

class WinRate extends StatelessWidget{
  WinRate({super.key, this.percent, this.color});
  double? percent;
  Color? color;
  @override
  Widget build(BuildContext context) {
   return Container(
     height: (percent??100)/100 * 71,
     width: 16,
     margin: const EdgeInsets.only(left: 20),
     decoration: BoxDecoration(
         color: color ?? Color(0xFFB3BBC4),
         borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100))
     ),
   );
  }

}