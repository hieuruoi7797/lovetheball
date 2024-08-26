import 'package:flutter/material.dart';

class ListStartingFive extends StatelessWidget {
  int itemCount;

  ListStartingFive({super.key, required this.itemCount});

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
              height: MediaQuery.sizeOf(context).height * 0.1,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xffEFF5FF),
                borderRadius: BorderRadius.circular(6)
              ),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.065,
                    width: MediaQuery.sizeOf(context).height * 0.065,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(6)
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text("Nguoi choi 1"))
                ],
              ),
            );
      }),
    );
  }
}