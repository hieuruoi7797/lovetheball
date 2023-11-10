import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_record/src/blocs/match/match_bloc.dart';
import 'package:splat_record/src/blocs/match/match_bloc_provider.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/widgets_common/loading.dart';
import 'package:splat_record/widgets_common/user_name_card.dart';
import '../../constants/constant_values.dart';
import '../../constants/ui_styles.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    matchBloc.getPlayerSavedName(context);
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

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: const IconThemeData(color: color_main),
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(SVG_SETTING_HOME), label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(SVG_BASKETBALL_HOME), label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(SVG_CHART_HOME), label: ''),
        ],
      ),
      body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.25,
                        fit: BoxFit.cover,
                        image: AssetImage(PNG_BACKGROUND_HOME))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            // height: MediaQuery.of(context).size.height * 0.25,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.15),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 20.0,
                                      offset: const Offset(0, 6))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StreamBuilder(
                                  stream: matchBloc.userName,
                                  builder: (context, snapshot) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 66),
                                      child: Text(snapshot.data??'Unknown',
                                          style: name_big_size),
                                    );
                                  }
                                ),
                                gap_default,
                                gap_default,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 48),
                                  margin: const EdgeInsets.only(bottom: 23),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Game đã chơi",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 16),
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: SvgPicture.asset(
                                                      "assets/svg_pictures/BASKETBALL_ORANGE.svg",
                                                    )),
                                                const Text(
                                                  "18",
                                                  style: TextStyle(
                                                      fontSize: 28,
                                                      color: Color(0xFF818181)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ), //Game da choi
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Thành tích",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 16),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 8),
                                                  child: SvgPicture.asset(
                                                    "assets/svg_pictures/TROPHY_ORANGE.svg",
                                                  ),
                                                ),
                                                const Text(
                                                  "37",
                                                  style: TextStyle(
                                                      fontSize: 28,
                                                      color: Color(0xFF818181)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ), //Thanh tich
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.height * 0.12,
                            height: MediaQuery.of(context).size.height * 0.12,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.10),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100)),
                            child: const Column(
                              children: [],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        // height: MediaQuery.of(context).size.height * 0.43,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20.0,
                                  offset: const Offset(0, 6))
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tên game",
                                style: title_white_color,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 36,
                                child: TextField(
                                  controller: nameController,
                                  style: typing_text,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    suffixIconConstraints: const BoxConstraints(
                                      maxWidth: 50,
                                      maxHeight: 50,
                                    ),
                                    suffixIcon: Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: SvgPicture.asset(
                                        "assets/svg_pictures/EDITING.svg",
                                        width: 17,
                                        height: 17,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF1F1F1),
                                  ),
                                ),
                              ),
                              gap_default,
                              const Text(
                                "Người chơi",
                                style: title_white_color,
                              ),
                              gap_default,
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: color_main,
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Center(
                                  child: Text("Thêm người chơi",
                                      style: title_main_color),
                                ),
                              ),
                              StreamBuilder<List<PlayerModel>>(
                                stream: matchBloc.playerList,
                                builder: (context, AsyncSnapshot<List<PlayerModel>> snapshot) {
                                  if (snapshot.hasData){
                                    return ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            UserNameCard(
                                              parentContext: context,
                                              userName: snapshot.data?[index].name,
                                            ),
                                            gap_default,
                                          ],
                                        );},
                                      shrinkWrap: true,);
                                  } else if (snapshot.hasError){
                                   return DialogWidget().showFailDialog(context, "PLAYERS GETTING FAIL");
                                  } else {
                                    return ListView(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        UserNameCard(
                                          parentContext: context,
                                          userName: "Pham Hieu",
                                        ),
                                        gap_default,
                                        UserNameCard(
                                          parentContext: context,
                                          userName: "Trung Kien",
                                        ),
                                      ],
                                    );
                                }

                                }
                              ),
                              gap_default,
                              GestureDetector(
                                onTap: () => matchBloc.createMatch(
                                    context: context,
                                    name: nameController.text,
                                    location: "ABCD",
                                    type: 0,
                                    players: ["1"]),
                                child: Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.47,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        color: color_main,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Center(
                                      child: Text("Tạo game",
                                          style: title_white_color),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      gap_default,
                    ],
                  ),
                ),
              )
    );
  }
}
