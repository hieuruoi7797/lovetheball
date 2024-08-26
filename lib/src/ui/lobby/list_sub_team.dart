import 'package:flutter/material.dart';

class ListSubTeam extends StatelessWidget {
  int itemCount;

  ListSubTeam({super.key,required this.itemCount});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.sizeOf(context).height*0.08,
      // color: Colors.orange,
      child: Wrap(
        children:List.generate(itemCount,
            (index){
              return Container(
                margin: const EdgeInsets.only(right: 8),
                width: MediaQuery.sizeOf(context).height*0.07,
                height: MediaQuery.sizeOf(context).height*0.07,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6)
                ),
              );
            })
      ),
    );
  }

}

