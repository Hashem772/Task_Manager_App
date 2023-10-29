import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorAwesomeDialog{
  void myDialog({
    required BuildContext context,
    final DialogType dialogType = DialogType.error,
    final String? titleText ='No Internet connection !!',
    final String? descText ='',
    final Function? btnOk,
    final Function? btnCancel,
    final bool autoDismiss = true,
  }
      )
  {

    AwesomeDialog(
      dismissOnBackKeyPress: true,
      dismissOnTouchOutside: true,
      reverseBtnOrder: true,
      keyboardAware: false,
      headerAnimationLoop: false,
      context: context,
      dialogType: dialogType,
      alignment: Alignment.center,
      animType: AnimType.leftSlide,
      title: titleText,
      desc: descText,
      titleTextStyle: TextStyle(color: Get.theme.listTileTheme.textColor),
      onDismissCallback: (b)=> Get.back(),
      btnOkOnPress: btnOk as void Function()?,
      btnOkColor: Colors.blueGrey,
      autoHide: Duration(seconds: autoDismiss?2: 0),
      btnCancelOnPress: btnCancel as void Function()?,
      autoDismiss: autoDismiss,

    )..show();
  }
}
