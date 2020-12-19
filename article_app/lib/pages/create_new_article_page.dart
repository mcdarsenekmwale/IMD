import 'dart:io';

import 'package:article_app/models/article.dart';
import 'package:article_app/models/person.dart';
import 'package:article_app/providers/articles_provider.dart';
import 'package:article_app/services/articles_collection.dart';
import 'package:article_app/utils/constants.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:article_app/widgets/article_description_field.dart';
import 'package:article_app/widgets/article_text_field.dart';
import 'package:article_app/widgets/article_upload_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateNewArticlePage extends StatefulWidget {
  @override
  _CreateNewArticlePageState createState() => _CreateNewArticlePageState();
}

class _CreateNewArticlePageState extends State<CreateNewArticlePage> with SingleTickerProviderStateMixin{

  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  ArticlesProvider provArticles;
  TextEditingController _editingController;
  List<File> images = [];

  //article variables
  Article _newArticle ;
  static Person   _person;

  @override
  void initState() {
    _newArticle = new Article();
    _person = new Person();
    _editingController = new TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    provArticles = Provider.of<ArticlesProvider>(context);
    _person = Provider.of<Person>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
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
                    child: Row(
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
                            child: Text('New Article',
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
                              Icons.stream,
                              size: 25.0,
                              color: Colors.grey.shade300,
                            ),
                            onPressed: (){

                            }
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10.0
                              ),
                              child: Form(
                                key: _formKey,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      ArticleTextField(
                                          title: 'Article Title ',
                                          onValidate:(_v) =>(_v.isEmpty)?'A title field cannot be left empty':null ,
                                          onChange: (_val){
                                            setState(() {
                                              _newArticle.title = _val;
                                            });
                                          },
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      ArticleTextField(
                                        title: 'Category',
                                        onValidate: (_v) =>(_v.isEmpty)?'A category field cannot be left empty':null ,
                                        onChange: (_val){
                                          setState(() {
                                            _newArticle.categories = _val;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      ArticleDescriptionField(
                                        textEditingController: _editingController,
                                        title: "Tell us more . . .",
                                        onValidate: (_v) =>(_v.isEmpty)?'Please some description':null ,
                                        onChange: (_val){
                                          setState(() {
                                            _newArticle.description = _val;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      ArticleUploadImage(
                                          onTap: () async{
                                            File _file = await chooseFile(context, 'gallery');
                                            if(_file.existsSync())
                                              setState(() {
                                                images.add(_file);
                                              });
                                          },
                                          onClear: (int v){
                                            setState(() {
                                              images.removeAt(v);
                                            });
                                          },
                                          images: images
                                      )
                                    ],
                                  )
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
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 18.0
        ),
        child: SizedBox(
          height: 56,
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
              onPressed: (){
                _createArticle(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
              color:  ThemeDetails.yellowColor,
              child: Text("Post Now",
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
    );
  }


  //
  void _createArticle(BuildContext context) async{
    if(_formKey.currentState.validate()){
      loadingDialog(context: context);
      _newArticle.author = _person;
      await _uploadImage();
      final Article response = await ArticlesCollection().createArticleData(_newArticle);
      if(response != null){
        setState(() {
          provArticles.insertToList(response);
        });
        Navigator.pop(context);
        Navigator.of(context).pop();
      }else {
        Navigator.pop(context);
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              backgroundColor: ThemeDetails.sYellowColor,
              content: Text("Failed to create an article, please check your details",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins"
                ),
              ),
            ));
      }
    }
  }

  //image upload
  _uploadImage() async{
    if( images.first.existsSync()){
      String _imageLink;
      UploadTask task = await uploadFile(images.first, 'article_photos');
      if (task != null) {
        _imageLink = await downloadLink(task.snapshot.ref);
        setState(() {
          _newArticle.image = _imageLink;
        });
      }
    }
  }
}
