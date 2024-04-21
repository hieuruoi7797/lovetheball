import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:splat_mobile/public/modal/modal_fit.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:splat_mobile/src/ui/authentication/authentication_screen.dart';
import 'package:splat_mobile/src/ui/authentication/modal_create_pass_ui.dart';

import '../../constants/ui_styles.dart';
import '../../src/ui/authentication/modal_input_otp.dart';
import '../../src/ui/authentication/modal_register_ui.dart';
class ModalTabView extends StatelessWidget {
  final int? index ;
  final Function()? onStepCancel;
  final Function()? onStepContinue;
  final Function(int)? onStepTapped;
  const ModalTabView({super.key,
     this.index,
    this.onStepCancel,
    this.onStepContinue,
    this.onStepTapped,
    });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return StreamBuilder<Object>(
      stream: authenticationBloc.currentStepBehavior,
      builder: (context, snapshot) {
        return ModalFit(
          title: "ĐĂNG KÝ",
          isShowBack: authenticationBloc.currentStep>0?true:false,
          onTapBack: ()=>authenticationBloc.onTapCancel(),
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: size.width,
                child: Theme(
                  data: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.orange,
                      onSurface: Colors.grey,
                      secondary: Colors.orangeAccent,
                      primary: Colors.orangeAccent
                    ),
                  ),
                  child: Stepper(
                    type: StepperType.horizontal,
                    currentStep: authenticationBloc.currentStep,
                    onStepCancel: ()=>authenticationBloc.onTapCancel(),
                    onStepContinue:()=> authenticationBloc.onTapContinue(context),
                    // onStepTapped: (step)=> authenticationBloc.onStepTapped(step),
                    connectorThickness:10,
                    controlsBuilder: (BuildContext context, ControlsDetails details) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            buttonGen1(
                              onTap: (){
                                authenticationBloc.onTapContinue(context);
                                authenticationBloc.setIconBack();

                              },
                              parentContext: context,
                              buttonName: "Tiếp tục",
                              height: 56,
                              width: size.width * 0.80,
                            ),
                            authenticationBloc.currentStep==1?
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child:  const Column(
                                children: [
                                  Text("Chưa nhận được email?",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:color_62737A,
                                        letterSpacing: -0.4,
                                        wordSpacing: -0.4
                                    ),),
                                    Text("Gửi lại mã",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color:Colors.black,
                                          letterSpacing: -0.4,
                                          wordSpacing: -0.4
                                      ),
                                    ),
                                ],
                              ),
                            ):Container(),
                          ],
                        ),
                      );
                    },
                    steps: [
                      Step(
                          title: Text(''),
                          content: TabRegisterAccount(context),
                          isActive: authenticationBloc.currentStep>=0,
                          state: authenticationBloc.currentStep>0?StepState.complete:StepState.indexed
                      ),
                      Step(
                          title: Text(''),
                          content: TabInputOtp(context),
                          isActive: authenticationBloc.currentStep>=1,
                          state: authenticationBloc.currentStep>1?StepState.complete:StepState.indexed
                      ),
                      Step(
                          title: Text(''),
                          content: TabRegisterPass(context),
                          isActive: authenticationBloc.currentStep>=2,
                          state: authenticationBloc.currentStep>2?StepState.complete:StepState.indexed
                      )
                    ],
                  ),
                )
              ),
            ],
          ),
        );
      }
    );
  }
}

// Widget ModalTabView(BuildContext context,
//      int index ,
//     Function()? onStepCancel,
//     Function()? onStepContinue,
//     Function(int)? onStepTapped
//   ){
//   return Scaffold(
//     body: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Container(
//           height: 10,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(
//               10,
//             ),
//             color: Colors.grey[200],
//           ),
//           child: Expanded(
//             child: Stepper(
//               type: StepperType.horizontal,
//               currentStep: index,
//               onStepCancel: onStepCancel,
//               onStepContinue: onStepContinue,
//               onStepTapped: onStepTapped,
//               steps: [
//                 Step(
//                     title: Text(''),
//                     content: TabRegisterAccount(context),
//                   isActive: index>=0,
//                   state: index>0?StepState.complete:StepState.indexed
//                 ),
//                 Step(
//                     title: Text(''),
//                     content: TabInputOtp(context),
//                     isActive: index >=1,
//                     state: index>1?StepState.complete:StepState.indexed
//                 )
//               ],
//             ),
//           ),
//           // child: TabBar(
//           //   indicator: BoxDecoration(
//           //     borderRadius: BorderRadius.circular(
//           //       10,
//           //     ),
//           //     color: Colors.pink,
//           //   ),
//           //   tabs: const [
//           //     Tab(text: "",),
//           //     Tab(text: "",),
//           //   ],
//           //   controller: _tabController,
//           //   indicatorSize: TabBarIndicatorSize.tab,
//           // ),
//         ),
//         // Expanded(
//         //     child: TabBarView(
//         //       children: [TabRegisterAccount(context),TabInputOtp(context)],
//         //       controller: _tabController,
//         //     )
//         // )
//       ],
//     ),
//   );
// }
