import 'package:flutter/material.dart';
import 'package:splat_mobile/src/blocs/lobby/lobby_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';

class ListStartingFive extends StatelessWidget {
  final List<PlayerModel> listStartingFive;
  final bool expanded;
  final bool rightToLeft;
  final String teamKey;

  const ListStartingFive({
    super.key,
    required this.listStartingFive,
    required this.expanded,
    required this.rightToLeft, required this.teamKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: rightToLeft ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8,),
        Text(teamKey),
        Container(
          height: MediaQuery.sizeOf(context).height * 0.56,
          padding: const EdgeInsets.only(top: 8),
          child: ListView.builder(
            shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index){
                return Container(
                  padding: const EdgeInsets.all(6),
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: expanded? const Color(0xffEFF5FF) : Colors.transparent,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child:  Row(
                    textDirection: rightToLeft ? TextDirection.rtl : TextDirection.ltr,
                    // mainAxisAlignment: rightToLeft ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      StreamBuilder<PlayerModel?>(
                        stream: lobbyBloc.getAddingPlayer,
                        builder: (context, snapshot) {
                          if (snapshot.data != null && listStartingFive[index].id == "000") {
                            return GestureDetector(
                              onTap: () => lobbyBloc.addToMainPlayersList(index, addingTeam: teamKey),
                              child: Container(
                                height: MediaQuery
                                    .sizeOf(context)
                                    .height * 0.1,
                                width: MediaQuery
                                    .sizeOf(context)
                                    .height * 0.1,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: const Icon(Icons.add,color: Colors.green,),
                              ),
                            );
                          }else {
                            return GestureDetector(
                              onTap: () => lobbyBloc.changeAddingEnable(
                                  listStartingFive[index],
                                  teamKey,
                                  disableExpandedPendingList: true),
                              child: Container(
                                height: MediaQuery
                                    .sizeOf(context)
                                    .height * 0.1,
                                width: MediaQuery
                                    .sizeOf(context)
                                    .height * 0.1,
                                decoration: BoxDecoration(
                                    color: listStartingFive[index].id == "000" ? Colors.grey : Colors.orange,
                                    borderRadius: BorderRadius.circular(6)
                                ),
                              ),
                            );
                          }

                        }
                      ),
                      expanded?
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: (index >= listStartingFive.length) ? Text("Nguoi choi 1") : Text(listStartingFive[index].name)):
                      const SizedBox(),
                      Spacer(),
                      StreamBuilder<PlayerModel?>(
                          stream: lobbyBloc.getAddingPlayer,
                          builder:  (context, snapshot) {
                                if (snapshot.data != null && listStartingFive[index].id == snapshot.data?.id) {
                                  return GestureDetector(
                                    onTap: () => lobbyBloc.movePlayerToPending(listStartingFive[index], teamKey),
                                    child: Container(
                                      height: MediaQuery
                                          .sizeOf(context)
                                          .height * 0.1,
                                      width: MediaQuery
                                          .sizeOf(context)
                                          .height * 0.1,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: const Icon(Icons.remove,color: Colors.red,),
                                    ),
                                  );
                                }else{
                                  return const SizedBox();
                                }
                          }
                      )
                    ],
                  ),
                );
          }),
        ),
      ],
    );
  }
}