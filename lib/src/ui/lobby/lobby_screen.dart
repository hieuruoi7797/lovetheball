import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/src/blocs/lobby/lobby_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';
import 'package:splat_mobile/public/widget_item/layout_screen.dart';
import 'package:splat_mobile/src/ui/lobby/list_pending_players.dart';
import 'package:splat_mobile/src/ui/lobby/list_starting_five.dart';
import 'package:splat_mobile/src/ui/lobby/list_sub_team.dart';
import 'package:splat_mobile/src/ui/quick_match/add_player_screen.dart';

import '../../blocs/quick_match/add_player_bloc.dart';
import '../../resources/timer_counter_bloc.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});


  @override
  State<StatefulWidget> createState() => _LobbyState();

}

class _LobbyState extends State<LobbyScreen> {
  // bool pendingListExpanded = false;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    // pendingListExpanded = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    lobbyBloc.initData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    lobbyBloc.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    timerBloc.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void didUpdateWidget(covariant LobbyScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return LayoutScreen(
      keyScaffold: _scaffoldKey,
      titleAppbar: "Tran dau tuy chinh",
      drawer: QuickMatchScreen(),
      onTapBack: (){Navigator.pop(context);},
      bodyLayout: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            padding: EdgeInsets.symmetric(
                horizontal: 52,
                // vertical: 24
            ),
            color: Color(0xFFD8E5F3),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                         flex: 1,
                           child: SingleChildScrollView(
                             child: StreamBuilder<List<PlayerModel>>(
                               stream: lobbyBloc.getListTeamOnePlayers,
                               builder: (context, listTeamOne)
                               {
                                 if (listTeamOne.connectionState == ConnectionState.waiting) {
                                   return Text('Waiting for data...');
                                 } else if (listTeamOne.hasData) {
                                   return StreamBuilder<bool?>(
                                     stream: lobbyBloc.pendingListExpanded,
                                     builder: (context, pendingListExpanded) {
                                       if (pendingListExpanded.hasData){
                                         return ListStartingFive(
                                           teamKey: Constants.TEAM_A,
                                           listStartingFive: listTeamOne.hasData ? listTeamOne.data! : [],
                                           expanded: !(pendingListExpanded.data!),
                                           rightToLeft: false,);
                                       }else{
                                         return const SizedBox();
                                       }
                                     }
                                   );
                                 } else {
                                   return Text('No data available');
                                 }
                               },
                             ),
                           )),
                      StreamBuilder<bool?>(
                        stream: lobbyBloc.pendingListExpanded,
                        builder: (context, pendingListExpanded) {
                          return Expanded(
                              flex: pendingListExpanded.data == true ? 6 : 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 16,),
                                    const Text(""),
                                    ListPendingPlayers(
                                        expanded: pendingListExpanded.data == true,
                                        onTapExpanded: () => lobbyBloc.setPendingListExpanded(),
                                        openDrawer: ()=>Scaffold.of(context).openDrawer()
                                    )
                                  ],
                                ),
                              ));
                        }
                      ),
                      Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                StreamBuilder<List<PlayerModel>>(
                                  stream: lobbyBloc.getListTeamTwoPlayers,
                                  builder: (context, listTeamTwo) {
                                    return StreamBuilder<bool?>(
                                      stream: lobbyBloc.pendingListExpanded,
                                      builder: (context, pendingListExpanded) {
                                        return ListStartingFive(
                                          expanded: !(pendingListExpanded.data??false),
                                          rightToLeft: true,
                                          listStartingFive: listTeamTwo.hasData? listTeamTwo.data!:[],
                                          teamKey: Constants.TEAM_B,
                                        );
                                      }
                                    );
                                  }
                                ),
                                // Spacer(),
                                const SizedBox(height: 8,),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: 8,),
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("DU BI TEAM 1"),
                          const SizedBox(height: 8,),
                          SizedBox(
                            // color: Colors.orange,
                            width: MediaQuery.sizeOf(context).width * 0.27,
                              child: ListSubTeam(subTeamKey: Constants.SUB_1)),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("DU BI TEAM 2"),
                          const SizedBox(height: 8,),
                          SizedBox(
                            // color: Colors.orange,
                              width: MediaQuery.sizeOf(context).width * 0.27,
                              child: ListSubTeam(subTeamKey: Constants.SUB_2, alignment: WrapAlignment.end,)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.LIVE_STAT),
              child: Container(
                margin: const EdgeInsets.only(bottom: 18),
                height: 56,
                width: MediaQuery.sizeOf(context).width * 0.3,
                decoration: BoxDecoration(
                  color: const Color(0xFFACC7E1),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Center(child: const Text("BẮT ĐẦU")),
              ),
            ),
          )
        ],
      ),
    );
  }
}



