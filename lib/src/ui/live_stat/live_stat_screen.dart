import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/public/public_methods.dart';
import 'package:splat_mobile/src/blocs/lobby/lobby_bloc.dart';
import 'package:splat_mobile/src/blocs/match/live_stat_bloc.dart';
import 'package:splat_mobile/src/models/live_stat_model.dart';
import 'package:splat_mobile/src/models/player_model.dart';
import 'package:splat_mobile/src/ui/lobby/list_starting_five.dart';

class LiveStatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LiveStatState();

}

class _LiveStatState extends State<LiveStatScreen> {

  List<int> _offensiveItems = List.generate(6, (i) => i);
  List<int> _defensiveItems = List.generate(6, (i) => i);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    liveStatBloc.init();
  }


  @override
  void didUpdateWidget(covariant LiveStatScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.sizeOf(context).width;
    double fullHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.sizeOf(context).height * 0.1), // here the desired height
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tran dau tuy chinh 5v5"),
                Container(
                  color: Colors.grey,
                    child: Text("Hiep 1"))
              ],
            ),
            backgroundColor: Colors.greenAccent,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.info_outline,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                  ))
            ],
            // ...
          ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 4,
              child: Container(
                color: Colors.amber,
              child: Column(
                children: [
                  ///List Offensive Buttons
                Container(
                    padding: EdgeInsets.only(right: fullWidth * 0.02),
                    height: fullHeight * 0.48,
                    width: double.infinity,
                    color: Color(0xffD8E5F3),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        spacing: fullHeight * 0.028,
                        runSpacing: fullHeight * 0.028,
                        direction: Axis.horizontal,
                        children: _offensiveItems.map(
                                (i) => StreamBuilder<bool>(
                                  stream: liveStatBloc.statAddingStatus,
                                  builder: (context, statAddingStatus) {
                                    return myLiveStatButton(
                                    onTap: () => liveStatBloc.addLiveStat(liveStatBloc.offensiveStatsList[i]["statName"]),
                                    context: context,
                                    name: liveStatBloc.offensiveStatsList[i]["statName"],
                                    icon: liveStatBloc.offensiveStatsList[i]["icon"]??const Icon(Icons.sports_basketball),
                                    addingStatus: statAddingStatus.hasData?statAddingStatus.data??false:false);
                                  }
                                )).toList(),
                      ),
                    ),
                  ),
                Spacer(),
                  ///List Team Player
                Container(
                  height: fullHeight * 0.32,
                  color: Color(0xffF0F5FF),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myNameTag(
                          context,
                          pickingIndexStream: liveStatBloc.pickingPlayerIndexTeamA,
                          teamCode: Constants.TEAM_A),
                      Spacer(),
                      myListPlayerOnCourtUI(
                          parentContext: context, 
                          listPlayer: [],
                          teamName: Constants.TEAM_A,
                          pickingIndexStream: liveStatBloc.pickingPlayerIndexTeamA
                         ),
                      Spacer()
                    ],
                  ),
                )
                ],
              ),)),
          ///List Live Stat + Game Point
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.green,
                child: Stack(
                  children: [
                    StreamBuilder<List<LiveStatModel>>(
                      stream: liveStatBloc.liveStatsStream,
                      builder: (context, liveStatsStream) {
                        if (liveStatsStream.hasData){
                          return ListView.builder(
                            itemCount: liveStatsStream.data?.length,
                            itemBuilder: (context, index){
                              return myUpdatedStatItem(
                                  context: context,
                                  model: liveStatsStream.data![index],
                                  index: index,
                                  margin: EdgeInsets.only(
                                    bottom: fullWidth * 0.01,
                                    left: fullWidth * 0.015,
                                    right: fullWidth * 0.015,
                                  )
                              );
                            },
                          );
                        }else{
                          return SizedBox();
                        }

                      }
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: fullHeight * 0.05),
                        height: fullHeight*0.207,
                        color: Colors.white54,
                        child: Row(
                          children: [
                            Expanded(
                              flex:1,
                              child: Container(
                                height: double.infinity,
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    ///Team Point
                                    "03"
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex:1,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: StreamBuilder<int>(
                                      stream: liveStatBloc.timeSubject,
                                      builder: (context, snapshot) {
                                        return Container(
                                          color: Colors.redAccent,
                                          child: Center(child: Text(
                                            liveStatBloc.formatTime(snapshot.data??Duration(minutes: 10).inMilliseconds)
                                            // snapshot.data.toString(),
                                          ),),
                                        );
                                      }
                                    ),
                                  ),
                                  Expanded(
                                    flex:1,
                                    child: GestureDetector(
                                      onTap:() => liveStatBloc.changeTimer(),
                                      child: Container(
                                        color: Colors.lightBlueAccent,
                                        child: Center(child: StreamBuilder<bool>(
                                          stream: liveStatBloc.timerRun,
                                          builder: (context, snapshot) {
                                            if (snapshot.data == true){
                                              return Icon(Icons.pause);
                                            }else{
                                              return Icon(Icons.play_arrow);
                                            }

                                          }
                                        ),),
                                      ),
                                    ),)
                                ],
                              ),
                            ),
                            Expanded(
                              flex:1,
                              child: Container(
                                height: double.infinity,
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    ///Team Point
                                      "03"
                                  ),
                                ),
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.blueAccent,
              child: Column(
                children: [
                  ///List Defensive Buttons
                  Container(
                    padding: EdgeInsets.only(right: fullWidth * 0.07,),
                    height: fullHeight * 0.48,
                    width: double.infinity,
                    color: Color(0xffD8E5F3),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        spacing: fullHeight * 0.028,
                        runSpacing: fullHeight * 0.028,
                        direction: Axis.horizontal,
                        children: _defensiveItems.map(
                                (i) => StreamBuilder<bool>(
                                  stream: liveStatBloc.statAddingStatus,
                                  builder: (context, statAddingStatus) {
                                    return myLiveStatButton(
                                    onTap: () => liveStatBloc.addLiveStat(liveStatBloc.defensiveStatsList[i]["statName"]),
                                    context: context,
                                    name: liveStatBloc.defensiveStatsList[i]["statName"],
                                    icon: liveStatBloc.defensiveStatsList[i]["icon"]??const Icon(Icons.sports_basketball),
                                    addingStatus: statAddingStatus.hasData?statAddingStatus.data??false:false
                                    );
                                  }
                                )).toList(),
                      ),
                    ),
                  ),
                  Spacer(),
                  ///List Team Player
                  Container(
                    height: fullHeight * 0.32,
                    color: Color(0xffF0F5FF),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        myNameTag(
                            context,
                            pickingIndexStream: liveStatBloc.pickingPlayerIndexTeamB,
                            teamCode: Constants.TEAM_B),
                        Spacer(),
                        myListPlayerOnCourtUI(
                            parentContext: context,
                            listPlayer: [],
                            teamName: Constants.TEAM_B,
                            pickingIndexStream: liveStatBloc.pickingPlayerIndexTeamB),
                        Spacer()
                      ],
                    ),
                  )
                ],
              ),))
        ],
      ),
    );
  }
}

