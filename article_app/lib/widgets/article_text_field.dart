import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleTextField extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final String value;
  final bool readOnly;
  final Function onValidate;
  final Function onChange;
  final double radius;
  final Border border;

  const ArticleTextField({
    Key key, this.width,
    @required this.title,
    this.value,
    this.readOnly,
    @required this.onValidate,
    @required this.onChange,
    this.radius : 10.0,
    this.border,
    this.height : 55.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: 8.0
      ),
      width: width?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: border,
         color: Color(0xFFF5F6fA)
      ),
      alignment: Alignment.centerLeft,
      child: TextFormField(
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey.shade800,
        initialValue: value,
        style: TextStyle(
            color:Colors.grey.shade800,
            fontFamily: 'Poppins'
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: title,
          hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'),
          errorStyle: TextStyle(
              color: Theme.of(context).primaryColor
          ),
        ),
        validator: (value) =>onValidate(value),
        onChanged: (value)=>onChange(value),
      ),
    );
  }
}
