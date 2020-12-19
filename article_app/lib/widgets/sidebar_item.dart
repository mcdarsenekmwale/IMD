import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideBarItem extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final String title;
  final bool isTouched;

  const SideBarItem({Key key,
    this.onTap,
    @required this.icon,
    @required this.title,
    @required this.isTouched
  })
      :  assert(icon != null),
        assert(title != null),
        assert(isTouched != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        curve: Curves.ease,
        decoration: BoxDecoration(
            color: isTouched
                ? Color(0xFF612c56).withOpacity(0.02)
                :Colors.transparent,
            boxShadow:isTouched? [
              BoxShadow(
                  spreadRadius: 2.0,
                  blurRadius: 1.0,
                  color: Color(0xFFffffff).withOpacity(0.01),
                  offset: Offset(0.0, 2.0)
              )
            ]:[],
            borderRadius: BorderRadius.circular(10.0)
        ),
        padding: EdgeInsets.all(2.0),
        margin: EdgeInsets.symmetric(
            vertical: 10.0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                "assets/icons/"+icon,
                color: Color(0xFF612c56),
                height: 22.0,
                matchTextDirection: true,
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(title,
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade900
              ),
            ),
          ],
        ),
      ),
    );
  }
}
