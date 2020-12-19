import 'package:article_app/models/person.dart';
import 'package:article_app/services/authentication.dart';
import 'package:article_app/utils/constants.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:article_app/widgets/app_logo_header.dart';
import 'package:article_app/widgets/auth/app_form_field.dart';
import 'package:article_app/widgets/auth/app_password_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  with SingleTickerProviderStateMixin{

  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static TextEditingController _emailController ;
  static TextEditingController _passwordController ;
  bool _visiblePassword = false;

  //user object
  //user object
  Person _newPerson;
  @override
  void initState() {
    _newPerson = new Person();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: ThemeDetails.primaryColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
          children: [
            Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width * 0.2,
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
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      AppLogoHeader(color: ThemeDetails.yellowColor),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text('Sign In',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w800,
                                            color: ThemeDetails.primaryColor
                                        ),
                                      ),
                                      Text('Please sign in to continue using the app',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            color: ThemeDetails.sYellowColor
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 45.0,
                              ),
                              Form(
                                key: _formKey,
                                  child: Column(
                                    children: [
                                      AppFormField(
                                          title: "Email",
                                          textEditingController: _emailController,
                                          icon: Icons.email_outlined,
                                          keyBoardType: TextInputType.emailAddress,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 20.0
                                          ),
                                          onValidate: (_v) =>(_v.isEmpty)?'Please enter your email ':null  ,
                                          onChange: (_val){
                                            setState(() {
                                              _newPerson.email = _val;
                                            });
                                          }
                                      ),
                                      AppPasswordForm(
                                          title: "Password",
                                          textEditingController: _passwordController,
                                          icon: Icons.lock_outlined,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20.0
                                          ),
                                          visiblePassword: _visiblePassword,
                                          onTap: (){
                                            setState(() {
                                              _visiblePassword = !_visiblePassword;
                                            });
                                          },
                                          onValidate: (_v) =>(_v.isEmpty)?'Please enter your password ':null,
                                          onChange: (_val){
                                            setState(() {
                                              _newPerson.password = _val;
                                            });
                                          }
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      TextButton(
                                          onPressed: (){
                                          },
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                                color: ThemeDetails.yellowColor,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins'
                                            ),
                                          )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 50.0,
                                          vertical: 20.0
                                        ),
                                        child: SizedBox(
                                          height: 56,
                                          width: MediaQuery.of(context).size.width,
                                          child: FlatButton(
                                              onPressed: (){
                                                _loginUser(context);
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(60.0),
                                              ),
                                              color:  ThemeDetails.yellowColor,
                                              child: Text("Sign In",
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
                                        height: size.width*0.2,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pushReplacementNamed(context, '/create-account');
                                        },
                                        child: RichText(text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: "Don't have an Acount?",
                                                  style: TextStyle(
                                                    color: ThemeDetails.primaryColor,
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Poppins',
                                                  )
                                              ),
                                              TextSpan(
                                                  text: "  Sign Up",
                                                  style: TextStyle(
                                                    color: ThemeDetails.primaryColor,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins',
                                                  )
                                              ),
                                            ]
                                        )),
                                      ),
                                    ],
                                  )
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
      ),
    );
  }

  //login
  void _loginUser(BuildContext context) async{
    try {
      if (_formKey.currentState.validate()) {
        loadingDialog(context: context);
        final response = await Authentication().signInWithEmailAndPassword(_newPerson);
        if(response['Response'] == RESPONSES.SUCCESSFULLY_LOGIN){
          Navigator.popAndPushNamed(context, '/');
        }else {
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(response['data']),
          ));
        }
      }
    }
    catch(e){
      throw Exception(e);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

}
