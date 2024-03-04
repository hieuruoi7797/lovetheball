import 'package:flutter/material.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';

import '../../../constants/ui_styles.dart';
import '../../../widgets_common/pop_up_builder.dart';

class PlayerCreatingScreen extends StatefulWidget {
  const PlayerCreatingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PlayerCreatorState();
}

class _PlayerCreatorState extends State<PlayerCreatingScreen> {
  TextEditingController playerNameController = TextEditingController();
  TextEditingController playerEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
              bottomSheet: BottomSheet(
                  onClosing: () => {},
                  enableDrag: false,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                      height:MediaQuery.viewInsetsOf(context).bottom == 0 ?
                      MediaQuery.of(context).size.height * 0.6 :
                      MediaQuery.of(context).size.height * 0.3,
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
                            "Nhập tên:",
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
                          const Text(
                            "Nhập email:",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF818181),
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 25, bottom: 25),
                            height: 36,
                            child: TextField(
                              controller: playerEmailController,
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
                          const Text(
                            "Nhập password:",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF818181),
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 25, bottom: 25),
                            height: 36,
                            child: TextField(
                              controller: passwordController,
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
                              onTap: () async {
                                if(playerNameController.text.isEmpty|| playerNameController ==null){
                                  await showDialog(context: context, builder: (context){
                                    return DialogBuilder.BaseDialogOneButton(title: 'Thông báo', content: "Không được để trống name", onCancel: (){Navigator.pop(context);});
                                  });
                                }
                                if(playerEmailController.text.isEmpty || playerEmailController == null){
                                  await showDialog(context: context, builder: (context){
                                    return DialogBuilder.BaseDialogOneButton(title: 'Thông báo', content: "Không được để trống email", onCancel: (){Navigator.pop(context);});
                                  });
                                }
                                if(playerEmailController.text.isNotEmpty && playerNameController.text.isNotEmpty&& passwordController.text.isNotEmpty){
                                  await showDialog(context: context, builder: (context){
                                    return DialogBuilder.BaseDialog(
                                        title: 'Thông báo',
                                        content: "Hãy kiểm tra kỹ thông tin đăng ký nhé!",
                                        onCancel: (){Navigator.pop(context);},
                                        onSuccess: (){
                                          authenticationBloc.createUser(
                                            name: playerNameController.text,
                                            email: playerEmailController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                    );
                                  });

                                }

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
              // child: Align(
              //   alignment: Alignment.topCenter,
              //   child: SizedBox(
              //     width: 200,
              //     height: 200,
              //       child: Container(
              //         color: Colors.blue,
              //           child: SvgPicture.asset(
              //               "assets/svg_pictures/SPLAT.svg",
              //           ))),
              // ),
              ));
  }
}
