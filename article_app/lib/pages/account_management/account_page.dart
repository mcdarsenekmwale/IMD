import 'package:article_app/models/person.dart';
import 'package:article_app/services/person_collection.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:article_app/widgets/account_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with SingleTickerProviderStateMixin{

  static Person _person;

  @override
  void didChangeDependencies() {
    _initialLoader();
    super.didChangeDependencies();
  }

  _initialLoader() {
    PersonCollection().person.asBroadcastStream().listen((person) {
      setState(() {
        _person= person;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _person = _person??Provider.of<Person>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                            SizedBox(width: 4.0,),
                            Expanded(
                                child: Center(
                                  child: Text('My Account',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                      fontFamily: "Poppins",
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
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
                              height: 50.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 130.0,
                                  width: 130.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(_person.avatar),
                                          fit: BoxFit.cover
                                      ),
                                      border: Border.all(color: ThemeDetails.yellowColor.withOpacity(0.5), width: 2.0)
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 10.0
                              ),
                              child: Column(
                                children: [
                                  AccountCard(
                                      title: "Name",
                                      subtitle: _person.name
                                  ),
                                  AccountCard(
                                      title: "Email",
                                      subtitle: _person.email
                                  ),
                                  AccountCard(
                                      title: "Type",
                                      subtitle: _person.type
                                  ),
                                  AccountCard(
                                      title: "About",
                                      subtitle: _person.about,
                                      height: 100.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50.0,
                                        vertical: 30.0
                                    ),
                                    child: SizedBox(
                                      height: 55,
                                      width: MediaQuery.of(context).size.width,
                                      child: FlatButton(
                                          onPressed: (){
                                            Navigator.pushNamed(context, '/edit-profile');
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(60.0),
                                          ),
                                          color:  ThemeDetails.yellowColor,
                                          child: Text("Edit Profile",
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
                                ],
                              ),
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
