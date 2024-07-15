import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/src/blocs/match/match_setting_bloc.dart';

class MatchTypeCard extends StatelessWidget {
  bool isPicking;
  MatchTypeCard({super.key, required this.isPicking});
  @override
  Widget build(BuildContext context) {
   return Container(
     padding: EdgeInsets.all(16),
     decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(10)
     ),
     width: MediaQuery.sizeOf(context).width,
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         ///Title
         Row(
           children: [
             Text("3v3 Tieu Chuan",
               style: TextStyle(
                   fontSize: 17,
                   fontWeight: FontWeight.w700
               ),),
             Spacer(),
             GestureDetector(
               onTap: () => matchSettingBloc.pickAMatchTitle(title: STANDARD_3v3),
               child: Container(
                 width: 20,
                 height: 20,
                 decoration: BoxDecoration(
                     color: isPicking ? Colors.orange : Colors.white,
                     borderRadius: BorderRadius.circular(100),
                      border: Border.all(color:isPicking ?Colors.white: Colors.grey)
                 ),
                 child:  Icon(Icons.check,color: Colors.white,size: 14,),
               ),
             ),
           ],
         ),
         SizedBox(height: 8,),

         ///DIEM CHAM
         Row(
           children: [
             SizedBox(width: 16,),
             Container(width: 5,height: 5, decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(100),
                 color: Colors.black
             ),),
             SizedBox(width: 8,),
             RichText(text: TextSpan(
                 text: "Diem cham: ",
                 children: [
                   TextSpan(text: "21", style: TextStyle(color: Colors.black))
                 ],
                 style: TextStyle(color: Colors.black))),
           ],
         ),
         ///THOI GIAN
         Row(
           children: [
             SizedBox(width: 16,),
             Container(width: 5,height: 5, decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(100),
                 color: Colors.black
             ),),
             SizedBox(width: 8,),
             RichText(text: TextSpan(
                 text: "Thoi gian: ",
                 children: [
                   TextSpan(text: "10'", style: TextStyle(color: Colors.black))
                 ],
                 style: TextStyle(color: Colors.black))),
           ],
         ),
         ///HIEP PHU
         Row(
           children: [
             SizedBox(width: 16,),
             Container(width: 5,height: 5, decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(100),
                 color: Colors.black
             ),),
             SizedBox(width: 8,),
             RichText(text: TextSpan(
                 text: "Hiep phu: ",
                 children: [
                   TextSpan(text: "5'", style: TextStyle(color: Colors.black))
                 ],
                 style: TextStyle(color: Colors.black))),
           ],
         ),
         ///GIOI HAN LOI CA NHAN
         Row(
           children: [
             SizedBox(width: 16,),
             Container(width: 5,height: 5, decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(100),
                 color: Colors.black
             ),),
             SizedBox(width: 8,),
             RichText(text: TextSpan(
                 text: "Gioi han loi ca nhan: ",
                 children: [
                   TextSpan(text: "5", style: TextStyle(color: Colors.black))
                 ],
                 style: TextStyle(color: Colors.black))),
           ],
         ),
         ///NEM PHAT
         Row(
           children: [
             SizedBox(width: 16,),
             Container(width: 5,height: 5, decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(100),
                 color: Colors.black
             ),),
             SizedBox(width: 8,),
             RichText(text: TextSpan(
                 text: "Nem phat: ",
                 children: [
                   TextSpan(text: "Co", style: TextStyle(color: Colors.black))
                 ],
                 style: TextStyle(color: Colors.black))),
           ],
         ),
       ],
     ),
     // height: MediaQuery.sizeOf(context).height,
   );
  }

}