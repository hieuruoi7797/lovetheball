import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/src/blocs/match/match_bloc.dart';
import 'package:splat_mobile/src/blocs/overview_history_game/overview_history_game.dart';
import 'package:splat_mobile/src/models/match_model.dart';


class ListingMatchesScreen extends StatelessWidget {
  const ListingMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        // padding: EdgeInsets.zero,
        children: [
          matchesListTitle(context),
          StreamBuilder<List<MatchModel>>(
            stream: matchBloc.listMatchesPreview,
            builder: (context, AsyncSnapshot<List<MatchModel>> snapshot) {
              if (snapshot.hasData){
                if (snapshot.data!.isNotEmpty){
                  return ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      (snapshot.data![0].id != null) ?
                      matchCard(context, match: snapshot.data![0]):
                      Container(),
                      matchCard(context, match: snapshot.data![1])
                    ],
                  );
                }else{
                  return Container();
                }

              }else{
                return Container();
              }
            }
          )
        ],
      ),
    );
  }

  Widget matchesListTitle(BuildContext context) {
    return Container(
      height: 30,
      margin: const EdgeInsets.only(top: 50),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(svg_matches_list),
          ),
          const Text('Lịch sử trận đấu',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }

}

Widget matchCard(BuildContext context, {required MatchModel match}) {
  return GestureDetector(
    onTap: () => historyGame.goToDetail(),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 20),
      height: 70,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: match.status != 1 ? color_main : const Color(0xFFA0A0A0)
            ),
          ),
          const SizedBox(width: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Spacer(),
              Text(match.name ?? error_unknown,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),),
              const Spacer(),

              Text((match.status == 1)
                  ?  match.createdAt ?? '' :"Đang diễn ra",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  color: Color(0xFFA0A0A0)
                ),),
              const Spacer(),
            ],
          ),
        ],
      ),
    ),
  );
}