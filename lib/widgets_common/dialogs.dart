import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_record/constants/ui_styles.dart';
import 'package:splat_record/src/app.dart';
import 'package:splat_record/src/blocs/match/match_bloc.dart';
import 'package:splat_record/widgets_common/user_name_card.dart';

import '../constants/constant_values.dart';
import '../src/models/player_model.dart';

class DialogWidget {
  showLoaderDialog() {
    AlertDialog alert = AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              width: 50,
              color: Colors.transparent,
              child: CircularProgressIndicator(
                color: color_main,
                backgroundColor: color_loading_background,
              ),
            ),
          ],
        ));
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showFailDialog(BuildContext context, String massage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text(massage),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Disable'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Enable'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<String> showAddingPlayerBottom(BuildContext context) async{
    String result = '';
    showModalBottomSheet(
        enableDrag: false,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.sizeOf(context).height *0.7,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Stack(
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                ListView(
                  // shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: SvgPicture.asset("assets/svg_pictures/XICON.svg")),
                        const Spacer(),
                        const Text(
                          "Thêm người chơi",
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: const Center(
                                    child: Text(
                                  "Người chơi",
                                  style: normal_main_color,
                                )),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xFFDCDCDC),
                                ),
                                child: const Center(
                                    child: Text(
                                  "Đội bóng",
                                  style: normal_white_color,
                                )),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                StreamBuilder<List<PlayerModel>>(
                    stream: matchBloc.morePlayersList,
                    builder: (context,
                        AsyncSnapshot<List<PlayerModel>> snapshot) {
                      if (snapshot.hasData) {
                        matchBloc.playersListMore = snapshot.data!;
                        return Container(
                          margin: EdgeInsets.only(top:
                          MediaQuery.of(context).size.height * 0.15),
                          child: ListView.builder(
                              // physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: snapshot.data?.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 15),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    StreamBuilder<List<int>>(
                                      stream: matchBloc.listAdding,
                                      builder: (context, snapshotAddingIndexes) {
                                        if (snapshotAddingIndexes.hasData){
                                          return UserNameCard(
                                              parentContext: context,
                                              userName:
                                              snapshot.data?[index].name,
                                              suffixIcon: (snapshotAddingIndexes.data!.contains(index)) ? SvgPicture.asset(
                                                'assets/svg_pictures/TICK.svg',
                                                width: 14,
                                                height: 14,
                                                fit: BoxFit.none,
                                              ):SizedBox(),
                                              onTapSuffix: () =>
                                                  matchBloc.addPlayersTap(context, index,
                                                  changeStatus: (snapshotAddingIndexes.data!.contains(index)) ? false : true));
                                        }else {
                                          return SizedBox();
                                        }
                                      }
                                    ),
                                    gap_default,
                                  ],
                                );
                              }),
                        );
                      } else if (snapshot.hasError) {
                        return DialogWidget().showFailDialog(
                            context, "PLAYERS GETTING FAIL");
                      } else {
                        return ListView(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: const [],
                        );
                      }
                    }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                      border: Border.all(color: Colors.transparent),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.9),
                            Colors.white.withOpacity(0.8),
                            Colors.white.withOpacity(0.01),
                      ])
                    ),
                    child: GestureDetector(
                      onTap: () {
                        matchBloc.confirmAddPlayer(context);
                      },
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          // margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width * 0.47,
                          height: 48,
                          decoration: BoxDecoration(
                              color: color_main,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              "Xác nhận",
                              style: title_white_color,
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
        });
    return result;
  }

  Future<String> showMessageDialog(BuildContext context,
      {String? content}) async {
    String result = '';
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.9,
              // height: MediaQuery.of(context).size.height * 0.22,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset("assets/svg_pictures/XICON.svg")),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      content ?? ERROR_UNKNOWN,
                      textAlign: TextAlign.center,
                      style: title_black_color,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      result = "Y";
                      Navigator.pop(context,result);
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width * 0.47,
                        height: 48,
                        decoration: BoxDecoration(
                            color: color_main,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: Text(
                            "Xác nhận",
                            style: title_white_color,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
    return result;
  }

  Future<String> showResultDialog(BuildContext context,
      {required bool isSuccess, String? content}) async {
    String result = '';
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GestureDetector(
                  //     onTap: () => Navigator.pop(context),
                  //     child: SvgPicture.asset("assets/svg_pictures/XICON.svg")),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      content ?? ERROR_UNKNOWN,
                      textAlign: TextAlign.center,
                      style: name_big_size,
                    ),
                  ),
                  Center(
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child:
                            isSuccess ?
                            SvgPicture.asset("assets/svg_pictures/SUCCESS.svg"):
                            SvgPicture.asset("assets/svg_pictures/SUCCESS.svg"),
                    )),
                  // Spacer(),
                  GestureDetector(
                    onTap: () {
                      // result = "Y";
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.47,
                        height: 48,
                        decoration: BoxDecoration(
                            color: color_main,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: Text(
                            "Xác nhận",
                            style: title_white_color,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
    return result;
  }
}
