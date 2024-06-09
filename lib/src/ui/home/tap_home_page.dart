import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splat_mobile/widgets_common/tag_info.dart';

import '../../../widgets_common/square_button.dart';

class TabHomePage extends StatelessWidget {
  final int tab;

  const TabHomePage({Key? key, required this.tab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Tab $tab')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                // opacity: 0.2,
                image: AssetImage(
                    'assets/png_images/image_home_bg.png',),
                alignment: Alignment.topCenter)),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 50),
                child: Row(
                  children: [
                    SquareButton(
                      iconAssetName: "assets/svg_pictures/menu.svg",
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

            ///Identified Info
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue
                    ),
                    child: Image( image: AssetImage(
                      "assets/png_images/default_avt.png"
                    ),),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Text("Nguyen Hoang",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                              ),),
                  ),
                  SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TagInfo(value: 17.toString(),label: "Trận đấu",),
                      TagInfo(value: 15.toString(),label: "Thành tích",),
                      TagInfo(value: 5.toString(),label: "MVP",),
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
                  flex: 1,
                  child: Container(
                    height: 117,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 117,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),

            ///Wining Percentage
            Container(
              padding: EdgeInsets.all(12),
              width: MediaQuery.sizeOf(context).width,
              // height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("TỈ LỆ THẮNG", style: TextStyle(fontWeight: FontWeight.w500),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("60%",style: TextStyle(fontSize: 34),),
                      Container(
                        height: 71,
                        width: 16,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100))
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
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