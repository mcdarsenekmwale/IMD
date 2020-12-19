import 'package:article_app/models/article.dart';
import 'package:article_app/models/person.dart';
import 'package:article_app/providers/articles_provider.dart';
import 'package:article_app/services/articles_collection.dart';
import 'package:article_app/utils/constants.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'article_description_field.dart';
import 'article_text_field.dart';

class EditArticleBottomSheet extends StatefulWidget {
  final Article article;

  const EditArticleBottomSheet({
    Key key,
    @required this.article
  }) : super(key: key);

  @override
  _EditArticleBottomSheetState createState() => _EditArticleBottomSheetState();
}

class _EditArticleBottomSheetState extends State<EditArticleBottomSheet> {

  TextEditingController _editingController;
  ArticlesProvider _articlesProvider;
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  //article variables
  Article _newArticle ;
  Article _oldArticle ;
  static Person   _person;

  @override
  void initState() {
    _newArticle = new Article();
    _oldArticle = widget.article;
    _editingController = new TextEditingController(text: _oldArticle.description);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _person = Provider.of<Person>(context);
    _articlesProvider =  Provider.of<ArticlesProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height * 0.75,
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
                vertical: 12.0,
                horizontal: 8.0
            ),
            child:  Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5.0,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0
                    ),
                    child: Visibility(
                      visible: _checkIfDeletable(_person),
                      child: InkWell(
                        child: Icon(Icons.delete_outline_rounded,
                          color: ThemeDetails.yellowColor,
                          size: 20.0,
                        ),
                        onTap: ()async{
                          await _deleteArticle(context);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: MediaQuery.of(context).viewInsets,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
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
                              value: _oldArticle.title,
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
                              value: _oldArticle.categories,
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
                          ],
                        )
                    ),
                  )
                ],
              )
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 10.0
            ),
            child: SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                  onPressed: (){
                    _updateArticle(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  color:  ThemeDetails.yellowColor,
                  child: Text("Republish Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700
                    ),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }

  void _updateArticle(BuildContext context) async{
    if(_formKey.currentState.validate()){
      loadingDialog(context: context);
      _articleValidator();
      final Article response = await ArticlesCollection().updateArticleData(_newArticle);
      if(response != null){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
      else {
        Navigator.of(context).pop();
        _notify("Failed to update this article, please check your details");
        Navigator.pop(context);
      }
    }
  }

  //article data validator
  _articleValidator(){
    setState(() {
      _newArticle.id =_newArticle.id??_oldArticle.id;
      _newArticle.title =_newArticle.title??_oldArticle.title;
      _newArticle.dateCreated =_newArticle.dateCreated??_oldArticle.dateCreated;
      _newArticle.categories =_newArticle.categories??_oldArticle.categories;
      _newArticle.description = _newArticle.description??_oldArticle.description;
      _newArticle.image =_oldArticle.image;
      _newArticle.author =_person ??_oldArticle.author;
    });
  }

  _deleteArticle(BuildContext context) async{
    loadingDialog(context: context);
    final RESPONSES response =await ArticlesCollection().removeArticle(_newArticle);
    if(response == RESPONSES.REMOVED_SUCCESSFULLY) {
    _notify( "You deleted this article");
      setState(() {
        _articlesProvider.removeFromList(_oldArticle);
      });
    }
    else{
    _notify( "Failed, Something is wrong");
    }
  }

  _notify( String message){
    Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ThemeDetails.sYellowColor,
          content: Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 16.0
            ),
          ),
        ));
  }

  bool _checkIfDeletable(Person _person){
    int _difference =  DateTime.now().difference(_oldArticle.dateCreated).inMinutes;
    bool _isOwner =  _person.uid == _oldArticle.author.uid;
    bool _timeElapsed = _difference <= 1;
    return (_isOwner && _timeElapsed);
  }
}
