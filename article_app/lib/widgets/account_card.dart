import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {

  final String title;
  final String subtitle;
  final double radius;
  final Border border;
  final double height;

  const AccountCard({
    Key key,
    @required this.title,
    @required this.subtitle,
    this.radius : 30,
    this.height: 60.0,
    this.border
  }) : assert(title != null),
        assert(subtitle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 7.0
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0
      ),
      width: MediaQuery.of(context).size.width,
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
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
            style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(subtitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: Colors.grey.shade800,
                      fontFamily: "Poppins"
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
