import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manager/app/shared_widget/Dialogs/error_awesome_dialog.dart';
import 'package:task_manager/app/shared_widget/Dialogs/ask_awesome_dialog.dart';

class NewTaskButtomSheet extends StatefulWidget {
  final Function addTask;
  NewTaskButtomSheet(this.addTask);
  @override
  _NewTaskButtomSheetState createState() => _NewTaskButtomSheetState();
}

class _NewTaskButtomSheetState extends State<NewTaskButtomSheet> {

   String title='', details = '';

  void _submitData() async{

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
        askAwesomeDialog().myDialog(
            context: context,
            dialogType: DialogType.question,
            titleText: 'Do you want to send the task?' ,
            btnOk: () {
              Get.back();
              widget.addTask(title, details);
              //Get.back();

            },
            btnCancel:(){
              Get.back();
            },
            autoDismiss: false
        );

    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    validator: (String? txt){
                      if(txt!.trim().isEmpty){
                        return 'يرجى ملء حقل العنوان';
                      }
                      return null;
                    },
                    onSaved: (String? txt){
                      title = txt!.trim();
                    },
                    style: TextStyle(
                        fontSize: 18
                    ),
                    decoration: InputDecoration(

                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'عنوان المهمة' ,
                        labelStyle: TextStyle(fontSize: 18),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(
                                color: Colors.blueGrey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    validator: (String? txt){
                      if(txt!.trim().isEmpty){
                        return 'يرجى ملء تفاصيل المهمة';
                      }
                      return null;
                    },
                    onSaved: (String? txt){
                      details = txt!.trim();
                    },
                    style: TextStyle(
                        fontSize: 18
                    ),
                    decoration: InputDecoration(

                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'تفاصيل المهمة' ,
                        labelStyle: TextStyle(fontSize: 18),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:  BorderSide(
                                color: Colors.blueGrey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),

                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    primary: Get.theme.primaryColor,
                  ),
                  child: //CircularProgressIndicator(color: Colors.white),
                  Text('Send task', style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: _submitData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
