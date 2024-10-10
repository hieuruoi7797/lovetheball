import 'package:flutter/material.dart';

class ListSubTeam extends StatelessWidget {
  int itemCount;
  WrapAlignment? alignment;

  ListSubTeam({super.key,required this.itemCount, this.alignment});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: alignment ?? WrapAlignment.start,
      children:List.generate(itemCount,
          (index){
            return Container(
              margin: const EdgeInsets.only(right: 8, bottom: 8),
              width: MediaQuery.sizeOf(context).height*0.07,
              height: MediaQuery.sizeOf(context).height*0.07,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6)
              ),
            );
          })
    );
  }

}

