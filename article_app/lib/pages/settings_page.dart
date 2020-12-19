import 'package:article_app/widgets/settings_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:article_app/utils/theme_data.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isActive = false, _isActive1 = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        key: _scaffoldKey,
      backgroundColor: ThemeDetails.primaryColor,
      body: Column(
        children: [
          Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 5.0
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  size: 34.0,
                                  color: Colors.white,
                                ),
                                onPressed: ()=>Navigator.pop(context)
                            ),
                            Expanded(
                                child: Center(
                                  child: Text('Settings',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0,
                                      fontFamily: "Poppins",
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30.0)
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.0, left:20.0),
                              child: Row(
                                children: [
                                  Icon(Icons.sync_outlined,
                                    size: 24.0,
                                    color: ThemeDetails.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text('ACCOUNT', style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700,
                                    color: ThemeDetails.primaryColor,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            SettingsItem(
                                title: "Change password",
                            ),
                            SettingsItem(
                              title: "Language",
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.0, left:20.0),
                              child: Row(
                                children: [
                                  Icon(Icons.notifications_none,
                                    size: 24.0,
                                    color: ThemeDetails.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text('NOTIFICATIONS', style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700,
                                    color: ThemeDetails.primaryColor,
                                  ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            SettingsItem(
                              title: "Notifications",
                                isTouched: false,
                                isActive: _isActive,
                                valueChanged: (v){
                                  setState(() {
                                    _isActive = v;
                                  });
                              }
                            ),
                            SettingsItem(
                                title: "App Notifications",
                                isTouched: false,
                                isActive: _isActive1,
                                valueChanged: (v){
                                  setState(() {
                                    _isActive1 = v;
                                  });
                                }
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.0, left:20.0),
                              child: Row(
                                children: [
                                  Icon(Icons.widgets_outlined,
                                    size: 24.0,
                                    color: ThemeDetails.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text('MORE', style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700,
                                    color: ThemeDetails.primaryColor,
                                  ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            SettingsItem(
                              title: "Share with Friends",
                            ),
                            SettingsItem(
                              title: "Review",
                            ),
                            SettingsItem(
                              title: "Info",
                            )
                          ],
                        ),
                      )
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
