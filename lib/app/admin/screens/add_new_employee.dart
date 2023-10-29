import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/shared_widget/Dialogs/error_awesome_dialog.dart';
import 'package:task_manager/app/shared_widget/Dialogs/ask_awesome_dialog.dart';

import '../../auth/components/custom_text_field.dart';
import '../controller/employee_controller.dart';

class AddNewEmployee extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  EmployeeController _employeeController = Get.put(EmployeeController());

  void save(BuildContext context) async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      askAwesomeDialog().myDialog(
          context: context,
          dialogType: DialogType.question,
          titleText: 'Do you want to send the task?' ,
          btnOk: () async{
            ///////////////////
            Get.back();
              _employeeController.addNewEmployee(userName!,userEmail!,phone!,password!,context);

            //////////////////////

          },
          btnCancel:(){
            Get.back();
          },
          autoDismiss: false
      );

    }
  }


  String? userName;
  String? userEmail;
  int? phone;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Get.theme.primaryColor,

      appBar: AppBar(
        //backgroundColor: Get.theme.primaryColor,
        title: Text('Add new employee'),
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
                        title: "Emp name",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(Icons.person,color: Get.theme.primaryColor),
                        validate: (String? text) {
                          if (text!.trim().isEmpty) {
                            return "required";
                          }
                          if (text.isNumericOnly==true) {
                            return "لايجب ان يكون أسم المستخدم ارقام فقط";
                          }
                          return null;
                        },
                        onSave: (String? val) {
                          userName = val!.trim();
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      CustomTextField(
                        title: "Email",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(Icons.person,color: Get.theme.primaryColor),
                        validate: (String? text) {
                          if (text!.trim().isEmpty) {
                            return "required";
                          }
                          if (text.isEmail==false) {
                            return "خطأ في صيغة البريد الألكتروني";
                          }
                          return null;
                        },
                        onSave: (String? val) {
                          userEmail = val!.trim();
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      CustomTextField(
                        title: "Phone number",
                        prefixIcon: Icon(Icons.phone_android,color: Get.theme.primaryColor,),

                        keyboardType: TextInputType.phone,
                        validate: (String? text) {
                          if (text!.trim().isEmpty) {
                            return "required";
                          }
                          //final pattern = r'^\d+$';
                          //final regExp = RegExp(pattern);
                          if (text.isNumericOnly== false) {
                            return "رقم غير صالح";
                          }
                          if (text.trim().length < 9) {
                            return "رقم الهاتف قصير";
                          }
                          if (text.trim().length > 9) {
                            return "رقم الهاتف طويل";
                          }
                          if (!text.trim().startsWith("7")) {
                            return "يجب ان يبدأ رقم الهاتف برقم 7";
                          }


                          return null;
                        },
                        onSave: (String? text) {
                          phone = int.parse(text!.trim());
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      CustomTextField(
                        title: 'Password ',
                        prefixIcon: Icon(Icons.password,color: Get.theme.primaryColor,),
                        validate: (String? text) {
                          if (text!.trim().isEmpty) {
                            return "Enter password ";
                          }
                          if (text.trim().length < 6) {
                            return "weak-password";
                          }
                          return null;
                        },
                        onSave: (String? text) {
                          password=text!.trim();
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
                              "Add",
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
