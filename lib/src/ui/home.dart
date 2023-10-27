import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_record/widgets_common/user_name_card.dart';
import '../../constants/ui_styles.dart';
import '../blocs/match_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.changeStatus("preparing");
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: color_main),
        items: [
        BottomNavigationBarItem(icon: SvgPicture.asset("assets/svg_pictures/SETTING.svg"),label: ''),
        BottomNavigationBarItem(icon: SvgPicture.asset("assets/svg_pictures/BASKETBALL.svg"),label: ''),
        BottomNavigationBarItem(icon: SvgPicture.asset("assets/svg_pictures/CHART.svg"),label: ''),
      ],

      ),
      body: StreamBuilder(
        stream: bloc.status,
        builder: (context, AsyncSnapshot<String> snapshot) {
          // bloc.changeStatus("preparing");
          if (snapshot.data == "preparing") {
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.25,
                      fit: BoxFit.cover,
                      image: AssetImage("assets/png_images/bg_home.png")
                  )
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.9,
                          // height: MediaQuery.of(context).size.height * 0.25,
                          margin: EdgeInsets.only(top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.15),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20.0,
                                    offset: Offset(
                                        0, 6
                                    )
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 66),
                                child: Text("Hoang Mai",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                              gap_default,
                              gap_default,
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 48),
                                margin: EdgeInsets.only(bottom: 23),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text("Game đã chơi", style: TextStyle(
                                            color: Colors.grey, fontSize: 12),),
                                        Container(
                                          margin: EdgeInsets.only(top: 16),
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 8),
                                                  child: SvgPicture.asset(
                                                    "assets/svg_pictures/BASKETBALL_ORANGE.svg",)),
                                              Text("18", style: TextStyle(
                                                  fontSize: 28,
                                                  color: Color(0xFF818181)
                                              ),)
                                            ],
                                          ),
                                        )
                                      ],
                                    ), //Game da choi
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text("Thành tích", style: TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                        Container(
                                          margin: EdgeInsets.only(top: 16),
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 8),
                                                child: SvgPicture.asset(
                                                  "assets/svg_pictures/TROPHY_ORANGE.svg",
                                                ),
                                              ),
                                              Text("37", style: TextStyle(
                                                  fontSize: 28,
                                                  color: Color(0xFF818181)
                                              ),)
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .height * 0.12,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.12,
                          margin: EdgeInsets.only(top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Column(
                            children: [
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      // height: MediaQuery.of(context).size.height * 0.43,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20.0,
                                offset: Offset(
                                    0, 6
                                )
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tên game",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              ),),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 36,
                              child: TextField(
                                controller: nameController,
                                style: TextStyle(
                                    fontSize: 14
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  suffixIconConstraints: BoxConstraints(
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
                            Text("Người chơi",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              ),),
                            gap_default,
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 48,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: color_main,
                                  ),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: Center(
                                child: Text(
                                  "Thêm người chơi",
                                  style: TextStyle(
                                      color: color_main,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            ),
                            ListView(
                              padding: EdgeInsets.symmetric(vertical:16),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                UserNameCard(
                                    parentContext: context,
                                    userName: "Pham Hieu",),
                                gap_default,
                                UserNameCard(
                                  parentContext: context,
                                  userName: "Trung Kien",),
                              ],
                            ),
                            gap_default,
                            GestureDetector(
                              onTap: () => bloc.createMatch(
                                  name: nameController.text,
                                  location: "ABCD",
                                  type: 1,
                                  players: ["players"]),
                              child: Center(
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.47,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: color_main,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Tạo game",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
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
            );
          } else {
            return SizedBox();
          }
        }
      ),
    );
  }
}