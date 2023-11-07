import 'package:flutter/material.dart';
import 'package:splat_record/src/blocs/player/player_creator_bloc.dart';

import '../../constants/ui_styles.dart';

class PlayerCreatorScreen extends StatefulWidget {
  const PlayerCreatorScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PlayerCreatorState();
}

class _PlayerCreatorState extends State<PlayerCreatorScreen> {
  TextEditingController playerNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playerBloc.changeStatus("landed");
  }

  @override
  void dispose() {
    playerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: playerBloc.status,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Scaffold(
              bottomSheet: BottomSheet(
                  onClosing: () => {},
                  enableDrag: false,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(
                        top: 35,
                        left: 40,
                        right: 40,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Nhập tên của bạn:",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF818181),
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 25, bottom: 25),
                            height: 36,
                            child: TextField(
                              controller: playerNameController,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                suffixIconConstraints: const BoxConstraints(
                                  maxWidth: 50,
                                  maxHeight: 50,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF1F1F1),
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                playerBloc.createPlayer(
                                    context: context,
                                    name: playerNameController.text);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.47,
                                height: 48,
                                decoration: BoxDecoration(
                                    color: color_main,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Center(
                                  child: Text(
                                    "Hoàn tất",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                            'assets/png_images/background_player_creator.png'),
                        alignment: Alignment.topCenter)),
              ));
        });
  }
}
