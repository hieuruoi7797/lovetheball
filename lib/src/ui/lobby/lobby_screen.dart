import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});


  @override
  State<StatefulWidget> createState() => _LobbyState();

}

class _LobbyState extends State<LobbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tran dau tuy chinh - 5v5"),
        backgroundColor: Colors.white,
        actions: [],
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Color(0xFFD8E5F3),
        child: Row(
          children: [
             Expanded(
               flex: 1,
                 child: Container(
                   padding: const EdgeInsets.all(16),
               color: Colors.yellow,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("TEAM 1"),
                       ListView.builder(
                          itemCount: 4,
                           shrinkWrap: true,
                           itemBuilder: (context, indext){
                            return Container(
                              width: double.infinity,
                            );
                           })
                     ],
                   ),
             )),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey,
                )),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.green,
                ))
          ],
        ),
      ),
    );
  }
}