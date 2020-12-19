import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleDescriptionField extends StatelessWidget {

  final double width;
  final String title;
  final String value;
  final TextEditingController textEditingController;
  final Function onValidate;
  final Function onChange;
  final double radius;
  final Border border;

  const ArticleDescriptionField({
    Key key,
    this.width,
    @required this.title,
    this.value ,
    @required  this.textEditingController,
    this.onValidate,
    this.onChange,
    this.radius : 10.0,
    this.border
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: textEditingController.text.length<30
          ? 100
          : textEditingController.text.length.ceilToDouble(),
      constraints: BoxConstraints(
        maxHeight: 180.0,
      ),
      width: width?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: border,
          color: Color(0xFFF5F6fA)
      ),
      child: TextFormField(

        controller: textEditingController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.multiline,
        autofocus: false,
        maxLines: 500,
        style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 17.0
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0
          ),
          hintText: title,
          hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'
          ),
          hintMaxLines: 500,
          filled: false,
          border: InputBorder.none,
          errorStyle: TextStyle(
              color: Theme.of(context).primaryColor
          ),
        ),
        validator:(value) =>onValidate(value),
        onChanged: (value)=>onChange(value),
      ),
    );
  }
}
