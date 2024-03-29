import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/src/blocs/game_on/game_on_bloc.dart';
import 'package:splat_mobile/src/blocs/match/match_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';
import 'package:splat_mobile/widgets_common/container_common.dart';

import '../../constants/constant_values.dart';
import '../models/stat_model.dart';

class GameOnScreen extends StatelessWidget {
  const GameOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 0.25,
                    fit: BoxFit.cover,
                    image: AssetImage(png_background_home))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  commonContainer(
                    margin: const EdgeInsets.only(top: 75),
                    padding: const EdgeInsets.all(20),
                    parentContext: context,
                    child: Column(
                      children: [
                        Center(
                          child: StreamBuilder<String>(
                              stream: matchBloc.matchNameBehavior,
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                return Text(
                                  snapshot.hasData ? snapshot.data! : "Game 1",
                                  style: title_black_color,
                                );
                              }),
                        ),
                        StreamBuilder(
                            stream: matchBloc.addedPlayersList,
                            builder: (context,
                                AsyncSnapshot<List<PlayerModel>>
                                    snapshotPlayerList) {
                              if (snapshotPlayerList.hasData) {
                                return GridView.builder(
                                    padding: const EdgeInsets.all(16),
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: snapshotPlayerList.data!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return StreamBuilder<int>(
                                          stream: gameOnBloc.pickPlayerIndex,
                                          builder:
                                              (context, snapshotIndexPicked) {
                                            if (snapshotIndexPicked.hasData) {
                                              return GestureDetector(
                                                  onTap: () => gameOnBloc
                                                      .pickPlayer(index),
                                                  child: snapshotIndexPicked
                                                              .data ==
                                                          index
                                                      ? pickedPlayer()
                                                      : notPickedPlayer(index));
                                            } else {
                                              return const SizedBox();
                                            }
                                          });
                                    });
                              } else {
                                return const SizedBox();
                              }
                            })
                      ],
                    ),
                  ),
                  commonContainer(
                      parentContext: context,
                      margin: const EdgeInsets.only(
                          top: 32,
                          bottom: 24),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Center(
                            child: StreamBuilder<int>(
                                stream: gameOnBloc.pickPlayerIndex,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      gameOnBloc
                                          .listPlayers[snapshot.data!].name,
                                      style: title_black_color,
                                    );
                                  } else {
                                    return const Text(error_unknown);
                                  }
                                }),
                          ),
                          StreamBuilder<Stats>(
                            stream: gameOnBloc.pickedPlayerStatPublish,
                            builder: (context,AsyncSnapshot<Stats> snapshot) {
                              return StreamBuilder<int>(
                                stream: gameOnBloc.pickStatIndex,
                                builder: (context,AsyncSnapshot<int> statIndex) {
                                  return GridView(
                                    padding: const EdgeInsets.all(16),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,),
                                    children: [
                                      statContainer(
                                          onTap:() => gameOnBloc.pickStat(layup),
                                          context: context,
                                          quantity: snapshot.data?.layUp != null ? snapshot.data!.layUp.toString() :"0",
                                          statType: layup,
                                          svgPicture: SvgPicture.asset("assets/svg_pictures/layup.svg"),
                                          svgPicturePicked: SvgPicture.asset("assets/svg_pictures/layup_picked.svg"),
                                          isPicked: statIndex.data == 0  ? true : false),
                                      statContainer(
                                          context: context,
                                          onTap:() => gameOnBloc.pickStat(assist),
                                          statType: assist,
                                          quantity: snapshot.data?.assit != null ? snapshot.data!.assit.toString() :"0",
                                          isPicked: statIndex.data == 1  ? true : false,
                                          svgPicture: SvgPicture.asset("assets/svg_pictures/assist.svg"),
                                          svgPicturePicked: SvgPicture.asset("assets/svg_pictures/assist_picked.svg")),
                                      statContainer(
                                          onTap:() => gameOnBloc.pickStat(mid_range),
                                          context: context,
                                          quantity: snapshot.data?.twoPointsShoot != null ? snapshot.data!.twoPointsShoot.toString() :"0",
                                          statType: mid_range,
                                          svgPicture: SvgPicture.asset("assets/svg_pictures/2point.svg"),
                                          svgPicturePicked: SvgPicture.asset("assets/svg_pictures/2point_picked.svg"),
                                          isPicked: statIndex.data == 2  ? true : false),
                                      statContainer(
                                          onTap:() => gameOnBloc.pickStat(three_points),
                                          context: context,
                                          quantity: snapshot.data?.threePointsShoot != null ? snapshot.data!.threePointsShoot.toString() :"0",
                                          statType: three_points,
                                          svgPicture: SvgPicture.asset("assets/svg_pictures/3point.svg"),
                                          svgPicturePicked: SvgPicture.asset("assets/svg_pictures/3point_picked.svg"),
                                          isPicked: statIndex.data == 3  ? true : false),
                                    ],
                                  );
                                }
                              );
                            }
                          ),
                        ],
                      )),
                  // GestureDetector(
                  //   onTap: () {
                  //     gameOnBloc.finishMatch();
                  //     },
                  //   child: Container(
                  //     margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.1),
                  //     width: 100,
                  //     height: 100,
                  //     decoration: BoxDecoration(
                  //         color: color_main,
                  //         borderRadius: BorderRadius.circular(100)
                  //     ),
                  //     child: const Center(child: Text('Kết thúc',style: TextStyle(color: Colors.white),),),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
                  decoration: const BoxDecoration(
                    color: Colors.white
                  ),
                  child: Row(
                    // index: 1,
                    // backgroundColor: Colors.transparent ,
                    // buttonBackgroundColor: Colors.transparent,
                    // letIndexChange: (index) => false,
                    // height: 75,
                    // onTap: (index) => index == 0 ? gameOnBloc.decrease():gameOnBloc.increase(),
                    children: [
                      const Spacer(),
                      GestureDetector(
                          onTap: () => gameOnBloc.decrease(),
                          child: SvgPicture.asset(subtracting)),
                      Container(),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      GestureDetector(
                          onTap: () => gameOnBloc.increase(),
                          child: SvgPicture.asset(svg_adding)),
                      const Spacer(),

                    ],

                  )
                ),
                GestureDetector(
                  onTap: () {
                    gameOnBloc.finishMatch(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.height * 0.12,
                    height: MediaQuery.of(context).size.height * 0.12,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.10),
                    decoration: BoxDecoration(
                        color: const Color(0xFFE55807),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Container(
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget pickedPlayer() {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(100)),
        ),
      ],
    );
  }

  Widget notPickedPlayer(int index) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(100)),
          // child: Text(snapshot.data![index].name.toString()),
        ),
        Spacer(),
        Text(
          gameOnBloc.listPlayers[index].name,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ],
    );
  }


}
