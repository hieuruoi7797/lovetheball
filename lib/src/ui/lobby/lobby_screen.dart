import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:splat_mobile/src/ui/lobby/list_pending_players.dart';
import 'package:splat_mobile/src/ui/lobby/list_starting_five.dart';
import 'package:splat_mobile/src/ui/lobby/list_sub_team.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});


  @override
  State<StatefulWidget> createState() => _LobbyState();

}

class _LobbyState extends State<LobbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tran dau tuy chinh - 5v5"),
        backgroundColor: Colors.white,
        actions: [],
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Color(0xFFD8E5F3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Expanded(
               flex: 1,
                 child: Container(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
               // color: Colors.yellow,
                   child: SingleChildScrollView(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const SizedBox(height: 16,),
                         const Text("TEAM 1"),
                         ListStartingFive(itemCount: 4,),
                         // Spacer(),
                         const SizedBox(height: 8,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text("DU BI TEAM 1"),
                             const SizedBox(height: 8,),
                             ListSubTeam(itemCount: 6)
                           ],
                         )
                       ],
                     ),
                   ),
             )),
            Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16,),
                        const Text(""),
                        const SizedBox(height: 8,),
                        ListPendingPlayers()
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // color: Colors.yellow,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 16,),
                        const Text("TEAM 1"),
                        ListStartingFive(itemCount: 4,),
                        // Spacer(),
                        const SizedBox(height: 8,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("DU BI TEAM 1"),
                            const SizedBox(height: 8,),
                            ListSubTeam(itemCount: 6)
                          ],
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}



