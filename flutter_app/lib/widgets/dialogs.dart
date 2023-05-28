import 'package:flutter/material.dart';

class DialogAlert {
  static void showLoading(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(8.0))),
          backgroundColor: Colors.transparent,
          content: LoadingIndicator(text: "Loading"),
        ));
  }

  static void dismissLoading(BuildContext context, {int? time}) {
    if (time != null) {
      Future.delayed(Duration(seconds: time), () {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key, this.text = ''}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [_getLoadingIndicator()],
      ),
    );
  }
}

Widget _getLoadingIndicator() {
  return Padding(
      child: SizedBox(
        child: CircularProgressIndicator(strokeWidth: 3),
        width: 40,
        height: 40,
      ),
      padding: EdgeInsets.only(bottom: 16));
}
