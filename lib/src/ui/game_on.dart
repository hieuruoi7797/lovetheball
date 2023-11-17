import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_record/constants/ui_styles.dart';
import 'package:splat_record/src/blocs/match/game_on_bloc.dart';
import 'package:splat_record/widgets_common/container_common.dart';

import '../../constants/constant_values.dart';

class GameOnScreen extends StatelessWidget {
  const GameOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.25,
                      fit: BoxFit.cover,
                      image: AssetImage(PNG_BACKGROUND_HOME))
            ),
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    CommonContainer(
                      margin: const EdgeInsets.only(top: 32),
                      padding: const EdgeInsets.all(20),
                      parentContext: context, child:
                        Column(
                          children: [
                            Center(
                              child: Text("Game 1", style: title_black_color,),
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text("He'd have you all unravel at the"),
                                  decoration: BoxDecoration(
                                    color: Colors.teal[100],
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                ), Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text("He'd have you all unravel at the"),
                                  decoration: BoxDecoration(
                                    color: Colors.teal[100],
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                ), Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text("He'd have you all unravel at the"),
                                  decoration: BoxDecoration(
                                    color: Colors.teal[100],
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                ), Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text("He'd have you all unravel at the"),
                                  decoration: BoxDecoration(
                                    color: Colors.teal[100],
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                ), Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text("He'd have you all unravel at the"),
                                  decoration: BoxDecoration(
                                    color: Colors.teal[100],
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                ), Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text("He'd have you all unravel at the"),
                                  decoration: BoxDecoration(
                                    color: Colors.teal[100],
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ),
                    CommonContainer(parentContext: context,
                      margin: EdgeInsets.only(top: 32,
                          bottom: MediaQuery.sizeOf(context).height * 0.1),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Center(
                            child: Text("Pham Hieu", style: title_black_color,),
                          ),
                          StatInfoEdittingContainer(
                            context: context,
                            statType: "2-Pointer",
                            quantityStream: gameOnBloc.twoPointerQuantity,
                            onTapPlus: ()=> gameOnBloc.increase("2-Pointer"),
                            onTapSub: ()=> gameOnBloc.decrease("2-Pointer")
                          ),
                          StatInfoEdittingContainer(
                              context: context,
                              statType: "3-Pointer"
                          ),
                          StatInfoEdittingContainer(
                              context: context,
                              statType: "Assist"
                          ),
                          StatInfoEdittingContainer(
                              context: context,
                              statType: "Rebound"
                          ),
                          StatInfoEdittingContainer(
                              context: context,
                              statType: "Block"
                          ),
                          StatInfoEdittingContainer(
                              context: context,
                              statType: "Steal"
                          ),
                          StatInfoEdittingContainer(
                              context: context,
                              statType: "Personal Foul"
                          ),
                          StatInfoEdittingContainer(
                              context: context,
                              statType: "Turn-Over"
                          ),
                          StatInfoEdittingContainer(
                              context: context,
                              statType: "Dunk"
                          ),
                        ],
                      )
                    )
                  ],
                ),
              ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.1,
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      height: 48,
                      decoration: BoxDecoration(
                          color: color_main,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child:
                        Text("Kết thúc trận đấu", style: title_white_color),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}

