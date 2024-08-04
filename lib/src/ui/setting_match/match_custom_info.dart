import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/public/widget_item/detail_match_setting_item.dart';
import 'package:splat_mobile/src/blocs/match/match_setting_bloc.dart';
import 'package:splat_mobile/src/models/basketball_match_setting_model.dart';
import 'package:splat_mobile/src/ui/setting_match/match_type_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MatchCustomSetting extends StatefulWidget {
  bool isPicking;
  MatchCustomSetting({super.key, required this.isPicking});


  @override
  State<StatefulWidget> createState() => _MatchCustomSettingState();

}

class _MatchCustomSettingState extends State<MatchCustomSetting> {
  final _matchTypeSelectorKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    matchSettingBloc.setDefaultValue();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return widget.isPicking ?
    Container(
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
              Text(localizations!.custom_match,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700
                ),),
              Spacer(),
              GestureDetector(
                onTap: () => matchSettingBloc.pickAMatchTitle(context,title: localizations.custom_match),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: widget.isPicking ? Colors.orange : Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color:widget.isPicking ?Colors.white: Colors.grey)
                  ),
                  child:  Icon(Icons.check,color: Colors.white,size: 14,),
                ),
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
                       StreamBuilder<int>(
                         stream: matchSettingBloc.choosingMatchTypeIndex,
                         builder: (context, matchTypeIndex) {
                           return Container(
                             margin:EdgeInsets.only(left: 65),
                             child:  matchTypeIndex.hasData ? Text(
                               matchSettingBloc.matchTypesList[matchTypeIndex.data??0],
                               style: TextStyle(
                                 fontSize: 17
                             ),):SizedBox(),
                           );
                         }
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
         StreamBuilder<BasketballMatchSettingModel>(
           stream: matchSettingBloc.settingMatch,
           builder: (context, nowSetting) {
             return DetailMatchSettingItem(
               title: "So hiep",
               widget: Row(
                 children: [
                   GestureDetector(
                     onTap: () {
                       matchSettingBloc.changeNumberOfQuarter(num: 1);
                       ///Show OVERLAY
                     },
                     child: SizedBox(
                       width: 58,
                       height: 42,
                       child: Container(
                           // key: _matchTypeSelectorKey,

                           // padding: EdgeInsets.all(8),
                           decoration: BoxDecoration(
                               color: nowSetting.data?.numbersOfRound == 1 ? Colors.white : Color(0xFF677986).withOpacity(0.4),
                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                           ),
                            child: Center(child: Text("1",style: TextStyle(fontSize: 17),)),
                           ),
                     ),
                   ),
                   GestureDetector(
                     onTap: () {
                       matchSettingBloc.changeNumberOfQuarter(num: 2);
                       ///Show OVERLAY
                     },
                     child: SizedBox(
                       width: 58,
                       height: 42,
                       child: Container(
                         // key: _matchTypeSelectorKey,

                     // padding: EdgeInsets.all(8),
                     decoration: BoxDecoration(
                         color: nowSetting.data?.numbersOfRound == 2 ? Colors.white : Color(0xFF677986).withOpacity(0.4),
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
                   matchSettingBloc.changeNumberOfQuarter(num: 4);
                   ///Show OVERLAY
                 },
                 child: SizedBox(
                   width: 58,
                   height: 42,
                   child: Container(
                     // key: _matchTypeSelectorKey,

                         // padding: EdgeInsets.all(8),
                         decoration: BoxDecoration(
                             color:  nowSetting.data?.numbersOfRound == 4 ? Colors.white : Color(0xFF677986).withOpacity(0.4),
                             borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                         ),
                         child: Center(child: Text("4",style: TextStyle(fontSize: 17),)),
                       ),
                     ),
                   ),
                 ],
               ),
             );
           }
         ),
          const SizedBox(height: 16,),

          ///Tgian moi hiep
          DetailMatchSettingItem(
            title: "T.gian moi hiep",
            widget: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    matchSettingBloc.changeMinutesPerQuarter(symbol: "-");
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
                SizedBox(
                  width: 74,
                  height: 42,
                  child: Container(
                    // key: _matchTypeSelectorKey,

                    // padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: StreamBuilder<BasketballMatchSettingModel>(
                      stream: matchSettingBloc.settingMatch,
                      builder: (context, nowSetting) {
                        return Center(child: Text("${nowSetting.data?.timeOfEachRound ?? 2}'",style: TextStyle(fontSize: 17),));
                      }
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                GestureDetector(
                  onTap: () =>  matchSettingBloc.changeMinutesPerQuarter(symbol: "+"),
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

          ///Hiep phu
          DetailMatchSettingItem(
            title: "Hiep phu",
            widget: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    matchSettingBloc.changeNumberOfOT(symbol: "-");
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
                SizedBox(
                  width: 74,
                  height: 42,
                  child: Container(
                    // key: _matchTypeSelectorKey,

                    // padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: StreamBuilder<BasketballMatchSettingModel>(
                        stream: matchSettingBloc.settingMatch,
                        builder: (context, nowSetting) {
                          return Center(child: Text("${nowSetting.data?.timeOfSubRound??2}'",style: TextStyle(fontSize: 17),));
                        }
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                GestureDetector(
                  onTap: () =>  matchSettingBloc.changeNumberOfOT(symbol: "+"),
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

          ///Diem cham
          DetailMatchSettingItem(
            title: "Diem cham",
            widget: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    matchSettingBloc.changePointsToWin(symbol: "-");
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
                SizedBox(
                  width: 74,
                  height: 42,
                  child: Container(
                    // key: _matchTypeSelectorKey,

                    // padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: StreamBuilder<BasketballMatchSettingModel>(
                        stream: matchSettingBloc.settingMatch,
                        builder: (context, nowSetting) {
                          return Center(child: Text("${nowSetting.data?.cutOffPoints??2}'",style: TextStyle(fontSize: 17),));
                        }
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                GestureDetector(
                  onTap: () =>  matchSettingBloc.changePointsToWin(symbol: "+"),
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

          ///Nem phat
          StreamBuilder<BasketballMatchSettingModel>(
              stream: matchSettingBloc.settingMatch,
              builder: (context, nowSetting) {
                return DetailMatchSettingItem(
                  title: "Nem phat",
                  widget: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          matchSettingBloc.changeEnableFreeThrow(false);
                          ///Show OVERLAY
                        },
                        child: SizedBox(
                          width: 87,
                          height: 42,
                          child: Container(
                            // key: _matchTypeSelectorKey,

                            // padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color:  nowSetting.data?.enableFreeThrow == false ? Colors.white : Color(0xFF677986).withOpacity(0.4),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))

                            ),
                            child: Center(child: Text("Khong",style: TextStyle(fontSize: 17),)),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          matchSettingBloc.changeEnableFreeThrow(true);
                          ///Show OVERLAY
                        },
                        child: SizedBox(
                          width: 87,
                          height: 42,
                          child: Container(
                            // key: _matchTypeSelectorKey,

                            // padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: nowSetting.data?.enableFreeThrow == true ? Colors.white : Color(0xFF677986).withOpacity(0.4),
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                            ),
                            child: const Center(child: Text("Co",style: TextStyle(fontSize: 17),)),
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              }
          ),
          const SizedBox(height: 16,),

        ],
      ),
      // height: MediaQuery.sizeOf(context).height,
    ) :
    StreamBuilder<BasketballMatchSettingModel>(
      stream: matchSettingBloc.settingMatch,
      builder: (context, settingMatch) {
          return MatchTypeCard(
            isPicking: widget.isPicking,
            typeName: localizations!.custom_match,
            settingInfo: settingMatch.hasData ? settingMatch.data! :
            BasketballMatchSettingModel(
              format: 0,
              numbersOfRound: 4,
              timeOfSubRound: 1,
              timeOfEachRound: 10,
              cutOffPoints: null,
              threePointsValue: 3,
              enableFreeThrow: true,
              personalFoulsLimit: 5
            ),
          );
      }
    );
  }

}

