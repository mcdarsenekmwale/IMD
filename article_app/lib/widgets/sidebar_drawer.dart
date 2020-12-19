import 'package:article_app/utils/theme_data.dart';
import 'package:article_app/widgets/app_logo_header.dart';
import 'package:article_app/widgets/sidebar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideBarDrawer extends StatelessWidget {
  final Function  onHideSideBar;

  const SideBarDrawer({
    Key key,
    @required this.onHideSideBar
  })
      : assert(onHideSideBar != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width =  MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      curve: Curves.ease,
      height: double.infinity,
      color: Colors.white,
      width: width*0.72,
      child: Column(
        children: [
          Container(
            //height: width*0.68,
            padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 60.0
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      ThemeDetails.primaryColor,
                      ThemeDetails.primaryColor,
                      ThemeDetails.secondaryColor,
                      ThemeDetails.secondaryColor
                    ],
                    stops: [0.1,0.47,0.48,0.8],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                )
            ),
            child: GestureDetector(
              onTap: null,
              child: Row(
                children: [
                  AppLogoHeader(color: Colors.white),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text('Molo Articles', 
                      style: TextStyle(
                          fontSize: 26.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFFFFF)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 15.0
            ),
            child: Column(
              children: [

                SideBarItem(
                  icon: "category.svg",
                  title: "Browse Categories",
                  isTouched: true,
                  onTap:(){
                    onHideSideBar();
                    Navigator.pushNamed(context, '/browse-category');
                  } ,
                ),
                SideBarItem(
                  icon: "profile.svg",
                  title: "Profile",
                  isTouched: true,
                  onTap:(){
                    onHideSideBar();
                    Navigator.pushNamed(context, '/profile');
                  } ,
                ),
                SideBarItem(
                  icon: "settings.svg",
                  title: "Settings",
                  isTouched: true,
                  onTap:(){
                    onHideSideBar();
                    Navigator.pushNamed(context, '/settings');
                  } ,
                ),
               SizedBox(
                 height: MediaQuery.of(context).size.width * 0.6,
               ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0
                  ),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                        onPressed: ()async {
                          await FirebaseAuth.instance.signOut();
                         Navigator.of(context).pushReplacementNamed('/login');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        color:  ThemeDetails.yellowColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text("Logout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}