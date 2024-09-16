import 'package:flutter/material.dart';

class ListStartingFive extends StatelessWidget {
  int itemCount;
  bool expanded;
  bool rightToLeft;

  ListStartingFive({super.key, required this.itemCount, required this.expanded, required this.rightToLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.56,
      padding: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: (context, index){
            return Container(
              padding: const EdgeInsets.all(6),
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: expanded? const Color(0xffEFF5FF) : Colors.transparent,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Row(
                textDirection: rightToLeft ? TextDirection.rtl : TextDirection.ltr,
                // mainAxisAlignment: rightToLeft ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    width: MediaQuery.sizeOf(context).height * 0.1,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(6)
                    ),
                  ),
                  expanded?
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Nguoi choi 1")):
                  const SizedBox()
                ],
              ),
            );
      }),
    );
  }
}