import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_mobile/public/widget_item/detail_match_setting_item.dart';
import 'package:splat_mobile/src/blocs/match/match_setting_bloc.dart';

class MatchCustomSetting extends StatefulWidget {

  MatchCustomSetting({super.key});




  @override
  State<StatefulWidget> createState() => _MatchCustomSettingState();

}

class _MatchCustomSettingState extends State<MatchCustomSetting> {
  final _matchTypeSelectorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Color(0xFFFBE8DE).withOpacity(0.6),
          borderRadius: BorderRadius.circular(10)
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Title
          Row(
            children: [
              const Text("Tran dau tuy chinh",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700
                ),),
              Spacer(),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Icon(Icons.check,color: Colors.white,size: 14,),
              ),
            ],
          ),
          // const SizedBox(height: 8,),
          const SizedBox(height: 16,),

          ///THE THUC
         DetailMatchSettingItem(
           title: "The thuc",
           widget: GestureDetector(
             onTap: () {
               matchSettingBloc.showOverlayEntry(context,_matchTypeSelectorKey);
               ///Show OVERLAY
             },
             child: SizedBox(
               width: 176,
               height: 42,
               child: Container(
                   key: _matchTypeSelectorKey,

                   padding: EdgeInsets.all(8),
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10)
                   ),
                   child: Row(
                     children: [
                       Container(
                         margin:EdgeInsets.only(left: 65),
                         child: Text('3v3',style: TextStyle(
                             fontSize: 17
                         ),),
                       ),
                       Spacer(),
                       Icon(Icons.keyboard_arrow_down_rounded,)
                     ],
                   )),
             ),
           ),
         ),
         const SizedBox(height: 16,),

         ///So hiep
         DetailMatchSettingItem(
           title: "So hiep",
           widget: Row(
             children: [
               GestureDetector(
                 onTap: () {
                   // matchSettingBloc.showOverlayEntry(context,_matchTypeSelectorKey);
                   ///Show OVERLAY
                 },
                 child: SizedBox(
                   width: 58,
                   height: 42,
                   child: Container(
                       // key: _matchTypeSelectorKey,

                       // padding: EdgeInsets.all(8),
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                       ),
                        child: Center(child: Text("1",style: TextStyle(fontSize: 17),)),
                       ),
                 ),
               ),
               GestureDetector(
                 onTap: () {
                   // matchSettingBloc.showOverlayEntry(context,_matchTypeSelectorKey);
                   ///Show OVERLAY
                 },
                 child: SizedBox(
                   width: 58,
                   height: 42,
                   child: Container(
                     // key: _matchTypeSelectorKey,

                     // padding: EdgeInsets.all(8),
                     decoration: BoxDecoration(
                         color: Color(0xFFEAF1FA),
                       border: Border.symmetric(
                           vertical: BorderSide(
                               color: Color(0xFF677986).withOpacity(0.4),
                               width: 0.5
                           ))
                     ),
                     child: Center(child: Text("2",style: TextStyle(fontSize: 17),)),
                   ),
                 ),
               ),
               GestureDetector(
                 onTap: () {
                   // matchSettingBloc.showOverlayEntry(context,_matchTypeSelectorKey);
                   ///Show OVERLAY
                 },
                 child: SizedBox(
                   width: 58,
                   height: 42,
                   child: Container(
                     // key: _matchTypeSelectorKey,

                     // padding: EdgeInsets.all(8),
                     decoration: BoxDecoration(
                         color: Color(0xFFEAF1FA),
                         borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                     ),
                     child: Center(child: Text("4",style: TextStyle(fontSize: 17),)),
                   ),
                 ),
               ),
             ],
           ),
         ),
          const SizedBox(height: 16,),

          ///Tgian moi hiep
          DetailMatchSettingItem(
            title: "T.gian mỗi hiệp",
            widget: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // matchSettingBloc.showOverlayEntry(context,_matchTypeSelectorKey);
                    ///Show OVERLAY
                  },
                  child: SizedBox(
                    width: 42,
                    height: 42,
                    child: Container(
                      // key: _matchTypeSelectorKey,

                      // padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(child: Icon(Icons.remove)),
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                GestureDetector(
                  onTap: () {
                  },
                  child: SizedBox(
                    width: 74,
                    height: 42,
                    child: Container(
                      // key: _matchTypeSelectorKey,

                      // padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(child: Text("2",style: TextStyle(fontSize: 17),)),
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                GestureDetector(
                  onTap: () {
                  },
                  child: SizedBox(
                    width: 42,
                    height: 42,
                    child: Container(
                      // key: _matchTypeSelectorKey,

                      // padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(child: Icon(Icons.add)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),

        ],
      ),
      // height: MediaQuery.sizeOf(context).height,
    );
  }

}