Widget myNameTag(
    BuildContext context,
    {
      required Stream<int> pickingIndexStream,
      String? teamCode
    }) {
  final fullHeight = MediaQuery.sizeOf(context).height;
  return StreamBuilder<PlayerModel>(
      stream: liveStatBloc.pickingPlayer,
      builder: (context, pickingPlayerStream) {
        if (pickingPlayerStream.hasData){
          return StreamBuilder<int>(
              stream: pickingIndexStream,
              builder: (context, pickingIndexStream) {
                if (pickingIndexStream.hasData && pickingIndexStream.data! < 6){
                  return Container(
                    height: fullHeight * 0.113,
                    width: double.infinity,
                    color: Colors.grey,
                    padding: teamCode == Constants.TEAM_A ?
                            EdgeInsets.only(right: fullHeight * 0.02)
                                : EdgeInsets.only(left: fullHeight * 0.02),
                    child: Row(
                      // mainAxisAlignment: teamCode == Constants.TEAM_A?
                      //       MainAxisAlignment.end:
                      //       MainAxisAlignment.start,
                      textDirection:teamCode == Constants.TEAM_A? TextDirection.rtl : TextDirection.ltr,
                      children: [
                        GestureDetector(
                          onTap: () => liveStatBloc.disablePicking(),
                          child: Container(
                            color: Colors.blue,
                            child: Icon(Icons.close),
                          ),
                        ),
                        SizedBox(width: fullHeight * 0.02,),
                        Container(
                          color: Colors.blue,
                          child: Icon(Icons.loop),
                        ),
                        SizedBox(width: fullHeight * 0.04,),
                        Text(
                            pickingPlayerStream.data!.name,
                            style: TextStyle(fontSize: 15),
                        ),

                      ],
                    ),
                  );
                }else{
                  return Container(
                    height: fullHeight * 0.113,
                    width: double.infinity,
                    color: Colors.grey,
                  );
                }
              }
          );
        }else{
          return Container(
            height: fullHeight * 0.113,
            width: double.infinity,
            color: Colors.grey,
          );
        }

      }
  );
}

