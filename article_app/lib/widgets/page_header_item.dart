import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageHeaderItem extends StatelessWidget {
  final VoidCallback onTab;
  final bool isActive;
  final String title;
  final double size;

  const PageHeaderItem({
    Key key,
    @required this.onTab,
    @required this.isActive,
    @required this.title,
    this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTab ,
      child: Padding(
        padding: EdgeInsets.only(bottom:0.5,),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          curve: Curves.linear,
          height: 55.0,
          padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Text(title,
                style: TextStyle(
                  color: isActive
                      ?Colors.grey.shade600
                      : Colors.grey.shade500,
                  fontSize: 16.0,
                  fontFamily: 'Poppins',
                  fontWeight: isActive
                      ?FontWeight.w600
                      :FontWeight.w500,
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 150),
                curve: Curves.ease,
                height: 2.5,
                margin: EdgeInsets.only(top: 2.0),
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: isActive
                      ?Theme.of(context).primaryColor
                      : Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
