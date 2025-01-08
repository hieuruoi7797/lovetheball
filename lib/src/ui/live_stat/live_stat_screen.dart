import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/public/public_methods.dart';
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
                          pickingIndexStream: liveStatBloc.pickingPlayerIndexTeamA),
                      Spacer(),
                      myListPlayerOnCourtUI(
                          parentContext: context, 
                          listPlayer: [], teamName: Constants.TEAM_A,
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
                                    child: Container(
                                      color: Colors.redAccent,
                                      child: Center(child: Text("20:00:00"),),
                                    ),
                                  ),
                                  Expanded(
                                    flex:1,
                                    child: Container(
                                      color: Colors.lightBlueAccent,
                                      child: Center(child: Icon(Icons.pause),),
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
                            pickingIndexStream: liveStatBloc.pickingPlayerIndexTeamB),
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

Widget myNameTag(BuildContext context, { required Stream<int> pickingIndexStream}) {
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
                    child: Text(pickingPlayerStream.data!.name),
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
  EdgeInsets? margin
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
              Container(
                color: Colors.blue,
                child: Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
          ///PlayerName
          Text(model.player.name),
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
    child: SizedBox(
      height: 32,
      child: ListView.builder(
          // padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return true? GestureDetector(
              onTap: () => liveStatBloc.changeEnableStatus(index, teamName),
              child: StreamBuilder<int>(
                stream: pickingIndexStream,
                builder: (context, pickingPlayerIndex) {
                  return Container(
                    width: 32,
                    height: 32,
                    color: (pickingPlayerIndex.hasData && pickingPlayerIndex.data == index ) ?
                        Colors.blue:
                        Colors.red,
                    margin: EdgeInsets.only(right: 20),
                    // child: Image(
                    //     image: AssetImage('assets/png_images/bg_home.png'),
                    //     fit: BoxFit.fill,
                    // ),
                  );
                }
              ),
            ):Container(

            );
          }),
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