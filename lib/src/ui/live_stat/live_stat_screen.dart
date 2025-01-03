import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splat_mobile/public/public_methods.dart';
import 'package:splat_mobile/src/blocs/match/live_stat_bloc.dart';
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
                                (i) => myLiveStatButton(
                                context: context,
                                name: liveStatBloc.offensiveStatsList[i]["statName"],
                                icon: liveStatBloc.offensiveStatsList[i]["icon"]??const Icon(Icons.sports_basketball))).toList(),
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
                      Container(
                        height: fullHeight * 0.113,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      Spacer(),
                      myListPlayerOnCourtUI(parentContext: context, listPlayer: []),
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
                    ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index){
                        return myUpdatedStatItem(
                          context: context,
                          margin: EdgeInsets.only(
                              bottom: fullWidth * 0.01,
                              left: fullWidth * 0.015,
                              right: fullWidth * 0.015,

                          )
                        );
                      },
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
                                (i) => myLiveStatButton(
                                context: context,
                                name: liveStatBloc.defensiveStatsList[i]["statName"],
                                icon: liveStatBloc.defensiveStatsList[i]["icon"]??const Icon(Icons.sports_basketball))).toList(),
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
                        Container(
                          height: fullHeight * 0.113,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                        Spacer(),
                        myListPlayerOnCourtUI(parentContext: context, listPlayer: []),
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

Widget myUpdatedStatItem({
  required BuildContext context,
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
                child: Text("TVC That bai"),
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
          Text("Tran Trung Hieu"),
          ///LogTime
          Text("20:57:34")
        ],
      ),
    );
}

Widget myListPlayerOnCourtUI({
  required BuildContext parentContext,
  required List<PlayerModel> listPlayer,
}) {
  return SizedBox(
    child: SizedBox(
      height: 32,
      child: ListView.builder(
          // padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return true? Container(
              width: 32,
              height: 32,
              color: Colors.blue,
              margin: EdgeInsets.only(right: 20),
              // child: Image(
              //     image: AssetImage('assets/png_images/bg_home.png'),
              //     fit: BoxFit.fill,
              // ),
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
  double? width}) {

  return Container(
    width: width ?? MediaQuery.of(context).size.height * 0.18,
    height: width ?? MediaQuery.of(context).size.height * 0.18,
    decoration: BoxDecoration(
      color: Colors.lime
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(child: icon),
        Text(name,textAlign: TextAlign.center,style: TextStyle(fontSize: 8),)
      ],
    ),
  );
}