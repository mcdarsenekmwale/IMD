import 'package:article_app/utils/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadMoreArticle extends StatelessWidget {

  final VoidCallback onTap;
  final Function onPress;
  final bool readMore;

  const ReadMoreArticle({
    Key key,
    this.onTap,
    this.onPress,
   this.readMore : false
  }) :  assert(readMore != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Visibility(
      visible: !readMore,
      child: AnimatedOpacity(
        opacity: !readMore?1.0:0,
        duration: Duration(milliseconds: 400),
        curve: Curves.bounceOut,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width*0.072,//30.0,
            ),
            SizedBox(
              height: 62,
              width: size.width*0.8,
              child: FlatButton(
                onPressed: onPress,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                color:  Colors.white ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Read More",
                      style: TextStyle(
                          color: ThemeDetails.yellowColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded,
                      color: ThemeDetails.yellowColor,
                      size: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      replacement: AnimatedOpacity(
        opacity: readMore?1.0:0,
        duration: Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
        child: GestureDetector(
          onTap:onTap,
          child: Icon(FontAwesomeIcons.solidEyeSlash,
            color: Colors.white,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
