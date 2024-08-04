import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_mobile/src/blocs/match/match_setting_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:splat_mobile/src/models/basketball_match_setting_model.dart';


class MatchTypeCard extends StatelessWidget {
  bool isPicking;
  String typeName;
  BasketballMatchSettingModel settingInfo;
  MatchTypeCard({
    super.key,
    required this.isPicking,
    required this.typeName,
    required this.settingInfo
  });
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
   return GestureDetector(
     onTap: () => matchSettingBloc.pickAMatchTitle(context,title: typeName),
     child: Container(
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
               Text(typeName,
                 style: TextStyle(
                     fontSize: 17,
                     fontWeight: FontWeight.w700
                 ),),
               Spacer(),
               Container(
                 width: 20,
                 height: 20,
                 decoration: BoxDecoration(
                     color: isPicking ? Colors.orange : Colors.white,
                     borderRadius: BorderRadius.circular(100),
                      border: Border.all(color:isPicking ?Colors.white: Colors.grey)
                 ),
                 child:  Icon(Icons.check,color: Colors.white,size: 14,),
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
                     TextSpan(
                         text: (settingInfo.cutOffPoints ?? 00).toString(),
                         style: const TextStyle(color: Colors.black))
                   ],
                   style: TextStyle(color: Colors.black))),
             ],
           ),
           ///THOI GIAN
           Row(
             children: [
               const SizedBox(width: 16,),
               Container(width: 5,height: 5, decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(100),
                   color: Colors.black
               ),),
               const SizedBox(width: 8,),
               RichText(text: TextSpan(
                   text: "Thoi gian moi hiep: ",
                   children: [
                     TextSpan(
                         text: (settingInfo.timeOfEachRound??00).toString(),
                         style: const TextStyle(color: Colors.black))
                   ],
                   style: const TextStyle(color: Colors.black))),
             ],
           ),
           ///HIEP PHU
           Row(
             children: [
               const SizedBox(width: 16,),
               Container(width: 5,height: 5, decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(100),
                   color: Colors.black
               ),),
               SizedBox(width: 8,),
               RichText(text: TextSpan(
                   text: "Hiep phu: ",
                   children: [
                     TextSpan(text: (settingInfo.timeOfSubRound??0).toString(), style: TextStyle(color: Colors.black))
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
                     TextSpan(text: "${settingInfo.personalFoulsLimit??0}", style: TextStyle(color: Colors.black))
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
                     TextSpan(
                         text: (settingInfo.enableFreeThrow??false) ? "Co" : "Khong",
                         style: const TextStyle(color: Colors.black))
                   ],
                   style: TextStyle(color: Colors.black))),
             ],
           ),
         ],
       ),
       // height: MediaQuery.sizeOf(context).height,
     ),
   );
  }

}