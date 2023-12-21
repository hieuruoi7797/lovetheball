import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_record/constants/constant_values.dart';
import 'package:splat_record/constants/ui_styles.dart';
import 'package:splat_record/src/blocs/match/creating_match_bloc.dart';
import 'package:splat_record/src/models/match_model.dart';

class ListingMatchesScreen extends StatelessWidget {
  const ListingMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        // padding: EdgeInsets.zero,
        children: [
          matchesListTitle(context),
          StreamBuilder<List<MatchModel>>(
            stream: matchBloc.listMatchesPreview,
            builder: (context, snapshot) {
              if (snapshot.hasData){
                return ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    (snapshot.data![0].id != null) ?
                      MatchCard(context, match: snapshot.data![0]):
                      Container(),
                    MatchCard(context, match: snapshot.data![1])
                  ],
                );
              }else{
                return Text('API FAILED');
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
      margin: EdgeInsets.only(top: 50),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: SvgPicture.asset(LISTING_MATCHES_ICON),
          ),
          Text('Lịch sử trận đấu',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }

}

Widget MatchCard(BuildContext context, {required MatchModel match}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    margin: EdgeInsets.only(top: 20),
    height: 70,
    width: MediaQuery.sizeOf(context).width,
    decoration: BoxDecoration(
      color: Color(0xFFF1F1F1),
      borderRadius: BorderRadius.circular(10)
    ),
    child: Row(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: match.status != 0 ? color_main : Color(0xFFA0A0A0)
          ),
        ),
        SizedBox(width: 16,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Spacer(),
            Text(match.name ?? ERROR_UNKNOWN,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16
              ),),
            Spacer(),

            Text((match.status == 0)
                ?  match.createdAt ?? '' :"Đang diễn ra",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                color: Color(0xFFA0A0A0)
              ),),
            Spacer(),
          ],
        ),
      ],
    ),
  );
}