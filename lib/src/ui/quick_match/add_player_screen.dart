import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_mobile/constants/icon_custom.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/public/widget_item/common_text_field.dart';
import 'package:splat_mobile/public/widget_item/layout_screen.dart';
import 'package:splat_mobile/public/widget_item/svg_icon.dart';
import 'package:splat_mobile/src/blocs/quick_match/add_player_bloc.dart';

import '../../../public/widget_item/app_button.dart';
import '../../resources/timer_counter_bloc.dart';

class QuickMatchScreen extends StatelessWidget {
  const QuickMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: quickMatchBloc.indexTabBehavior,
        builder: (context, snapshot) {
          // quickMatchBloc.checkTab(0);
          return DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Container(
              color: color_FFFFFF,
              width: 500,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width*0.4,
                            child: Text('THÊM NGƯỜI CHƠI',
                              style: textNameItem,
                              textAlign: TextAlign.center,)
                        ),
                        GestureDetector(
                            onTap: (){Navigator.pop(context);},
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:  Color(0xffd8e5f3).withOpacity(0.6)
                              ),
                                child:SvgIcon(icon:CustomIcon.close, size: 24,)
                            )
                        )
                      ],
                    ),
                  ),
                TabBar(
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
                      text: "Đã mời gần đây",
                    ),
                  ],
                  onTap: (int tab){
                    quickMatchBloc.checkTab(tab);
                  },
                ),
                  Expanded(
                      child: TabBarView(
                            children: <Widget>[
                              listFriend(context),
                              listTeams(context)
                            ],
                          ),
                  )
                ],
              ),
            )

            // LayoutScreen(
            //   titleAppbar: "MỜI BẠN BÈ",
            //   subTitle: "ĐANG MỜI ${quickMatchBloc.numberSelect}/${quickMatchBloc.totalListData}",
            //   onClose: (){Navigator.pop(context);},
            //   // onTapBack: (){Navigator.pop(context);},
            //   bottomAppbar: PreferredSize(
            //     preferredSize: Size.fromHeight(70),
            //     child: Container(
            //       height: 45,
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 10,
            //       ),
            //       // margin: EdgeInsets.symmetric(
            //       //   horizontal: 5,
            //       //   vertical: 15
            //       // ),
            //       child: Container(
            //         // decoration: BoxDecoration(
            //         //   borderRadius: BorderRadius.circular(
            //         //     25,
            //         //   ),
            //         //   color: Color(0xffd8e5f3).withOpacity(0.6),
            //         // ),
            //         // padding: const EdgeInsets.symmetric(
            //         //   horizontal: 3,
            //         //   vertical: 3
            //         // ),
            //         child: TabBar(
            //           // indicator: BoxDecoration(
            //           //   borderRadius: BorderRadius.circular(20),
            //           //   color: color_FFFFFF
            //           // ),
            //           indicatorColor: color_E5601A,
            //           // splashBorderRadius: BorderRadius.circular(25,),
            //           dividerColor: Colors.transparent,
            //           indicatorSize: TabBarIndicatorSize.tab,
            //           labelColor: color_313A3E,
            //           labelStyle: textLabelTab,
            //           unselectedLabelStyle: textUnSelectLabelTab,
            //           unselectedLabelColor: color_627488,
            //           tabs: <Widget>[
            //             Tab(
            //               text: "Danh sách bạn bè",
            //             ),
            //             Tab(
            //               text: "Đội bóng",
            //             ),
            //           ],
            //           onTap: (int tab){
            //             quickMatchBloc.checkTab(tab);
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            //   bodyLayout:TabBarView(
            //     children: <Widget>[
            //       listFriend(context),
            //       listTeams(context)
            //     ],
            //   ),
            //   // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            //   // bottomSheet: Container(
            //   //     height: MediaQuery.of(context).size.height*0.18,
            //   //     padding: EdgeInsets.symmetric(horizontal: 15),
            //   //     color: color_FFFFFF,
            //   //     child: Column(
            //   //       children: [
            //   //         Row(
            //   //           mainAxisAlignment: MainAxisAlignment.center,
            //   //           children: [
            //   //             StreamBuilder<Object>(
            //   //               stream: quickMatchBloc.checkRememberActionBehavior,
            //   //               builder: (context, snapshot) {
            //   //                 return Checkbox(
            //   //                   shape: RoundedRectangleBorder(
            //   //                       borderRadius: BorderRadius.circular(5)),
            //   //                   checkColor: Colors.white,
            //   //                   activeColor: color_E5601A,
            //   //                   value: quickMatchBloc.checkRememberAction,
            //   //                   onChanged: (bool? value) {
            //   //                     quickMatchBloc.setCheckRememberAction(value);
            //   //                   },
            //   //                 );
            //   //               }
            //   //             ),
            //   //             Text(
            //   //               "Ghi nhớ danh sách mời",
            //   //               style: TextStyle(
            //   //                   fontSize: 17,
            //   //                   fontWeight: FontWeight.w600,
            //   //                   color: color_313A3E
            //   //               ),
            //   //             ),
            //   //           ],
            //   //         ),
            //   //         AppButton.buttonGen1(
            //   //           onTap: (){},
            //   //           buttonName: "Chọn người chơi trận đấu trước",
            //   //           height: 56,
            //   //           width: MediaQuery.sizeOf(context).width * 0.92,
            //   //           enableLoadingAnimation: false,
            //   //           context: context,
            //   //         )
            //   //       ],
            //   //     ),
            //   //   ),
            // ),
          );
        }
    );
  }
}
Widget listTeams(BuildContext context){
  return Container(
    color: Color(0xffd8e5f3).withOpacity(0.6),
    child: Column(
      children: [
        Container(
          // width: MediaQuery.of(context).size.width*0.5,
          // height: MediaQuery.of(context).size.height*0.65,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height:30,
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
                            alignment: Alignment.centerLeft,
                            // padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      color:  color_E4EBF2,
                                    )
                                ),
                            ),
                            width: MediaQuery.of(context).size.width*0.42,
                            child:
                            ListTile(
                              title: Text(
                                quickMatchBloc.modelTeams["responseBody"][index]['teams_name'],
                                style: textNameItem, // Custom text style for team name
                                textAlign: TextAlign.left,
                              ),
                              trailing: Container(
                                decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffd8e5f3).withOpacity(0.6),
                                ),
                                child: TextButton.icon(
                                  icon: Icon(
                                    quickMatchBloc.lsTeams.contains(
                                      quickMatchBloc.modelTeams["responseBody"][index]['teams_id'],
                                    )
                                        ? Icons.check // Show check circle if selected
                                        : Icons.add,  // Show outlined circle if not selected
                                    color: quickMatchBloc.lsTeams.contains(
                                      quickMatchBloc.modelTeams["responseBody"][index]['teams_id'],
                                    )
                                        ? color_ACC7E1 // Color when selected
                                        : color_31393E, // Color when not selected
                                  ),
                                  label: Text(
                                    quickMatchBloc.lsTeams.contains(
                                      quickMatchBloc.modelTeams["responseBody"][index]['teams_id'],
                                    )
                                    ? "Gửi lại sau(60s)"
                                    : "Gửi lời mời",
                                    style: TextStyle(
                                      color: quickMatchBloc.lsTeams.contains(
                                        quickMatchBloc.modelTeams["responseBody"][index]['teams_id'],
                                      )
                                          ? color_ACC7E1 // Text color when selected
                                          : color_31393E, // Text color when not selected
                                    ),
                                  ),
                                  onPressed: () {
                                    bool isSelected = quickMatchBloc.lsTeams.contains(
                                      quickMatchBloc.modelTeams["responseBody"][index]['teams_id'],
                                    );

                                    // Toggle team selection
                                    quickMatchBloc.onTeamsSelected(
                                      !isSelected,
                                      quickMatchBloc.modelTeams["responseBody"][index]['teams_id'],
                                    );

                                    // Update the number of selected teams
                                    quickMatchBloc.setNumberCount(quickMatchBloc.lsTeams.length);

                                    // Ensure we update the current tab and the total team count
                                    quickMatchBloc.checkTab(1);
                                    quickMatchBloc.setTotal(quickMatchBloc.modelTeams["responseTotalResult"]);
                                  },
                                ),
                              ),
                            )

                            // CheckboxListTile(
                            //     checkboxShape:CircleBorder(),
                            //     activeColor: color_E5601A,
                            //     side: const BorderSide(
                            //         color: color_ACC7E1
                            //     ),
                            //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            //     title: Text(quickMatchBloc.modelTeams["responseBody"][index]['teams_name'],
                            //       style: textNameItem,
                            //       textAlign: TextAlign.left,
                            //     ),
                            //     value: quickMatchBloc.lsTeams.contains(quickMatchBloc.modelTeams["responseBody"][index]['teams_id']),
                            //     onChanged: (bool? selected){
                            //       quickMatchBloc.onTeamsSelected(selected!, quickMatchBloc.modelTeams["responseBody"][index]['teams_id']);
                            //       quickMatchBloc.setNumberCount(quickMatchBloc.lsTeams.length);
                            //       quickMatchBloc.checkTab(1);
                            //       quickMatchBloc.setTotal(quickMatchBloc.modelTeams["responseTotalResult"]);
                            //     }
                            // ),
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
Widget listFriend(BuildContext context) {
  return StreamBuilder<Object>(
    stream: quickMatchBloc.searching,
    builder: (context, snapshot) {
      return Container(
        color: Color(0xffd8e5f3).withOpacity(0.6),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            StreamBuilder<Object>(
              stream: quickMatchBloc.searchListFriendsBehavior,
              builder: (context, snapshot) {
                return Common.commonSearchText(
                  context,
                  paddingBox: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01,
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  hintText: "Tìm kiếm bạn bè",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: SvgIcon(icon: CustomIcon.icon_search, size: 6),
                  ),
                  type: TextInputType.text,
                  controller: quickMatchBloc.searchFriendController,
                  onChanged: (value) {
                    quickMatchBloc.filterFriends(
                        context, quickMatchBloc.searchFriendController.text);
                  },
                );
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              height: MediaQuery.of(context).size.height * 0.52,
              margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
              decoration: BoxDecoration(
                color: color_FFFFFF,
                borderRadius: BorderRadius.circular(10),
              ),
              child: StreamBuilder<Object>(
                stream: quickMatchBloc.lsAddFriendsBehavior,
                builder: (context, snapshot) {
                  final totalResults = quickMatchBloc.isSearching
                      ? quickMatchBloc.modelFriendSearch['responseTotalResult']
                      : quickMatchBloc.modelFriend['responseTotalResult'];

                  return totalResults != 0
                      ? ListView.builder(
                    itemCount: totalResults,
                    itemBuilder: (BuildContext context, int index) {
                      final friend = quickMatchBloc.isSearching
                          ? quickMatchBloc.modelFriendSearch["responseBody"][index]
                          : quickMatchBloc.modelFriend["responseBody"][index];

                      final friendId = friend['id_'];
                      final isInvited = quickMatchBloc.lsFriends.contains(friendId);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Friend Avatar
                          Container(
                            width: 30,
                            height: 30,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.blue,
                              image: DecorationImage(
                                image: AssetImage("assets/png_images/default_avt.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Friend Name and Button
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: color_E4EBF2,
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.46,
                            child: ListTile(
                              title: Container(
                                child: Text(
                                  friend['name'],
                                  style: textNameItem,
                                  textAlign: TextAlign.left,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              titleAlignment: ListTileTitleAlignment.top,
                              trailing: StreamBuilder<Map<String, int>>(
                                stream: quickMatchBloc.timerStream,
                                builder: (context, timerSnapshot) {
                                  // Get the remaining time for the current friend
                                  final remainingTime = timerSnapshot.data?[friendId] ?? 0;

                                  return Container(
                                    width: MediaQuery.of(context).size.width * 0.21,
                                    child: TextButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                          if (states.contains(MaterialState.disabled)) {
                                            return Colors.transparent; // Color when the button is pressed
                                          }
                                          return Color(0xffd8e5f3).withOpacity(0.6);// Default color
                                        }),
                                        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((Set<MaterialState> states) {
                                          if (states.contains(MaterialState.selected)) {
                                            return null; // No border when selected
                                          }
                                          return RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12), // Default border shape
                                          );
                                        }),
                                      ),
                                      onPressed: isInvited && remainingTime > 0
                                          ? null // Disable if already invited
                                          : () {
                                        quickMatchBloc.onFriendsSelected(
                                          !isInvited,
                                          friendId,
                                        );

                                        // Start Countdown
                                        quickMatchBloc.setNumberCount(quickMatchBloc.lsFriends.length);
                                        quickMatchBloc.setTotal(totalResults);
                                        quickMatchBloc.checkTab(0);
                                        quickMatchBloc.startFriendTimer(friendId);
                                        quickMatchBloc.sendFriendInvite(context,friendId: friendId);// Start a timer for this friend
                                      },
                                      icon: Icon(
                                        isInvited && remainingTime > 0? Icons.check : Icons.add,
                                        color: isInvited && remainingTime > 0? color_ACC7E1 : color_31393E,
                                      ),
                                      label: Container(
                                        width: isInvited && remainingTime > 0?MediaQuery.of(context).size.width * 0.4:MediaQuery.of(context).size.width * 0.1,
                                        child: Text(
                                          isInvited && remainingTime > 0
                                              ? "Gửi lại sau (${remainingTime}s)" // Show remaining time if invited
                                              : "Gửi lời mời", // Active button label
                                          style: TextStyle(
                                            color: isInvited && remainingTime > 0 ? color_ACC7E1 : color_31393E,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                      : Center(child: Text("Không có người chơi trong danh sách!"));
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}







