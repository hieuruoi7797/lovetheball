import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_mobile/constants/constant_values.dart';

class ListPendingPlayers extends StatelessWidget {
  const ListPendingPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      width: double.infinity,
      // height: MediaQuery.sizeOf(context).height * 0.56,
      child: CollapsedPendingTeam(),
    );
  }

}

class CollapsedPendingTeam extends StatelessWidget {
  const CollapsedPendingTeam({super.key});

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
        Container(
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
        )
      ],
    );
    // return Column(
    //   children: [  Container(
    //     width: 36,
    //     height: 36,
    //     decoration:BoxDecoration(
    //         borderRadius: BorderRadius.circular(6),
    //         color: Colors.blue,
    //         image: DecorationImage(
    //             image: AssetImage(
    //               "assets/png_images/default_avt.png",
    //             ),
    //             fit: BoxFit.cover
    //         )
    //     ),
    //   ),
    //     Container(
    //       // margin: const EdgeInsets.only(top: 7),
    //       child: Text(
    //         'Hoang Mai',
    //         style: TextStyle(
    //             fontSize: 15,
    //             fontWeight: FontWeight.w600
    //         ),),
    //     ),],
    // );
  }
}