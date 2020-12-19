import 'dart:io';
import 'package:article_app/models/person.dart';
import 'package:article_app/services/person_collection.dart';
import 'package:article_app/utils/constants.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:article_app/widgets/auth/edit_profile_form_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditAccountPage extends StatefulWidget {
  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> with SingleTickerProviderStateMixin{

  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static TextEditingController _emailController ;
  static TextEditingController _nameController ;
  static TextEditingController _typeController ;
  static TextEditingController _aboutController ;
  File _image;
  Person _person;
  Person _newPerson;

  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _typeController = TextEditingController();
    _aboutController = TextEditingController();
    _newPerson = new Person();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _person = Provider.of<Person>(context)?? Person();
    super.didChangeDependencies();
  }

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
                                  Icons.clear,
                                  size: 34.0,
                                  color: Colors.white,
                                ),
                                onPressed: ()=>Navigator.pop(context)
                            ),
                            SizedBox(width: 4.0,),
                            Expanded(
                                child: Center(
                                  child: Text('Edit Profile',
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
                            IconButton(
                                icon: Icon(
                                  Icons.check,
                                  size: 34.0,
                                  color: ThemeDetails.yellowColor,
                                ),
                                onPressed: (){
                                  _updatePersonDetails(context);
                                }
                            ),
                            SizedBox(width: 4.0,),
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
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 50.0,
                            ),
                            SizedBox(
                              height: 140,
                              child: Stack(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center ,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(top: 1.0),
                                          height: 135.0,
                                          width: 130.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: ThemeDetails.yellowColor.withOpacity(0.5),
                                                  width: 3.0)
                                          ),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(130.0),
                                              child: (_image) != null?
                                              Image.file(_image, fit: BoxFit.cover,) :
                                              CachedNetworkImage(imageUrl: _person.avatar,
                                                  fit: BoxFit.cover,
                                                progressIndicatorBuilder: (context, image, value){
                                                    return CircularProgressIndicator(
                                                      value: value.progress,
                                                    );
                                                },
                                              )
                                          )
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                      bottom:20.0,
                                      right: 125.0,
                                      child: GestureDetector(
                                        onTap: ()async{
                                          File _file = await chooseFile(context, 'gallery');
                                          if(_file.existsSync())
                                            setState(() {
                                              _image = _file;
                                            });
                                        },
                                        child: CircleAvatar(
                                            maxRadius: 20.0,
                                            backgroundColor:Color(0xFFf6f6fc) ,
                                            child: Icon( Icons.photo_camera, color: ThemeDetails.sYellowColor,size: 30.0,)
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Form(
                              key:_formKey ,
                                child: Column(
                                  children: [
                                    EditProfileFormField(
                                        title: "Name",
                                        textEditingController: _nameController,
                                        icon: Icons.account_circle_outlined,
                                        keyBType: TextInputType.name,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.0,
                                            vertical: 10.0
                                        ),
                                        onValidate: (_v){
                                          return null;
                                        },
                                        onChange: (_val){
                                          setState(() {
                                            _newPerson.name = _val;
                                          });
                                        }
                                    ),
                                    EditProfileFormField(
                                        title: "Email",
                                        textEditingController: _emailController,
                                        icon: Icons.email_outlined,
                                        keyBType: TextInputType.emailAddress,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.0
                                        ),
                                        onValidate: (_v){
                                          return null;
                                        }  ,
                                        onChange: (_val){
                                          setState(() {
                                            _newPerson.email = _val;
                                          });
                                        }
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    EditProfileFormField(
                                        title: "Type",
                                        textEditingController: _typeController,
                                        icon: Icons.tag,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.0
                                        ),
                                        onValidate: (_v){
                                          return null;
                                        }  ,
                                        onChange: (_val){
                                          setState(() {
                                            _newPerson.type = _val;
                                          });
                                        }
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    EditProfileFormField(
                                        title: "About",
                                        textEditingController: _aboutController,
                                        height: (_aboutController.text.length * 1.2).ceilToDouble()<65
                                            ? 65.0
                                            : (_aboutController.text.length * 1.2).ceilToDouble() ,
                                        icon: Icons.info_outline_rounded,
                                        maxLine: 500,
                                        keyBType: TextInputType.multiline,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.0
                                        ),
                                        onValidate: (_v){
                                         return null;
                                        },
                                        onChange: (_val){
                                          setState(() {
                                            _newPerson.about = _val;
                                          });
                                        }
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
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _nameController.dispose();
    _typeController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _updatePersonDetails(BuildContext context) async{
    if(_formKey.currentState.validate()){
      loadingDialog(context: context);
     await _uploadImage();
      _personValidator();

      final response = await PersonCollection().updateUserData(_newPerson);
      if(response != null){
        Navigator.pop(context);
        Navigator.pop(context, {
          'person':_newPerson
        });
      }else {
        Navigator.pop(context);
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              backgroundColor: ThemeDetails.sYellowColor,
              content: Text("Failed to update user details",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins"
              ),
              ),
        ));

      }
    }
  }

  //person data validator
  _personValidator(){
     setState(() {
       _newPerson.uid =_newPerson.uid??_person.uid;
       _newPerson.name =_newPerson.name??_person.name;
       _newPerson.email =_newPerson.email??_person.email;
       _newPerson.type =_newPerson.type??_person.type;
       _newPerson.about =_newPerson.about??_person.about;
       _newPerson.avatar = _newPerson.avatar?? _person.avatar;
     });
  }

  //image upload
  _uploadImage() async{
   if( _image.existsSync()){
     String _imageLink;
     UploadTask task = await uploadFile(_image, 'user_profiles');
     if (task != null) {
       _imageLink = await downloadLink(task.snapshot.ref);
       setState(() {
         _newPerson.avatar = _imageLink;
       });
     }
   }
  }

}
