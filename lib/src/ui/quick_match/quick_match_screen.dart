import 'package:flutter/material.dart';
import 'package:splat_mobile/constants/icon_custom.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/public/widget_item/common_text_field.dart';
import 'package:splat_mobile/public/widget_item/layout_screen.dart';
import 'package:splat_mobile/public/widget_item/svg_icon.dart';
import 'package:splat_mobile/src/blocs/quick_match/quick_match_bloc.dart';

import '../../../public/widget_item/app_button.dart';

class QuickMatchScreen extends StatelessWidget {
  const QuickMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: StreamBuilder<Object>(
        stream: quickMatchBloc.indexTabBehavior,
        builder: (context, snapshot) {
          // quickMatchBloc.checkTab(0);
          return LayoutScreen(
              titleAppbar: "MỜI BẠN BÈ",
              subTitle: "ĐANG MỜI ${quickMatchBloc.numberSelect}/${quickMatchBloc.totalListData}",
              onClose: (){Navigator.pop(context);},
              onTapBack: (){Navigator.pop(context);},
              bottomAppbar: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  // margin: EdgeInsets.symmetric(
                  //   horizontal: 5,
                  //   vertical: 15
                  // ),
                  child: Container(
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(
                    //     25,
                    //   ),
                    //   color: Color(0xffd8e5f3).withOpacity(0.6),
                    // ),
                    // padding: const EdgeInsets.symmetric(
                    //   horizontal: 3,
                    //   vertical: 3
                    // ),
                    child: TabBar(
                        // indicator: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20),
                        //   color: color_FFFFFF
                        // ),
                        indicatorColor: color_E5601A,
                        // splashBorderRadius: BorderRadius.circular(25,),
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: color_313A3E,
                        labelStyle: textLabelTab,
                        unselectedLabelStyle: textUnSelectLabelTab,
                        unselectedLabelColor: color_627488,
                        tabs: <Widget>[
                          Tab(
                            text: "Danh sách bạn bè",
                          ),
                          Tab(
                            text: "Đội bóng",
                          ),
                        ],
                      onTap: (int tab){
                          quickMatchBloc.checkTab(tab);
                      },
                    ),
                  ),
                ),
              ),
              bodyLayout:TabBarView(
                    children: <Widget>[
                      listFriend(context),
                      listTeams(context)
                    ],
                  ),
                // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomSheet: Container(
                  height: MediaQuery.of(context).size.height*0.18,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  color: color_FFFFFF,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StreamBuilder<Object>(
                            stream: quickMatchBloc.checkRememberActionBehavior,
                            builder: (context, snapshot) {
                              return Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                checkColor: Colors.white,
                                activeColor: color_E5601A,
                                value: quickMatchBloc.checkRememberAction,
                                onChanged: (bool? value) {
                                  quickMatchBloc.setCheckRememberAction(value);
                                },
                              );
                            }
                          ),
                          Text(
                            "Ghi nhớ danh sách mời",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: color_313A3E
                            ),
                          ),
                        ],
                      ),
                      AppButton.buttonGen1(
                        onTap: (){},
                        buttonName: "Bắt đầu trận đấu",
                        height: 56,
                        width: MediaQuery.sizeOf(context).width * 0.92,
                        enableLoadingAnimation: false,
                        context: context,
                      )
                    ],
                  ),
                ),
          );
        }
      )
    );
  }
}
Widget listTeams(BuildContext context){
  return Container(
    color: Color(0xffd8e5f3).withOpacity(0.6),
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.height*0.54,
          margin: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: color_FFFFFF,
            borderRadius: BorderRadius.circular(10),
          ),
          child: StreamBuilder<Object>(
              stream: quickMatchBloc.addTeamsBehavior,
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: quickMatchBloc.modelTeams["responseTotalResult"],
                    itemBuilder: (BuildContext context, int index){
                      return Row(
                        children: [
                          Container(
                            width: 32,
                            height:32,
                            margin: EdgeInsets.only(right: 10,left: 10),
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/png_images/default_avt.png",
                                    ),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      color:  color_E4EBF2,
                                    )
                                )
                            ),
                            width: MediaQuery.of(context).size.width*0.767,
                            child: CheckboxListTile(
                                checkboxShape:CircleBorder(),
                                activeColor: color_E5601A,
                                side: const BorderSide(
                                    color: color_ACC7E1
                                ),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                title: Text(quickMatchBloc.modelTeams["responseBody"][index]['teams_name'],
                                  style: textNameItem,
                                ),
                                value: quickMatchBloc.lsTeams.contains(quickMatchBloc.modelTeams["responseBody"][index]['teams_id']),
                                onChanged: (bool? selected){
                                  quickMatchBloc.onTeamsSelected(selected!, quickMatchBloc.modelTeams["responseBody"][index]['teams_id']);
                                  quickMatchBloc.setNumberCount(quickMatchBloc.lsTeams.length);
                                  quickMatchBloc.checkTab(1);
                                  quickMatchBloc.setTotal(quickMatchBloc.modelTeams["responseTotalResult"]);
                                }
                            ),
                          ),
                        ],
                      );
                    }
                );
              }
          ),
        ),
      ],
    ),
  );
}
Widget listFriend(BuildContext context){
  return Container(
    color: Color(0xffd8e5f3).withOpacity(0.6),
    child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        StreamBuilder<Object>(
          stream: quickMatchBloc.searchFriends,
          builder: (context, snapshot) {
            return Common.commonSearchText(context,
              paddingBox: EdgeInsets.symmetric(
                vertical: 10,horizontal: 20
              ),
              hintText: "Tìm kiếm bạn bè",
              prefixIcon: const Padding(
                padding: EdgeInsets.all(12),
                child: SvgIcon(icon: CustomIcon.icon_search, size: 6),
              ),
              type: TextInputType.text,
              controller: quickMatchBloc.searchFriendController,
              onChanged: (value){
                // quickMatchBloc.onSearchFriends(value);
              }
            );
          }
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.height*0.45,
          margin: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color_FFFFFF,
            borderRadius: BorderRadius.circular(10),
          ),
          child: StreamBuilder<Object>(
            stream: quickMatchBloc.lsAddFriendsBehavior,
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: quickMatchBloc.modelFriend["responseTotalResult"],
                itemBuilder: (BuildContext context, int index){
                  return Row(
                    children: [
                      Container(
                        width: 32,
                        height:32,
                        margin: EdgeInsets.only(right: 10,left: 10),
                        decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.blue,
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/png_images/default_avt.png",
                                ),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color:  color_E4EBF2,
                                )
                            )
                        ),
                        width: MediaQuery.of(context).size.width*0.767,
                        child: CheckboxListTile(
                            checkboxShape:  CircleBorder(),
                            activeColor: color_E5601A,
                            side: const BorderSide(
                                color: color_ACC7E1
                            ),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            title: Text(
                              quickMatchBloc.modelFriend["responseBody"]?[index]['name']??'',
                              style: textNameItem,
                            ),
                            value: quickMatchBloc.lsFriends.contains(quickMatchBloc.modelFriend["responseBody"][index]['id_']),
                            onChanged: (bool? selected){
                              quickMatchBloc.onFriendsSelected(selected!, quickMatchBloc.modelFriend["responseBody"][index]['id_']);
                              quickMatchBloc.setNumberCount(quickMatchBloc.lsFriends.length);
                              quickMatchBloc.setTotal(quickMatchBloc.modelFriend["responseTotalResult"]);
                              quickMatchBloc.checkTab(0);
                            }
                        ),
                      ),
                    ],
                  );
                }
              );
            }
          ),
        ),
      ],
    ),
  );
}
