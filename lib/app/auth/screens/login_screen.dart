import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../components/custom_text_field.dart';
import '../controller/auth_controller.dart';


class LoginScreen extends StatefulWidget {


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController _authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();

  String? userName;
  String? password;
  int? empType;

  void login() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _authController.signIn(userName, password);
    }
  }
  bool secureText=false;
  //NotificationController notificationController = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    /*ScreenUtil.init(context,
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        orientation: Orientation.portrait);*/
    return Scaffold(
      //backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        //backgroundColor: Get.theme.primaryColor,
        elevation: 0,
        centerTitle: true,
        //Color.fromRGBO(200, 160, 50, 1),
        title: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(

                        margin:
                        EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                        child: Column(
                          children: [

                            CustomTextField(
                              title: "Email",
                              prefixIcon: Icon(Icons.person,color: Get.theme.primaryColor),
                              validate: (String? text) {
                                if (text!.trim().isEmpty) {
                                  return "Required";
                                }
                                if (text.isEmail==false) {
                                  return "خطأ في صيغة البريد الألكتروني";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              onSave: (String? val) {
                                userName = val!.trim();
                              },
                            ),
                            SizedBox(
                              //.h
                              height: 20,
                            ),
                            CustomTextField(
                              title: 'Password',
                              prefixIcon: Icon(Icons.password,color: Get.theme.primaryColor,),
                              keyboardType: TextInputType.visiblePassword,
                              validate: (String? text) {
                                if (text!.trim().isEmpty) {
                                  return "Required";
                                }
                                return null;
                              },
                              onSave: (String? text) {
                                password=text!.trim();
                              },
                              isPassword: true,

                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(60)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              height: MediaQuery.of(context).size.height * 0.057,
                              width:MediaQuery.of(context).size.width * 0.5,
                              child: GetBuilder<AuthController>(
                                builder: (controller) {
                                  return ElevatedButton(
                                      style: ButtonStyle(
                                         /* backgroundColor: MaterialStateProperty.all(
                                              Get.theme.primaryColor
                                          ),*/
                                         /* side: MaterialStateProperty.all(BorderSide(
                                              color: Get.theme.primaryColor)),*/
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10)))),
                                      onPressed: () {
                                        login();
                                      },
                                      child:
                                      Text(
                                        "Sign in",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                  );
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
