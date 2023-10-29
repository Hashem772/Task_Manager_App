import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final Function? validate;
  final Function? onSave;
  final TextEditingController? priceController;
  final int maxLine;
  final bool enabeld;
  final TextInputType? keyboardType ;
  final double? fontSize ;
  final Icon? prefixIcon ;
  final bool isPassword ;

  CustomTextField({this.title,
    this.keyboardType=TextInputType.text,this.validate,
    this.onSave,this.priceController,this.maxLine=1,
    this.enabeld=true,this.fontSize=20,this.prefixIcon=null,
    this.isPassword = false

  });
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? obscureText;
  @override
  void initState() {
    obscureText= widget.isPassword;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textAlign: TextAlign.center,
        enabled: widget.enabeld,
        maxLines: widget.maxLine,
        controller: widget.priceController,
        validator: widget.validate as String? Function(String?)?,
        onSaved: widget.onSave as void Function(String?)?,
        keyboardType: widget.keyboardType,
        obscureText: obscureText!,
        style: TextStyle(
            fontSize: 20,
            //color: Colors.red
        ),
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword?InkWell(
              onTap: (){
                setState(() {
                  obscureText=!obscureText!;
                });

              },
              child: Icon(
                obscureText!? Icons.visibility_off_outlined:Icons.visibility_rounded,
                color: obscureText!?Colors.black:Get.theme.primaryColor,


              ),
            ):null,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            fillColor: Colors.white,
            filled: true,
            labelText: widget.title ,

            //labelStyle: TextStyle(fontSize: 15),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(
                    color: Colors.brown)),
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
    );
  }
}
