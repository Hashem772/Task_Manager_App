import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/shared_widget/Dialogs/error_awesome_dialog.dart';
import 'package:task_manager/app/shared_widget/Dialogs/ask_awesome_dialog.dart';

import '../auth/components/custom_text_field.dart';
import '../auth/controller/auth_controller.dart';

class ChangePassScreen extends StatelessWidget {
  @override
  final _formKey = GlobalKey<FormState>();
  AuthController _authController = Get.put(AuthController());

  void save(BuildContext context) async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final bool result = await InternetConnectionChecker().hasConnection;
      if(result)
      {
          askAwesomeDialog().myDialog(
              context: context,
              dialogType: DialogType.question,
              titleText: 'Do you want to save change?' ,
              btnOk: () {
                  _authController.changePassword(oldPassword: oldPassController.text , newPassword: newPassController.text);
                Get.back();
              },
              btnCancel:(){
                Get.back();
              },
              autoDismiss: false
          );
          return;
        }
      else{
        ErrorAwesomeDialog().myDialog(
            context: context,
            btnOk: (){

            }
        );

      }



      }


  }
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,

      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,
        title: Text('Change Password'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.035),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextField(
                        priceController: oldPassController,
                        title: "Old password",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(Icons.password,color: Get.theme.primaryColor,),
                        isPassword: true,
                        validate: (String? text) {
                          if (text!.trim().isEmpty) {
                            return "Ener old password";
                          }
                          return null;
                        },
                        onSave: (String? val) {
                          oldPassController.text = val!.trim();
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),

                      CustomTextField(
                        priceController: newPassController,
                        title: "New password",
                        prefixIcon: Icon(Icons.password,color: Get.theme.primaryColor,),
                        isPassword: true,
                        validate: (String? text) {
                          if (text!.trim().isEmpty) {
                            return "Ener new password";
                          }
                          return null;
                        },
                        onSave: (String? text) {
                          newPassController.text = text!.trim();
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      CustomTextField(
                        title: 'Confirm new password',
                        prefixIcon: Icon(Icons.password,color: Get.theme.primaryColor,),
                        priceController: confirmNewPassController,
                        validate: (String? text) {
                          if (text!.trim().isEmpty) {
                            return "Required";
                          }
                          if (newPassController.text.trim() != confirmNewPassController.text.trim()) {
                            return "No match";
                          }
                          return null;
                        },
                        onSave: (String? text) {
                          confirmNewPassController.text=text!.trim();
                        },
                        isPassword: true,

                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),



                      Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(60)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: MediaQuery.of(context).size.height * 0.057,
                        width:MediaQuery.of(context).size.width * 0.3,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Get.theme.primaryColor),
                                side: MaterialStateProperty.all(BorderSide(
                                    color: Get.theme.primaryColor)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10)))),
                            onPressed: () {
                              save(context);
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
