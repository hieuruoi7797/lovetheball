import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_record/constants/ui_styles.dart';
import 'package:splat_record/src/blocs/game_on/game_on_bloc.dart';
import 'package:splat_record/src/blocs/match/match_creating_bloc.dart';
import 'package:splat_record/src/models/full_stat_model.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/widgets_common/container_common.dart';

import '../../constants/constant_values.dart';
import '../models/stat_model.dart';

class GameOnScreen extends StatelessWidget {
  GameOnScreen({super.key});

  GameOnBloc gameOnBloc = GameOnBloc();

  @override
  Widget build(BuildContext context) {
    // gameOnBloc.getListPlayers();
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
                    image: AssetImage(PNG_BACKGROUND_HOME))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CommonContainer(
                    margin: const EdgeInsets.only(top: 32),
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
                                          stream: gameOnBloc.nowPickIndex,
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
                                              return SizedBox();
                                            }
                                          });
                                    });
                              } else {
                                return SizedBox();
                              }
                            })
                      ],
                    ),
                  ),
                  CommonContainer(
                      parentContext: context,
                      margin: EdgeInsets.only(
                          top: 32,
                          bottom: MediaQuery.sizeOf(context).height * 0.1),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Center(
                            child: StreamBuilder<int>(
                                stream: gameOnBloc.nowPickIndex,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      gameOnBloc
                                          .listPlayers[snapshot.data!].name,
                                      style: title_black_color,
                                    );
                                  } else {
                                    return Text(ERROR_UNKNOWN);
                                  }
                                }),
                          ),
                          StreamBuilder<Stats>(
                            stream: gameOnBloc.pickedPlayerStatPublish,
                            builder: (context,AsyncSnapshot<Stats> snapshot) {
                              return Column(
                                children: [
                                  StatInfoEdittingContainer(
                                      context: context,
                                      statType: TWO,
                                      quantity: snapshot.hasData ? snapshot.data!.twoPointsShoot.toString() :'0',
                                      onTapPlus: () => gameOnBloc.increase(TWO),
                                      onTapSub: () => gameOnBloc.decrease(TWO)),
                                  StatInfoEdittingContainer(
                                      context: context,
                                      statType: THREE,
                                      quantity: snapshot.hasData? snapshot.data!.threePointsShoot.toString() : "0",
                                      onTapPlus: () => gameOnBloc.increase(THREE),
                                      onTapSub: () => gameOnBloc.decrease(THREE)),
                                  StatInfoEdittingContainer(
                                      context: context,
                                      statType: ASSIST,
                                      quantity: snapshot.hasData? snapshot.data!.assit.toString() : "0",
                                      onTapPlus: () => gameOnBloc.increase(ASSIST),
                                      onTapSub: () => gameOnBloc.decrease(ASSIST)
                                  ),
                                  StatInfoEdittingContainer(
                                      context: context, statType: "Rebound"),
                                  StatInfoEdittingContainer(
                                      context: context, statType: "Block"),
                                  StatInfoEdittingContainer(
                                      context: context, statType: "Steal"),
                                  StatInfoEdittingContainer(
                                      context: context, statType: "Personal Foul"),
                                  StatInfoEdittingContainer(
                                      context: context, statType: "Turn-Over"),
                                  StatInfoEdittingContainer(
                                      context: context, statType: "Dunk"),
                                ],
                              );
                            }
                          ),

                        ],
                      ))
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.1,
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onTap: () => {gameOnBloc.dispose()},
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      height: 48,
                      decoration: BoxDecoration(
                          color: color_main,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child:
                            Text("Kết thúc trận đấu", style: title_white_color),
                      ),
                    ),
                  ),
                ),
              ),
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
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
