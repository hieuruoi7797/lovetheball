import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_record/src/blocs/home_bloc/home_bloc.dart';
import 'package:splat_record/src/blocs/match/creating_match_bloc.dart';
import 'package:splat_record/src/ui/creating_match.dart';
import 'package:splat_record/src/ui/listing_matches.dart';
import '../../constants/constant_values.dart';
import '../../constants/ui_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    matchBloc.getPlayerSaved(context);
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

  static final List<Widget> _widgetOptions = <Widget>[
    const ListingMatchesScreen(),
    const CreatingMatchUI(),
    const ListingMatchesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: homeBloc.pageIndex,
      builder: (context,AsyncSnapshot<int> pageIndexSnap) {
        if ( pageIndexSnap.hasData){
          return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: pageIndexSnap.data ?? 1,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedIconTheme: const IconThemeData(color: color_main),
                onTap:(index) => homeBloc.onTabPageIndex(index),
                items: [
                  BottomNavigationBarItem(
                      icon: pageIndexSnap.data == 0 ?
                      SvgPicture.asset(SVG_SETTING_HOME) :
                      SvgPicture.asset(SVG_SETTING_HOME_DISABLE), label: ''),
                  BottomNavigationBarItem(
                      icon:  pageIndexSnap.data == 1 ?
                      SvgPicture.asset(SVG_BASKETBALL_HOME) :
                      SvgPicture.asset(SVG_BASKETBALL_HOME_DISABLE), label: ''),
                  BottomNavigationBarItem(
                      icon:  pageIndexSnap.data == 2 ?
                      SvgPicture.asset(SVG_CHART_HOME) :
                      SvgPicture.asset(SVG_CHART_HOME_DISABLE), label: ''),
                ],
              ),
              body: _widgetOptions.elementAt(pageIndexSnap.data ?? 1));
        }else{
          return Container();
        }
        }
    );
  }
}
