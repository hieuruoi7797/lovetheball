import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/src/blocs/lobby/lobby_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';

class ListPendingPlayers extends StatelessWidget {
  final bool expanded;
  final Function()? onTapExpanded;
  const ListPendingPlayers({super.key, required this.expanded, this.onTapExpanded});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:expanded?const EdgeInsets.all(0): const EdgeInsets.all(8),
      height: expanded ? MediaQuery.sizeOf(context).height * 0.5 :null,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
      ),
      width: double.infinity,
      // height: MediaQuery.sizeOf(context).height * 0.56,
      child: expanded ?
      StreamBuilder<List<PlayerModel>>(
        stream: lobbyBloc.getListPendingPlayers,
        builder: (context, listPendingNow) {
          if (listPendingNow.hasData){
            return ExpandedPendingTeam(
              onTapCollapse: onTapExpanded,
              listPendingPlayers: listPendingNow.data ?? [],
            );
          }else{
            return ExpandedPendingTeam(
                onTapCollapse: onTapExpanded,
                listPendingPlayers: []);
          }
        }
      ):
      CollapsedPendingTeam(onTapExpanded: onTapExpanded,),
    );
  }

}

class ExpandedPendingTeam extends StatelessWidget {
  ExpandedPendingTeam({super.key, this.onTapCollapse, required this.listPendingPlayers});
  Function()? onTapCollapse;
  List<PlayerModel> listPendingPlayers;



  List<Widget> loadPendingPlayer(List<PlayerModel> listPlayers){
    lobbyBloc.changeAddingEnable(null,"");
    List<Widget> listWidget = [];
    for ( PlayerModel item in listPlayers){
      listWidget.add(
        GestureDetector(
          onTap: () => lobbyBloc.changeAddingEnable(item,Constants.TEAM_PENDING),
          child: StreamBuilder<PlayerModel?>(
            stream: lobbyBloc.getAddingPlayer,
            builder: (context, snapshot){
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration:BoxDecoration(
                      color: ( snapshot.hasData && item.id == snapshot.data?.id) ? Colors.white : Colors.grey,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 4,),
                      Text(item.name)
                    ],
                  ),
                );
            }
          ),
        )
      );
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6
            ),
            decoration: const BoxDecoration(
                color:Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12))
            ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                        color: Color(0xFFE5601A).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6.22)
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color:Color(0xFFE5601A),
                      ),
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(svg_friends),
                  SizedBox(width: 8,),
                  Text("7"),
                  Text("/22"),
                  Spacer(),
                  GestureDetector(
                    onTap: onTapCollapse,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        // color: Color(0xFFE5601A).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6.22),
                          border: Border.all(
                              color: Color(0xFFD8E5F3)
                          )
                      ),
                      child: Icon(Icons.keyboard_arrow_up_outlined),
                    ),
                  )
                ],
              )
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            padding: EdgeInsets.all(16),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFEFF5FF),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                children: loadPendingPlayer(listPendingPlayers),
              ),
            ),
          ),
        )
      ],
    );
  }

}

class CollapsedPendingTeam extends StatelessWidget {
  CollapsedPendingTeam({super.key, this.onTapExpanded});
  Function()? onTapExpanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Color(0xFFE5601A).withOpacity(0.12),
            borderRadius: BorderRadius.circular(6.22)
          ),
          child: Center(
            child: Icon(
                Icons.add,
              color:Color(0xFFE5601A),
            ),
          ),
        ),
        Spacer(),
        SvgPicture.asset(svg_friends),
        SizedBox(width: 8,),
        Text("7"),
        Text("/22"),
        Spacer(),
        GestureDetector(
          onTap: onTapExpanded,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
                // color: Color(0xFFE5601A).withOpacity(0.12),
                borderRadius: BorderRadius.circular(6.22),
              border: Border.all(
                color: Color(0xFFD8E5F3)
              )
            ),
            child: Icon(Icons.keyboard_arrow_down_outlined),
          ),
        )
      ],
    );
  }
}