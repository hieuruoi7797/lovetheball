import 'dart:io';

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(
      //   // left: 16,
      //   // right: 16,
      //   // bottom: Platform.isAndroid ? 16 : 0,
      // ),
      child: BottomAppBar(
        color: Colors.white,
        shadowColor: Colors.grey,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                navItem(
                  Icons.home_filled,
                  itemName: "Home",
                  pageIndex == 0,
                  onTap: () => onTap(0),
                ),
                // navItem(
                //   Icons.message_outlined,
                //   pageIndex == 1,
                //   onTap: () => onTap(1),
                // ),
                const SizedBox(width: 80),
                navItem(
                  Icons.notifications_none_outlined,
                  pageIndex == 1,
                  onTap: () => onTap(1),
                  itemName: "Report",
                ),
                // navItem(
                //   Icons.person_outline,
                //   pageIndex == 3,
                //   onTap: () => onTap(3),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? onTap, String? itemName}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: selected ? Color(0xFFF77C3C) : Colors.grey,
            ),
            Text(itemName??"Home", style: TextStyle(color:selected ? Color(0xFFF77C3C) : Colors.grey ),)
          ],
        ),
      ),
    );
  }
}