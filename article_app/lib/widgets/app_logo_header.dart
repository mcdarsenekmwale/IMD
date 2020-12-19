import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppLogoHeader extends StatelessWidget {

  final Color color;

  const AppLogoHeader({
    Key key,
    @required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 75.0,
          width: 75.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/web_res.png'),
                  fit: BoxFit.cover
              ),
              border: Border.all(color: color.withOpacity(0.8), width: 2.0)
          ),
        ),
      ],
    );
  }
}
