import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              const Text("Tran dau tuy chinh",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700
                ),),
              const SizedBox(height: 8,),

              ///THE THUC
              Row(
                children: [
                  const Text("The thuc"),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      matchSettingBloc.createOverlayEntry(context,_matchTypeSelectorKey);
                      ///Show OVERLAY
                    },
                    child: Container(
                        key: _matchTypeSelectorKey,
                        width: 176,
                        height: 42,
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
                  )
                ],
              ),

            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(100)
              ),
              child: Icon(Icons.check,color: Colors.white,size: 14,),
            ),
          )
        ],
      ),
      // height: MediaQuery.sizeOf(context).height,
    );;
  }

}

