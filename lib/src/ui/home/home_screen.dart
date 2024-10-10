import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/src/blocs/home_bloc/home_bloc.dart';
import 'package:splat_mobile/src/blocs/match/match_bloc.dart';
import 'package:splat_mobile/src/resources/show_dialog.dart';
import 'package:splat_mobile/src/ui/home/nav_bar.dart';
import 'package:splat_mobile/src/ui/home/tap_home_page.dart';
import 'package:splat_mobile/widgets_common/rounded_image.dart';
import 'nav_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NavModel> items = [];
  int selectedTab = 0;
  final homeNavKey = GlobalKey<NavigatorState>();
  final homeScreenKey = GlobalKey();
  final buttonKey = GlobalKey();
  final searchNavKey = GlobalKey<NavigatorState>();
  final notificationNavKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    items = [
      NavModel(
        page: const TabHomePage(tab: 1),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const TabHomePage(tab: 2),
        navKey: searchNavKey,
      ),
    ];
    homeBloc.getUserSaved(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    matchBloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: homeBloc.popScopeBehavior,
      builder: (context, snapshot) {
        return PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async{
            if (homeBloc.canPop==true){
              return;
            }
            final bool shouldPop = await homeBloc.showBackDialog(context)??false;
            if(context.mounted && shouldPop){
              Navigator.pop(context);
            }
          },
          child: StreamBuilder<int>(
            stream: homeBloc.pageIndex,
            builder: (context,AsyncSnapshot<int> pageIndexSnap) {
              if ( pageIndexSnap.hasData){
                return Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  color: Colors.red,
                  child: Stack(
                    children: [
                      Scaffold(
                          key: homeScreenKey,
                          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                          floatingActionButton: Container(
                            key: buttonKey,
                            margin: const EdgeInsets.only(top: 10),
                            height: 64,
                            width: 64,
                            child: FloatingActionButton(
                              heroTag: "floating1",
                              backgroundColor: Color(0xFFF77C3C),
                              elevation: 0,
                              onPressed: () => homeBloc.openAddingPopup(renderKey: buttonKey),
                              shape: RoundedRectangleBorder(
                                // side: const BorderSide(width: 3, color: Colors.green),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(
                                Icons.add_rounded,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          bottomNavigationBar: NavBar(
                            pageIndex: selectedTab,
                            onTap: (index) {
                              if (index == selectedTab) {
                                items[index]
                                    .navKey
                                    .currentState
                                    ?.popUntil((route) => route.isFirst);
                              } else {
                                setState(() {
                                  selectedTab = index;
                                });
                              }
                            },
                          ),
                          body: items.elementAt(selectedTab).page),
                      StreamBuilder<bool>(
                          stream: homeBloc.openedAddingPopup,
                          builder: (context, showAddingPopup) {
                            if (showAddingPopup.data == true){
                              return BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 5.0, sigmaY: 5.0,
                                ),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  height: MediaQuery.sizeOf(context).height,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.6)
                                  ),
                                ),
                              );
                            }
                            else{
                              return SizedBox();
                            }
                          }
                      ),
                      StreamBuilder<bool>(
                          stream: homeBloc.openedAddingPopup,
                          builder: (context, showAddingPopup) {
                            if (showAddingPopup.data == true){
                              return Positioned(
                                left:homeBloc.fabOffset?.dx,
                                top: homeBloc.fabOffset?.dy,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 64,
                                  width: 64,
                                  child: FloatingActionButton(
                                    heroTag: "floating2",
                                    backgroundColor: const Color(0xFFF77C3C),
                                    elevation: 0,
                                    onPressed: () => homeBloc.openAddingPopup(renderKey: buttonKey),
                                    shape: RoundedRectangleBorder(
                                      // side: const BorderSide(width: 3, color: Colors.green),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Icon(
                                      Icons.add_rounded,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }else{
                              return SizedBox();
                            }
                        }
                      ),
                      StreamBuilder(
                          stream: homeBloc.openedAddingPopup,
                          builder: (context, showAddingPopup){
                              if (showAddingPopup.data == true){
                                return Positioned(
                                    // left:(homeBloc.fabOffset?.dx??0) - 93,
                                    // top:(homeBloc.fabOffset?.dy??0) - 284,
                                    left:(homeBloc.fabOffset?.dx??0) - 93,
                                    bottom: MediaQuery.sizeOf(context).height - (homeBloc.fabOffset?.dy??0),
                                    child: SizedBox(
                                      width: 250,
                                      child: ListView(
                                        reverse: true,
                                        shrinkWrap: true,
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              padding: EdgeInsets.only(left: 16,right: 16),
                                              width: 250,
                                              height: 84,
                                               decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16)
                                            ),
                                            child: Container(
                                              // margin: EdgeInsets.only(left: 16),
                                              child: Row(
                                                children: [
                                                  RoundedImage(width: 44, height: 44,),
                                                  SizedBox(width: 16,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Đấu nhanh",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        decoration: TextDecoration.none, // Underline decoration
                                                      ),),
                                                      SizedBox(height: 4,),
                                                      SizedBox(
                                                        width: 155,
                                                        child: Text("Tạo trận đấu ngay lập tức",
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 12,
                                                            color: Color(0xFF677986),
                                                            decoration: TextDecoration.none, // Underline decoration
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),),
                                            onTap: () => Navigator.pushNamed(context,Routes.SETTING_MATCH),
                                          ),
                                          // SizedBox(height: 16,),
                                          // Container(
                                          //   width: 250,
                                          //   height: 84,
                                          //    decoration: BoxDecoration(
                                          //   color: Colors.white,
                                          //   borderRadius: BorderRadius.circular(16)
                                          // ),),
                                          // SizedBox(height: 16,),
                                          // Container(
                                          //   width: 250,
                                          //   height: 84,
                                          //    decoration: BoxDecoration(
                                          //   color: Colors.white,
                                          //   borderRadius: BorderRadius.circular(16)
                                          // ),),
                                        ],
                                      ),
                                    ));
                              }else{
                                return SizedBox();
                              }
                          })
                    ],
                  ),
                );
              }else{
                return Container();
              }
              }
          ),
        );
      }
    );
  }
}

