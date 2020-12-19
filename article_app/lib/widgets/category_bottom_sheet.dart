import 'package:article_app/models/category.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryBottomSheet extends StatelessWidget {

  final Category category;
  final bool selected;
  final bool active;
  final Function onSelected;

  const CategoryBottomSheet({
    Key key,
    @required this.category,
    @required this.selected,
    @required this.active,
    @required this.onSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)),
          color: Colors.white
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 8.0
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap:()=>Navigator.of(context).pop(),
                  child: Icon(
                    Icons.clear,
                    color: Colors.grey.shade700,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 20.0
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(category.image),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      )
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(category.name.toUpperCase(),
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: ThemeDetails.primaryColor
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Visibility(
                      visible:active,
                      child: Center(
                        child: Icon(
                          selected?FontAwesomeIcons.solidCheckCircle:FontAwesomeIcons.solidTimesCircle,
                          color: selected?ThemeDetails.yellowColor.withOpacity(0.5):ThemeDetails.primaryColor.withOpacity(0.5),
                          size: 65.0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 20.0
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(category.description,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey.shade800
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 10.0
            ),
            child: SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                  onPressed: onSelected,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  color:  ThemeDetails.primaryColor,
                  child: Text("${(selected?"Uns": "S")}"
                      +"elect Category",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500
                    ),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
