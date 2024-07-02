import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_mobile/src/ui/setting_match/match_custom_info.dart';
import 'package:splat_mobile/src/ui/setting_match/match_type_card.dart';

class SettingMatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thiet lap tran dau nhanh"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.info_outline_rounded))
        ],
        elevation: 1,
      ),
      body: Container(
        color: Color(0xFFF3F7FE),
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            MatchTypeCard(),
            SizedBox(height: 16,),
            MatchCustomSetting()
          ],
        ),
      )
    );
  }

}