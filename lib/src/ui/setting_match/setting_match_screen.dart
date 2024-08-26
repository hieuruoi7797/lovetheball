import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/public/widget_item/app_button.dart';
import 'package:splat_mobile/src/blocs/match/match_setting_bloc.dart';
import 'package:splat_mobile/src/blocs/quick_match/quick_match_bloc.dart';
import 'package:splat_mobile/src/ui/setting_match/match_custom_info.dart';
import 'package:splat_mobile/src/ui/setting_match/match_type_card.dart';

class SettingMatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    matchSettingBloc.getMatchSetting();
    return Scaffold(
      appBar: AppBar(
        title: Text("Thiet lap tran dau nhanh"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.info_outline_rounded))
        ],
        elevation: 1,
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.sizeOf(context).height * 0.15,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<bool>(
                  stream: matchSettingBloc.checkRememberBehavior,
                  builder: (context, checkRemember) {
                    return Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      checkColor: Colors.white,
                      activeColor: color_E5601A,
                      value: checkRemember.data??false,
                      onChanged: (bool? value) {
                        matchSettingBloc.setCheckRemember(value);
                      },
                    );
                  }
                ),
                Text("Ghi nho cai dat tran dau"),
              ],
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: AppButton.buttonGen1(
                onTap: () {
                  matchSettingBloc.sendMatch();
                  quickMatchBloc.getUsers(context);
                  Navigator.pushNamed(context, QUICK_MATCH);
                },
                buttonName: "tiep tuc",
                height: 50,
                enableLoadingAnimation: false,
                context: context,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFFF3F7FE),
        padding: EdgeInsets.all(16),
        child: StreamBuilder<String>(
          stream: matchSettingBloc.pickingMatchTitle,
          builder: (context, pickingMatchTitle) {
            return ListView(
              children: [
                MatchTypeCard(isPicking: pickingMatchTitle.data == STANDARD_3v3,typeName: STANDARD_3v3,),
                const SizedBox(height: 16,),
                MatchCustomSetting(isPicking: pickingMatchTitle.data == CUSTOM_MATCH)
              ],
            );
          }
        ),
      )
    );
  }

}