import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: Color(0xFFE55807)),
        items: [
        BottomNavigationBarItem(icon: SvgPicture.asset("assets/svg_pictures/SETTING.svg"),label: ''),
        BottomNavigationBarItem(icon: SvgPicture.asset("assets/svg_pictures/BASKETBALL.svg"),label: ''),
        BottomNavigationBarItem(icon: SvgPicture.asset("assets/svg_pictures/CHART.svg"),label: ''),
      ],

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.25,
            fit: BoxFit.cover,
            image: AssetImage("assets/png_images/bg_home.png")
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20.0,
                          offset: Offset(
                            0,6
                          )
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin:EdgeInsets.only(top: 66),
                        child: Text("Hoang Mai",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.height * 0.12,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
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
            )
          ],
        ),
      ),
    );
  }
}