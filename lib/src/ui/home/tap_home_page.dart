import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:splat_mobile/src/blocs/home_bloc/home_bloc.dart';
import 'package:splat_mobile/widgets_common/match_history_item.dart';
import 'package:splat_mobile/widgets_common/rounded_image.dart';
import 'package:splat_mobile/widgets_common/tag_info.dart';
import 'package:splat_mobile/widgets_common/win_rate.dart';

import '../../../public/app_global.dart';
import '../../../widgets_common/button_gen1.dart';
import '../../../widgets_common/square_button.dart';

class TabHomePage extends StatelessWidget {
  final int tab;

  const TabHomePage({Key? key, required this.tab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: appGlobal.updateAvatarBehavior,
      builder: (context, snapshot) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            // width: 100,
            decoration:BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    // opacity: 0.2,
                    image: AssetImage(
                        'assets/png_images/image_home_bg.png',),
                    alignment: Alignment.topCenter
                )
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap:()=>homeBloc.showBackDialog(context),
                          child: SquareButton(
                            iconAssetName: "assets/svg_pictures/menu.svg",
                          ),
                        ),
                        const Spacer(),
                        SquareButton(
                          iconAssetName: "assets/svg_pictures/calendar_noti.svg",
                        ),
                        const SizedBox(width: 16,),
                        SquareButton(
                          iconAssetName: "assets/svg_pictures/message_none.svg",
                        ),
                      ],
                    )),
                const SizedBox(height: 20,),
                ///Identifier Info
                Container(
                  width: 100,
                  padding: EdgeInsets.only(bottom: 16, top: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue,
                            image: homeBloc.nowUserInfo?.avatar!=''?DecorationImage(
                                image: FileImage(appGlobal.avatarFile),
                                fit: BoxFit.cover
                            ):DecorationImage(
                                image: AssetImage(
                                  "assets/png_images/default_avt.png",
                                ),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: Text(homeBloc.nowUserInfo?.name??'',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                  ),),
                      ),
                      SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TagInfo(value: 17.toString(),label: " Trận đấu",),
                          TagInfo(value: 15.toString(),label: " Thành tích",),
                          TagInfo(value: 5.toString(),label: " MVP",),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),

                ///TEAM Info, Rank Info
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 117,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                        ),
                        child: Column(
                          children: [
                            RoundedImage(),
                            const Text(
                              "HNOG",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF313A3E)),)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: Container(
                        height: 117,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white
                        ),
                        child: Column(
                          children: [
                            RoundedImage(
                              assetImage: "assets/png_images/rookie.png",
                              fit: BoxFit.none,
                            ),
                            const Text(
                              "Rookie",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF313A3E)),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),

                ///Wining Percentage
                Container(
                  padding: EdgeInsets.all(12),
                  // height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "TỶ LỆ THẮNG",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF62737A))),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 0), // Adjust the padding as needed
                              child: Text("60%",style: TextStyle(fontSize: 34,height: 0.77),)),
                          WinRate(percent: 60,),
                          WinRate(percent: 50,),
                          WinRate(percent: 30,),
                          WinRate(percent: 100,),
                          WinRate(percent: 20,),
                          WinRate(percent: 80,),
                          WinRate(percent: 70,color:Color(0xFF00C7BE),),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          Spacer(),
                          Icon(Icons.arrow_upward_rounded, color: Color(0xFF00C7BE),size: 14,weight: 10,),
                          Text("12% ",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,color: Color(0xFF00C7BE)),),
                          Text("So với tháng trước", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,color: Color(0xFFB3BBC4)),)
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),

                ///Scoring Percentage
                Container(
                  padding: EdgeInsets.all(12),
                  // height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("TỶ LỆ GHI ĐIỂM",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF62737A)),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 0), // Adjust the padding as needed
                              child: Text("25%",style: TextStyle(fontSize: 34,height: 0.77),)),
                          WinRate(percent: 60,),
                          WinRate(percent: 50,),
                          WinRate(percent: 30,),
                          WinRate(percent: 100,),
                          WinRate(percent: 20,),
                          WinRate(percent: 80,),
                          WinRate(percent: 70,color:Color(0xFFFF453A),),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          Spacer(),
                          Icon(Icons.arrow_downward_rounded, color: Color(0xFFFF453A),size: 14,weight: 10,),
                          Text("12% ",style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,color: Color(0xFFFF453A)),),
                          Text("So với tháng trước", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,color: Color(0xFFB3BBC4)),)
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),

                ///Match History
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      // height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LỊCH SỬ TRẬN ĐẤU",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF62737A)),),
                          SizedBox(height: 16,),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              MatchHistoryTypeItem(),
                              MatchHistoryTypeItem(
                                title: "Đấu giao hữu",
                                date: "12/02/2024",
                                tagValue: "THUA",
                                tagColor: const Color(0xFFFF3B30),
                              ),
                              MatchHistoryTypeItem(
                                title: "Đấu giao hữu #2",
                                date: "12/02/2024",
                                tagValue: "THẮNG",
                                tagColor: const Color(0xFF00C7BE),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F7FE),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "Xem tất cả",
                            style: TextStyle(
                              color:  Color(0xFF62737A),
                              fontSize: 15,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 17,
                            color: Color(0xFF62737A),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width *0.7,
                      child: ButtonGen1(
                        onTap: (){},
                        buttonName: "Chỉnh sửa trang cá nhân",
                        nameStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                        ),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                        ),
                        // enableLoadingAnimation: enableLoadingForMainButton,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
              ],
            ),
          );
      }
    );
  }
}

class Page extends StatelessWidget {
  final int tab;

  const Page({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Tab $tab')),
      body: Center(child: Text('Tab $tab')),
    );
  }
}


