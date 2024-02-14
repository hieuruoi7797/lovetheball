import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/src/blocs/home_bloc/home_bloc.dart';
import 'package:splat_mobile/src/blocs/match/match_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';
import 'package:splat_mobile/widgets_common/container_common.dart';
import 'package:splat_mobile/widgets_common/dialogs.dart';
import 'package:splat_mobile/widgets_common/user_name_card.dart';

class CreatingMatchUI extends StatelessWidget{
  const CreatingMatchUI({super.key});

  static BuildContext get parentContext => navigatorKey.currentState!.context;

  static TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(parentContext).size.width,
      height: MediaQuery.of(parentContext).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.25,
              fit: BoxFit.cover,
              image: AssetImage(PNG_BACKGROUND_HOME))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: [
                commonContainer(
                  parentContext: parentContext,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(parentContext).size.height * 0.15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder<PlayerModel>(
                          stream: homeBloc.userInfo,
                          builder: (context,AsyncSnapshot<PlayerModel> snapshot) {
                            if (snapshot.hasData){
                              return Container(
                                margin: const EdgeInsets.only(top: 66),
                                child: Text(snapshot.data!.name,
                                    style: name_big_size),
                              );
                            }else{
                              return Container(
                                margin: const EdgeInsets.only(top: 66),
                                child: const Text(ERROR_UNKNOWN,
                                    style: name_big_size),
                              );
                            }

                          }),
                      gap_24,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        margin: const EdgeInsets.only(bottom: 23),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Game đã chơi",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(
                                              right: 8),
                                          child: SvgPicture.asset(
                                            "assets/svg_pictures/BASKETBALL_ORANGE.svg",
                                          )),
                                      const Text(
                                        "18",
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: Color(0xFF818181)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ), //Game da choi
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Thành tích",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                                Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin:
                                        const EdgeInsets.only(right: 8),
                                        child: SvgPicture.asset(
                                          "assets/svg_pictures/TROPHY_ORANGE.svg",
                                        ),
                                      ),
                                      const Text(
                                        "37",
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: Color(0xFF818181)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ), //Thanh tich
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(parentContext).size.height * 0.12,
                  height: MediaQuery.of(parentContext).size.height * 0.12,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(parentContext).size.height * 0.10),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100)),
                ),
              ],
            ),
            commonContainer(
              parentContext: parentContext,
              // height: MediaQuery.of(context).size.height * 0.43,
              margin: const EdgeInsets.only(top: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: StreamBuilder<bool>(
                    stream: matchBloc.userInMatchBehavior,
                    builder: (context, snapshot) {
                      if (snapshot.hasData){
                        if (snapshot.data == true){
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: const Center(
                              child: Text(
                                  "Bạn đang ở trong một trận đấu!"),
                            ),
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tên game",
                                style: title_black_color,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                height: 36,
                                child: TextField(
                                  controller: nameController,
                                  style: typing_text,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets
                                        .symmetric(
                                        vertical: 10, horizontal: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          50.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    suffixIconConstraints: const BoxConstraints(
                                      maxWidth: 50,
                                      maxHeight: 50,
                                    ),
                                    // suffixIcon: Container(
                                    //   margin: EdgeInsets.only(right: 16),
                                    //   child: SvgPicture.asset(
                                    //     "assets/svg_pictures/EDITING.svg",
                                    //     width: 17,
                                    //     height: 17,
                                    //   ),
                                    // ),
                                    filled: true,
                                    fillColor: const Color(0xFFF1F1F1),
                                  ),
                                ),
                              ),
                              gap_24,
                              const Text(
                                "Người chơi",
                                style: title_black_color,
                              ),
                              gap_24,
                              GestureDetector(
                                onTap: () =>
                                    matchBloc.showAddingPlayersBottom(
                                        context),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: color_main,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          50)),
                                  child: const Center(
                                    child: Text("Thêm người chơi",
                                        style: title_main_color),
                                  ),
                                ),
                              ),
                              StreamBuilder<List<PlayerModel>>(
                                  stream: matchBloc.addedPlayersList,
                                  builder: (context,
                                      AsyncSnapshot<
                                          List<PlayerModel>> snapshot) {
                                    if (snapshot.hasData) {
                                      matchBloc.addingPlayersList =
                                      snapshot.data!;
                                      return ListView.builder(
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data?.length,
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(top: 15),
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                userNameCard(
                                                    parentContext: context,
                                                    userName:
                                                    snapshot.data?[index]
                                                        .name,
                                                    suffixIcon: snapshot
                                                        .data?[index].id ==
                                                        homeBloc.nowUserInfo
                                                            ?.id
                                                        ? const SizedBox()
                                                        : null,
                                                    onTapSuffix: snapshot
                                                        .data?[index].id ==
                                                        homeBloc.nowUserInfo
                                                            ?.id
                                                        ? () => {}
                                                        : () =>
                                                        matchBloc
                                                            .removePlayerTap(
                                                            index,
                                                            context,
                                                            nameController
                                                                .text)),
                                                gap_default,
                                              ],
                                            );
                                          });
                                    } else if (snapshot.hasError) {
                                      return DialogWidget().showFailDialog("PLAYERS GETTING FAIL");
                                    } else {
                                      return Container();
                                    }
                                  }),
                              gap_default,
                              GestureDetector(
                                onTap: () =>
                                    matchBloc.createMatch(
                                        context: context,
                                        name: nameController.text),
                                child: Center(
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.47,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        color: color_main,
                                        borderRadius: BorderRadius.circular(
                                            50)),
                                    child: const Center(
                                      child:
                                      Text("Tạo game",
                                          style: title_white_color),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }else{
                        return Container();
                      }
                    }
                ),
              ),
            ),
            gap_default,
          ],
        ),
      ),
    );

  }

}
