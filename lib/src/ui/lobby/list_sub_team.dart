import 'package:flutter/material.dart';
import 'package:splat_mobile/src/blocs/lobby/lobby_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';

class ListSubTeam extends StatelessWidget {
  String subTeamKey;
  WrapAlignment? alignment;

  ListSubTeam({super.key,required this.subTeamKey, this.alignment});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PlayerModel>>(
      stream: subTeamKey == "SUB_1" ?
            lobbyBloc.getListSubOnePlayers :
            lobbyBloc.getListSubTwoPlayers,
      builder: (context, listSubStream) {
        if (listSubStream.hasData){
          return Wrap(
              alignment: alignment ?? WrapAlignment.start,
              children:List.generate(listSubStream.data!.length,
                      (index){
                    return StreamBuilder<PlayerModel?>(
                      stream: lobbyBloc.getAddingPlayer,
                      builder: (context, addingPlayerStream) {
                        if (addingPlayerStream.data != null && listSubStream.data![index].id == "000"){
                          return GestureDetector(
                            onTap: () => lobbyBloc.addToSubPlayersList(index,subTeamKey: subTeamKey),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8, bottom: 8),
                              width: MediaQuery.sizeOf(context).height*0.07,
                              height: MediaQuery.sizeOf(context).height*0.07,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: Icon(Icons.add,color: Colors.green,),
                            ),
                          );
                        }else{
                          return Container(
                            margin: const EdgeInsets.only(right: 8, bottom: 8),
                            width: MediaQuery.sizeOf(context).height*0.07,
                            height: MediaQuery.sizeOf(context).height*0.07,
                            decoration: BoxDecoration(
                                color: listSubStream.data![index].id == "000" ? Colors.grey : Colors.orange,
                                borderRadius: BorderRadius.circular(6)
                            ),
                          );
                        }

                      }
                    );
                  })
          );
        }else{
          return const SizedBox();
        }

      }
    );
  }

}

