import 'package:article_app/utils/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget  {

  final String title;
  final String value;
  final IconData icon;
  final Function onValidate;
  final Function onChange;
  final TextEditingController textEditingController;
  final EdgeInsets margin;
  final TextInputType keyBoardType;

  const AppFormField({
    Key key,
    @required this.title,
    this.value,
    this.keyBoardType: TextInputType.text,
    @required this.textEditingController,
    @required this.icon,
    @required this.onValidate,
    @required this.onChange,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin:margin??
          EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: TextFormField(
        initialValue: value,
        controller: textEditingController,
        cursorColor: Colors.black,
        keyboardType: keyBoardType,
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
          color: Colors.grey.shade800,
        ),
        decoration: InputDecoration(
          labelText: title,
          prefixIcon: Icon(
            icon,
            color: ThemeDetails.primaryColor,
          ),
          labelStyle: TextStyle(
            fontSize: 15.0,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500,
          ),
        ),
        validator: (value)=>onValidate(value),
        onChanged: (value)=>onChange(value),
      ),
    );
  }
}
