import 'package:article_app/models/article.dart';
import 'package:article_app/models/person.dart';
import 'package:article_app/providers/articles_provider.dart';
import 'package:article_app/services/articles_collection.dart';
import 'package:article_app/services/person_collection.dart';
import 'package:article_app/utils/constants.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:article_app/widgets/page_article_details.dart';
import 'package:article_app/widgets/read_more_article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatefulWidget {
  final Article article;
  final String tag;

  const ArticlePage({
    Key key,
    @required this.article,
    @required this.tag
  }) : assert(article != null),
        super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> with SingleTickerProviderStateMixin{

  Article _article;
  bool _bookmarked = false;
  bool _liked =false;
  List<Person> likes = new List<Person>();
  List _sLikes = new List();
  bool _readMore = false;
  static Person _person;
  static int _tabIndex = 0;
  static ArticlesProvider provArticles;
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _article = widget.article;
    _getArticleLikes();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _person = Provider.of<Person>(context)?? Person();
    provArticles = Provider.of<ArticlesProvider>(context);
    _getBookmarkStatus();
    _getArticleLikes();
    _getLikedStatus();
    super.didChangeDependencies();
  }

  _getBookmarkStatus(){
    setState(() {
      _bookmarked = _person.bookmarkedArticles.contains(_article.id);
    });
  }

  _getArticleLikes() async{
   ArticlesCollection(id: _article.id).likes.listen((_likes) {
     if(_likes !=null) {
       _article.likes.clear();
       _article.likes = [..._article.likes, ..._likes];
       _likes.map((_p) => _sLikes.add(_p.uid)).toList();
     }
   });


  }

  _getLikedStatus(){
    setState(() {
      _liked = _sLikes.contains(_person.uid);
    });
 }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0XFF612c56),
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag:widget.tag + _article.image,
                          child: Container(
                            height: size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: _article.image.startsWith('https:')?
                                    CachedNetworkImageProvider(_article.image)
                                        :AssetImage(_article.image),
                                    fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(30.0)
                                )
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.15,0.4,0.5],
                                    colors: [
                                      Colors.white.withOpacity(0.2),
                                      Colors.white.withOpacity(0.05),
                                      Colors.white.withOpacity(0.00)
                                    ]
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(30.0)
                                  )
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 30,
                              horizontal: 5.0
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_rounded,
                                    size: 34.0,
                                    color: ThemeDetails.primaryColor,
                                  ),
                                  onPressed: ()=>Navigator.pop(context)
                              ),
                              Spacer(),
                              IconButton(
                                  icon: Icon(
                                    Icons.share_outlined  ,
                                    size: 34.0,
                                    color: ThemeDetails.primaryColor,
                                  ),
                                  onPressed: ()async{
                                    
                                  }
                              ),
                              IconButton(
                                  icon: Icon(
                                    _bookmarked? Icons.bookmark_rounded :Icons.bookmark_border ,
                                    size: 34.0,
                                    color: ThemeDetails.primaryColor,
                                  ),
                                  onPressed: ()async{
                                    setState(() {
                                      _bookmarked = !_bookmarked;
                                    });
                                    await _createBookmark();
                                  }
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 5.0,
                          right: 15.0,
                          child:  GestureDetector(
                            onTap: ()async {
                              setState(() {
                                _liked = !_liked;
                              });
                              await _doTheLiking();
                            },
                            child: Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    color:  ThemeDetails.yellowColor.withOpacity(0.8),
                                    shape: BoxShape.circle
                                ),
                                child: Icon(_liked
                                    ?Icons.thumb_up_alt_rounded
                                    :Icons.thumb_up_outlined,
                                  size: 30.0,
                                  color:  Colors.white.withOpacity(0.9),
                                )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top:20.0, left: 25.0, right: 25.0
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                             PageArticleDetails(article: _article,),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text('${_article.description}',
                            maxLines: _readMore?_article.description.length : 8,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14.0,
                              letterSpacing: 0.3,
                              fontFamily: 'Poppins',
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
      ),
      floatingActionButton: ReadMoreArticle(
        readMore: _readMore,
        onTap:  (){
          setState(() {
            _readMore = !_readMore;
          });
        },
        onPress: (){
          setState(() {
            _readMore = !_readMore;
          });
        },
      )
    );
  }


  //bookmarking
  _createBookmark() async{
    RESPONSES response;
    try{
      if(_bookmarked)
          response = await PersonCollection().setBookmarkingArticle(_person, _article);
      else
        response = await PersonCollection().unSetBookmarkingArticle(_person, _article);

      if(response == RESPONSES.SUCCESSFULLY_ADDED ) {
        _notify( "The article is saved");
        setState(() {
          provArticles.saved(_article);
        });
      }
      else if(response == RESPONSES.REMOVED_SUCCESSFULLY) {
        _notify( "The article is unsaved");
        setState(() {
          provArticles.unSave(_article, _person.bookmarkedArticles.indexOf(_article.id));
        });
      }
      else{
        _notify( "Failed, Something is wrong");
      }
    }
    catch (e){
      throw Exception(e);
    }
  }

  //liking
  _doTheLiking() async{
    RESPONSES response;
    try{
      if(_liked)
        response = await ArticlesCollection().setLiking(_person, _article);
      else
        response = await ArticlesCollection().setUnLiking(_person, _article);

      if(response == RESPONSES.SUCCESSFULLY_ADDED ) {
        _notify( "You have liked this article");
        setState(() {
          provArticles.saved(_article);
        });
      }
      else if(response == RESPONSES.REMOVED_SUCCESSFULLY) {
        _notify( "You have un-liked this article");
        setState(() {
          provArticles.unSave(_article, _person.bookmarkedArticles.indexOf(_article.id));
        });
      }
      else{
        _notify( "Failed, Something is wrong");
      }
    }
    catch (e){
      throw Exception(e);
    }
  }

  _notify( String message){
   _scaffoldKey.currentState.showSnackBar(
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
}
