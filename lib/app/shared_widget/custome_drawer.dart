import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/app/admin/screens/admin_home_screen.dart';
import 'package:task_manager/app/shared_widget/Dialogs/ask_awesome_dialog.dart';
import 'package:task_manager/app/shared_widget/change_pass_screen.dart';
import '../admin/screens/add_new_employee.dart';
import '../auth/controller/auth_controller.dart';
import '../employee/screens/done_tasks.dart';
import '../model/user_model.dart';

class CustomeDrawer extends StatefulWidget {
  @override
  State<CustomeDrawer> createState() => _CustomeDrawerState();
}

class _CustomeDrawerState extends State<CustomeDrawer> {
  AuthController _authController = Get.find<AuthController>();

  File? _imageFile;
  final picker = ImagePicker();
  String? _imageUrl;

  Future pickerImage() async {
    _imageFile = null;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile !=  null) {
      askAwesomeDialog().myDialog(
          context: context,
          dialogType: DialogType.question,
          titleText: 'Do you want to save this image?',
          btnOk: () {
            _imageFile = File(pickedFile.path);
            Get.back();
            _authController.uploadImageToFirebase(_imageFile);
            _imageFile = null;

          },
          btnCancel: () {
            Get.back();
            _imageFile = null;
          },
          autoDismiss: false);
      return;
    }else{
      Get.snackbar(
        'oops',
        "You didnt't choose the profile picture",
        snackPosition: SnackPosition.TOP,
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    //loginController.user!.name=userName;
    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              color: Colors.blueGrey.shade500,
              child: Padding(
                padding: EdgeInsets.only(top: 30.0, left: 8, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('Users')
                                    .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                                    .snapshots(),

                              builder: (context,  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: Container(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator()),
                                  );
                                }
                                  final myAccount = snapshot.data!.docs
                                    .map((e) => UserModel.fromJson(e.data()))
                                    .toList();
                                return CircleAvatar(
                                  child: ClipRRect(
                                    clipBehavior: Clip.antiAlias,
                                    borderRadius: BorderRadius.circular(35),
                                    child: FadeInImage.assetNetwork(
                                      image:
                                      '${myAccount[0].user_image}??""',
                                      imageCacheHeight: 90,
                                      imageCacheWidth: 90,
                                      fit: BoxFit.cover,
                                      placeholder: 'assets/images/person2.png',
                                      placeholderCacheHeight: 30,
                                      placeholderCacheWidth: 30,
                                      imageErrorBuilder: (a, b, c) =>
                                          Image.asset('assets/images/person2.png'
                                              ,width: 60,height: 60,fit: BoxFit.contain
                                          ),
                                    ),
                                  ),
                                  radius: 35,
                                  backgroundColor: Colors.white,
                                );
                              }
                            ),
                            IconButton(

                                icon:Icon(Icons.image, color: Colors.black54,),
                              onPressed: (){
                               //
                                 pickerImage();

                              },
                            ),
                          ],
                        ),
                        InkWell(
                            onTap: () async {
                              if (Get.isDarkMode) {
                                Get.changeThemeMode(ThemeMode.light);
                              } else {
                                Get.changeThemeMode(ThemeMode.dark);
                              }

                            },
                            child: Icon(
                              Icons.wb_sunny,
                              size: 30,
                            )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 8),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text('${_authController.user!.userName}',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.start),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                children: [
                  if (_authController.user!.userType == UserType.ADMIN)
                    ListTile(
                      title: Text(
                        'Add new Employee',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      onTap: () {
                        Get.to(() => AddNewEmployee());
                      },
                      leading: Icon(Icons.person_add),
                    ),
                  if (_authController.user!.userType == UserType.EMPLOYEE)
                    ListTile(
                      title: Text(
                        'Done tasks',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      onTap: () {
                        Get.to(() => DoneTasks());
                      },
                      leading: Icon(Icons.done_outline_rounded),
                    ),
                  /*if (_authController.user!.userType == UserType.ADMIN)
                    ListTile(
                      title: Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      onTap: () {
                       // Get.to(() => DoneTasks());
                      },
                      leading: Icon(Icons.notifications),
                    ),*/
                  ListTile(
                    title: Text(
                      'Change password',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    onTap: () {
                      Get.to(() => ChangePassScreen());
                    },
                    leading: Icon(Icons.password),
                  ),
                  ListTile(
                    title: Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    leading: Icon(Icons.logout),
                    onTap: () async {
                      askAwesomeDialog().myDialog(
                          context: context,
                          dialogType: DialogType.question,
                          titleText: 'Do you want to log out?',
                          btnOk: () {
                            _authController.logout();
                          },
                          btnCancel: () {
                            Get.back();
                          },
                          autoDismiss: false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLoadingDailog(BuildContext context) {
    final dialogformKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                content: SingleChildScrollView(
                  child: Form(
                    key: dialogformKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('هل تريد تسجيل الخروج؟'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  side: MaterialStateProperty.all(
                                      BorderSide(color: Colors.teal))),
                              child: Text('نعم',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.teal)),
                              onPressed: () {},
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  side: MaterialStateProperty.all(
                                      BorderSide(color: Colors.teal))),
                              child: Text('الغاء',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.teal)),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        ),
                        /* TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "تم",
                                style: TextStyle(fontSize: 22),
                              ))*/
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}