Widget myUpdatedStatItem({
  required BuildContext context,
  required LiveStatModel model,
  EdgeInsets? margin,
  int? index
}) {
    return Container(
      margin: margin,
      padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.015),
      color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Title
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                color: Colors.yellow,
                child: Text(model.statName),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => liveStatBloc.removeStat(index),
                child: Container(
                  color: Colors.blue,
                  child: Icon(Icons.close),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
          ///PlayerName
          Text('${model.player.id} - ${model.player.name}'),
          ///LogTime
          Text(model.timeStamp)
        ],
      ),
    );
}

Widget myListPlayerOnCourtUI({
  required BuildContext parentContext,
  required List<PlayerModel> listPlayer,
  required String teamName,
  required Stream<int> pickingIndexStream
}) {
  return SizedBox(
    child: StreamBuilder<PlayerModel>(
      stream: liveStatBloc.pickingPlayer,
      builder: (context, pickingPlayer) {
        if (pickingPlayer.hasData && pickingPlayer.data?.id != "000"){
          return StreamBuilder<int>(
            stream: pickingIndexStream,
            builder: (context, pickingIndex) {
              if (pickingIndex.hasData && pickingIndex.data != 6){
                return Container(
                  color: Colors.yellow,
                  child: Row(
                    textDirection: teamName == Constants.TEAM_A ? TextDirection.ltr : TextDirection.rtl,
                    children: [
                      Container(
                        margin: teamName == Constants.TEAM_A ? EdgeInsets.only(left: 16) : EdgeInsets.only(right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              color: Colors.red,
                              // margin: EdgeInsets.only(right: 20),
                            ),
                            Text(pickingPlayer.data?.id??"000")
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }else{
                return myPlayerItemList(teamName);
              }
            }
          );
        }else{
          return myPlayerItemList(teamName);
        }
      }
    ),
  );
}

Widget myPlayerItemList(String teamName) {
  return SizedBox(
    height: 48,
    child: StreamBuilder<List<PlayerModel>>(
      stream: teamName == Constants.TEAM_A ?
      lobbyBloc.listTeamPlayersOne :
      lobbyBloc.listTeamPlayersTwo,
      builder: (context, listPlayer) {
       if ( listPlayer.hasData){
         return ListView.builder(
           // padding: EdgeInsets.zero,
             scrollDirection: Axis.horizontal,
             itemCount: listPlayer.data!.length,
             itemBuilder: (context, index) {
               return true? Container(
                 margin: EdgeInsets.only(right: 20),
                 child: GestureDetector(
                   onTap: () => liveStatBloc.pickPlayer(index, teamName),
                   child: Column(
                     children: [
                       Container(
                         width: 32,
                         height: 32,
                         color: Colors.red,
                       ),
                       Container(
                           child: Text(listPlayer.data![index].id, style: TextStyle(fontSize: 11),))
                     ],
                   ),
                 ),
               ):Container(
               );
             });
       }else{
         return SizedBox();
       }

      }
    ),
  );
}

Widget myLiveStatButton({
  required BuildContext context,
  required String name,
  required Widget icon,
  required bool addingStatus,
  Function()? onTap,
  double? width}) {

  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width ?? MediaQuery.of(context).size.height * 0.18,
      height: width ?? MediaQuery.of(context).size.height * 0.18,
      decoration: BoxDecoration(
        color: addingStatus ? Colors.white : Colors.lime
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: icon),
          Text(name,textAlign: TextAlign.center,style: TextStyle(fontSize: 8),)
        ],
      ),
    ),
  );
}