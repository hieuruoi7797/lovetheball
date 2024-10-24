import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splat_mobile/public/modal/modal_fit.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:splat_mobile/src/resources/timer_counter_bloc.dart';
import 'package:splat_mobile/src/ui/authentication/modal_create_pass_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constants/ui_styles.dart';
import '../../src/ui/authentication/modal_input_otp.dart';
import '../../src/ui/authentication/modal_register_ui.dart';
import '../../widgets_common/button_gen1.dart';
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
    final localizations = AppLocalizations.of(context)!;
    return StreamBuilder<int>(
      stream: authenticationBloc.currentStepBehavior,
      builder: (context, snapshot) {
        return ModalFit(
          title: localizations.register.toUpperCase(),
          widgetUnderTitle: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16,right: 16,bottom: size.height*0.03),
            child: Text(
              "BƯỚC ${authenticationBloc.currentStep+1}/3",
              style: TextStyle(
                  color: Color(0xFF62737A)
              ),
              textAlign: TextAlign.center,
            ),
          ),
          isShowBack: authenticationBloc.currentStep>0?true:false,
          onTapBack: ()=>authenticationBloc.onTapCancel(context),
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.zero,
                child: Theme(
                  data: ThemeData(
                    // colorScheme: ColorScheme.fromSeed(
                    //   seedColor: Colors.orange,
                    //   onSurface: Colors.grey,
                    //   secondary: Colors.orangeAccent,
                    //   primary: Colors.orangeAccent
                    // ),
                  ),
                  child: Column(
                    children: [
                      ///Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16,bottom: size.height*0.03),
                            height: 8,
                            width: (snapshot.data == 0 || snapshot.data == null) ?
                                      MediaQuery.sizeOf(context).width * 0.3 :
                                    (snapshot.data == 1) ?
                                        MediaQuery.sizeOf(context).width * 0.6 :
                                          MediaQuery.sizeOf(context).width * 0.9
                            ,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: <Color>[
                                  Color(0xffE55807),
                                  Color(0xffFF8A4C),
                                ], // Gradient from https://learnui.design/tools/gradient-generator.html
                                tileMode: TileMode.mirror,
                              ),
                            ),
                          ),
                          // Spacer(),
                          // Container(
                          //   margin: EdgeInsets.only(left: 16,right: 16,bottom: size.height*0.03),
                          //   child: Text(
                          //     "${authenticationBloc.currentStep+1}/3",
                          //     style: TextStyle(
                          //       color: Color(0xFF62737A)
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                      ///Form by Step
                      (snapshot.data == 0 || snapshot.data == null) ?
                          TabRegisterAccount(context) :(snapshot.data == 1)?
                              TabInputOtp(context):
                                TabRegisterPass(context),
                      // SizedBox(height: 10,),
                      ///Next button
                      // authenticationBloc.showButtonContinue==true ?
                      // buttonGen1(
                      //   onTap: (){
                      //     authenticationBloc.onTapContinue(context);
                      //     authenticationBloc.setIconBack();
                      //   },
                      //   enableLoadingAnimation: true,
                      //   parentContext: context,
                      //   buttonName: localizations.btn_continue,
                      //   height: 56,
                      //   width: size.width * 0.80,
                      // )
                    ],
                  ),
                )
              ),
            ],
          ),
          buttonName: localizations.btn_continue,
          enableLoadingForMainButton: true,
          onClickButton: (){
            authenticationBloc.onTapContinue(context);
            authenticationBloc.setIconBack();
          },
          widgetUnderButton: snapshot.data == 1?Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child:  Row(
              children: [
                Container(
                  child: Text("Chưa nhận được email?",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color:color_62737A,
                        letterSpacing: -0.4,
                        wordSpacing: -0.4
                    ),),
                ),
                StreamBuilder<Object>(
                  stream: timerBloc.timerCounterBehavior,
                  builder: (context, snapshot) {
                    return 
                    timerBloc.secondCount==0
                    ?TextButton(
                      onPressed: (){authenticationBloc.resendPin(context);},
                      child: Text(
                      "Gửi lại mã",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color:color_313A3E,
                          letterSpacing: -0.4,
                          wordSpacing: -0.4),
                    ),)
                    :Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.01),
                      child: Row(
                        children: [
                          Text(
                            "Gửi lại mã",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color:color_313A3E.withOpacity(0.1),
                              letterSpacing: -0.4,
                              wordSpacing: -0.4),
                          ),
                          Text(
                            " (${timerBloc.secondCount}s)",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: color_B3BBC4,
                                letterSpacing: -0.4,
                                wordSpacing: -0.4),
                          ),
                        ],
                      ),
                    );
                  }
                )
              ],
            ),
          ):Container(),
        );
      }
    );
  }
}
