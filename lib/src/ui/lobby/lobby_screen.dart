import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:splat_mobile/src/ui/lobby/list_pending_players.dart';
import 'package:splat_mobile/src/ui/lobby/list_starting_five.dart';
import 'package:splat_mobile/src/ui/lobby/list_sub_team.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});


  @override
  State<StatefulWidget> createState() => _LobbyState();

}

class _LobbyState extends State<LobbyScreen> {
  bool pendingListExpanded = false;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    pendingListExpanded = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tran dau tuy chinh - 5v5"),
        backgroundColor: Colors.white,
        actions: [],
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            padding: EdgeInsets.symmetric(
                horizontal: 52,
                // vertical: 24
            ),
            color: Color(0xFFD8E5F3),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                       flex: 1,
                         child: Container(
                           // padding: const EdgeInsets.symmetric(: 52),
                       // color: Colors.yellow,
                           child: SingleChildScrollView(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 const SizedBox(height: 16,),
                                 const Text("TEAM 1"),
                                 ListStartingFive(
                                     itemCount: 5,
                                      expanded: !pendingListExpanded,
                                   rightToLeft: false,),
                                 // Spacer(),
                                 const SizedBox(height: 8,),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     const SizedBox(height: 8,),
                                   ],
                                 )
                               ],
                             ),
                           ),
                     )),
                    Expanded(
                        flex: pendingListExpanded ? 6 : 1,
                        child:

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 16,),
                                const Text(""),
                                const SizedBox(height: 8,),
                                ListPendingPlayers(
                                    expanded: pendingListExpanded,
                                    onTapExpanded: () => setState(() {
                                      pendingListExpanded = !pendingListExpanded;
                                    }),)
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          // padding: const EdgeInsets.symmetric(horizontal: 20),
                          // color: Colors.yellow,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 16,),
                                const Text("TEAM 2"),
                                ListStartingFive(
                                  itemCount: 5,
                                  expanded: !pendingListExpanded,
                                  rightToLeft: true
                                ),
                                // Spacer(),
                                const SizedBox(height: 8,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 8,),
                                  ],
                                )
                              ],
                            ),
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
                        ListSubTeam(itemCount: 6),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("DU BI TEAM 2"),
                        const SizedBox(height: 8,),
                        ListSubTeam(itemCount: 6),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
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
          )
        ],
      ),
    );
  }
}



