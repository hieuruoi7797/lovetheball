import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:splat_mobile/src/blocs/home_bloc/home_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _itemSetting(
                        label: "Chỉnh sửa",
                        iconPath: "assets/svg_pictures/edit_orange.svg"),
                    _itemSetting(
                        label: "Đội bóng",
                        iconPath: "assets/svg_pictures/team_orange.svg")
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _itemSetting(
                        label: "Bạn bè",
                        iconPath: "assets/svg_pictures/friends_orange.svg"),
                    _itemSetting(
                        label: "Thông báo",
                        iconPath: "assets/svg_pictures/message.svg")
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Color(0xFFFD8F51)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _itemAchivement(
                        label: "Game đã chơi",
                        value: 18,
                        iconPath: "assets/svg_pictures/game_count.svg"),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _itemAchivement(
                        label: "Thành tích",
                        value: 37,
                        iconPath: "assets/svg_pictures/achievement.svg"),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: StreamBuilder<PlayerModel>(
                stream: homeBloc.userInfo,
                builder: (context, snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 125,
                        height: 125,
                        child: CircleAvatar(
                          // radius: 50,
                          backgroundImage:
                              AssetImage('assets/png_images/avatar_temp.png'),
                        ),
                      ),
                      (snapshot.hasData)
                          ? Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Text(
                                snapshot.data!.name,
                                style: name_big_size,
                              ),
                            )
                          : Container(),
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                        ),
                        child: GestureDetector(
                          onTap: () => authenticationBloc.logout(),
                          child: Center(
                            child: Text(
                              "QUIT"
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget _itemSetting(
    {required String label, required String iconPath}) {
  return Container(
    width: 127,
    height: 125,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 22,
          height: 22,
          child: SvgPicture.asset(iconPath),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
        ),
        // SizedBox(
        //   height: 23,
        // ),
      ],
    ),
  );
}

Widget _itemAchivement(
    {required String label, int? value, required String iconPath}) {
  return Column(
    children: [
      Text(
        label,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 16,
      ),
      Row(
        children: [
          Container(
            width: 22,
            height: 22,
            child: SvgPicture.asset(iconPath),
          ),
          SizedBox(
            width: 10,
          ),
          value != null
              ? Text(
                  value.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 28),
                )
              : const SizedBox()
        ],
      ),
      SizedBox(
        height: 23,
      ),
    ],
  );
}
