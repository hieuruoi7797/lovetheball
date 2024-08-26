import 'package:flutter/material.dart';

class ListPendingPlayers extends StatelessWidget {
  const ListPendingPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.56,
      child: ListView(
        children: [
            AvatarWithUserName()
        ],
      ),
    );
  }

}

class AvatarWithUserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [  Container(
        width: 36,
        height: 36,
        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.blue,
            image: DecorationImage(
                image: AssetImage(
                  "assets/png_images/default_avt.png",
                ),
                fit: BoxFit.cover
            )
        ),
      ),
        Container(
          // margin: const EdgeInsets.only(top: 7),
          child: Text(
            'Hoang Mai',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600
            ),),
        ),],
    );
  }
}