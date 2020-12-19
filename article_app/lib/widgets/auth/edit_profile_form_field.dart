import 'package:article_app/utils/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfileFormField extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Function onValidate;
  final Function onChange;
  final TextEditingController textEditingController;
  final EdgeInsets margin;
  final double radius;
  final double height;
  final int maxLine;
  final TextInputType keyBType;

  const EditProfileFormField({
    Key key,
    @required this.title,
    this.value,
    this.radius : 20.0,
    this.height: 64.0,
    this.keyBType : TextInputType.text,
    this.maxLine:1,
    @required this.icon,
    @required this.onValidate,
    @required this.onChange,
    @required this.textEditingController,
    this.margin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height,
      margin:margin??
          EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      constraints: BoxConstraints(
        maxHeight: 122.0,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Color(0xFFFFFFfF),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFf6f6fc),
              offset: Offset(2,3),
              spreadRadius: 6,
              blurRadius: 6,
            )
          ]
      ),
      child: TextFormField(
        initialValue: value,
        controller: textEditingController,
        cursorColor: Colors.black,
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
          color: Colors.grey.shade800,
        ),
        keyboardType: keyBType,
        maxLines: maxLine,
        decoration: InputDecoration(
          labelText: title,
          border: InputBorder.none,
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


