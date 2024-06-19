import 'package:flutter/material.dart';
import 'package:splat_mobile/src/blocs/home_bloc/home_bloc.dart';
import 'package:splat_mobile/src/blocs/match/match_bloc.dart';
import 'package:splat_mobile/src/ui/home/nav_bar.dart';
import 'package:splat_mobile/src/ui/home/tap_home_page.dart';
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
    // homeBloc.getUserSaved(context).then((value) =>  matchBloc.getPlayerList(context));
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
    return StreamBuilder<int>(
      stream: homeBloc.pageIndex,
      builder: (context,AsyncSnapshot<int> pageIndexSnap) {
        if ( pageIndexSnap.hasData){
          return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                margin: const EdgeInsets.only(top: 10),
                height: 64,
                width: 64,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFFF77C3C),
                  elevation: 0,
                  onPressed: () => debugPrint("Add Button pressed"),
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
              body: items.elementAt(selectedTab).page);
        }else{
          return Container();
        }
        }
    );
  }
}

