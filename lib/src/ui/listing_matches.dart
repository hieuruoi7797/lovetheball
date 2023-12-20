import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_record/constants/constant_values.dart';

class ListingMatchesScreen extends StatelessWidget {
  const ListingMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          matchesListTitle(context),
          Column(

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