import 'package:article_app/models/person.dart';
import 'package:article_app/providers/category_provider.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:article_app/widgets/app_logo_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    _loadCategories();
    super.didChangeDependencies();
  }

  @override
  dispose(){
  // _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  _loadCategories() async{
    await Provider.of<CategoryProvider>(context).loadFromSharedPreference();
  }

  //check
  _isAlreadyLoggedIn(User user) async {
    await Future.delayed(Duration(seconds: 2));  //
    // could be
    return (user != null);
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    Provider.of<Person>(context);
    final Size size =  MediaQuery.of(context).size;

    _isAlreadyLoggedIn(_user).then((success) {
      if (success ) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      body: Visibility(
        visible: _user !=null,
        child: Container(
          color: Colors.white,
          height:size.height ,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLogoHeader(color: ThemeDetails.yellowColor),
              SizedBox(
                height: 20.0,
              ),
              SpinKitThreeBounce(
                size: 30.0,
                color: ThemeDetails.primaryColor,
              ),
            ],
          ),
        ),
        replacement: GettingStarted(),
      ),
    );
  }
}

class GettingStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size =  MediaQuery.of(context).size;
    return Container(
      child: Container(
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
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SafeArea(
                    child: Container(
                      height:size.height/2,
                      width: size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/bg_image.png'),
                              fit: BoxFit.fill
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text("Welcome to Molo Article",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text("Motivation can take you far, but it can take you even further if you first find your vision 🙂",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1, vertical: 10.0),
                    child: SizedBox(
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed('/login');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          color:  ThemeDetails.yellowColor,
                          child: Text("Get Started Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700
                            ),
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Application version 1.10.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 14.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  Padding(
                    padding: MediaQuery.of(context).viewInsets,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
