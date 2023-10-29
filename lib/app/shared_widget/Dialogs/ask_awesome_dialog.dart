import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class askAwesomeDialog{
  myDialog({
    required BuildContext context,
    DialogType dialogType = DialogType.info,
    String? titleText,
    String? descText,
    Function? btnOk,
    Function? btnCancel ,
    bool autoDismiss = false,
  }
      )
  {

    AwesomeDialog(
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: true,
      //reverseBtnOrder: true,
      //useRootNavigator: true,
      //headerAnimationLoop: false,
      //autoDismiss: true,
      keyboardAware: false,
      context: context,
      dialogType: dialogType,
      alignment: Alignment.center,
      animType: AnimType.leftSlide,
      title: titleText,
      titleTextStyle: TextStyle(color: Get.theme.listTileTheme.textColor,fontSize: 20),

      desc: descText,
      onDismissCallback: (b)=> null,
      btnOkOnPress: btnOk as void Function()?,
      btnCancelOnPress: btnCancel as void Function()?,
     autoDismiss: autoDismiss,

    )..show();
  }
}

/*
AnimatedButton(
text: 'Dialog',
color: Colors.blueGrey,
isFixedHeight: true,
pressEvent: (){},
borderRadius: BorderRadius.circular(10),
width: 100,
height: 100,


),*/
