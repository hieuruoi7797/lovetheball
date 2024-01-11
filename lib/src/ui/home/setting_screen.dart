import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splat_record/src/blocs/home_bloc/home_bloc.dart';
import 'package:splat_record/src/blocs/match/match_bloc.dart';
import 'package:splat_record/src/models/player_model.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height* 0.4,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
            ),
            child: StreamBuilder<PlayerModel>(
              stream: homeBloc.userInfo,
              builder: (context, snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 125,
                      height: 125,
                      child: CircleAvatar(
                        // radius: 50,
                        backgroundImage: AssetImage('assets/png_images/avatar_temp.png'),
                      ),
                    ),
                  ],
                );
              }
            ),
          )
        ],
      ),
    );
  }

}