import 'package:article_app/utils/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppPasswordForm extends StatelessWidget  {

  final String title;
  final String value;
  final IconData icon;
  final Function onValidate;
  final Function onChange;
  final VoidCallback onTap;
  final bool visiblePassword;
  final TextEditingController textEditingController;
  final EdgeInsets margin;


  const AppPasswordForm({
    Key key,
    @required this.title,
    this.value,
    this.onTap,
    this.visiblePassword : false,
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
        cursorColor: Colors.black,
        obscureText: !visiblePassword,
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
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              visiblePassword?FontAwesomeIcons.solidEye:FontAwesomeIcons.solidEyeSlash,
              color: Colors.grey.shade600,
              size: 18.0,
            ),
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
