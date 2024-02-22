import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splat_mobile/constants/ui_styles.dart';
import 'package:splat_mobile/src/blocs/overview_history_game/overview_history_game.dart';
import 'package:splat_mobile/widgets_common/user_name_card.dart';

import '../../../constants/constant_values.dart';
import '../../app.dart';

class OverviewHistoryScreen extends StatelessWidget {
  const OverviewHistoryScreen({super.key});
  static BuildContext get parentContext => navigatorKey.currentState!.context;

  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(parentContext).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Lịch sử trận đấu',style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),
      //   backgroundColor: Colors.white,
      //   leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed:()=>{Navigator.pop(context)},),
      // ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(parentContext).size.width,
            height: MediaQuery.of(parentContext).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 0.25,
                    fit: BoxFit.cover,
                    image: AssetImage(png_background_home))),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60,left: 20, right: 20, bottom: 20 ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:60,left: 20, right: 20, bottom: 25 ),
            child: Container(
              width: MediaQuery.of(parentContext).size.width,
              height: MediaQuery.of(parentContext).size.height,
              child: Column(
                verticalDirection: VerticalDirection.down,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_outlined)),
                          SizedBox(
                              width: MediaQuery.of(parentContext).size.width*0.7,
                              child: Text(
                                'Name Game',
                                style: title_black_color,
                                textAlign: TextAlign.center,
                              )
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                  ),
                  gap_2,
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: historyGame.listIconMatch.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child:Column(
                                    children: [
                                      SvgPicture.asset( historyGame.listIconMatch[index]),
                                      gap_2,
                                      const Text('1')
                                    ],
                                  )
                                ),
                          );
                        }
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: ListView.builder(
                        itemCount: 6,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return Container(
                              // width: MediaQuery.of(parentContext).size.width*0.5,
                              // height: MediaQuery.of(parentContext).size.height*0.5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                child: userNameCard(
                                    userName: 'xinh',
                                    parentContext: parentContext,
                                    onTapSuffix: ()=> historyGame.checkSelectToggle(index),
                                    suffixIcon: Icon(historyGame.selectToggle? Icons.expand_less:Icons.expand_more, color: Colors.black,)
                                ),
                              )
                          );
                        }
                    ),
                  ),
                  gap_24
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
class DetailPersonMatchHistory extends StatelessWidget {
  const DetailPersonMatchHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

