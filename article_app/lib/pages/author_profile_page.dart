import 'package:article_app/models/article.dart';
import 'package:article_app/models/person.dart';
import 'package:article_app/services/articles_collection.dart';
import 'package:article_app/services/person_collection.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:article_app/widgets/page_header_item.dart';
import 'package:article_app/widgets/person_articles_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthorProfilePage extends StatefulWidget {
  final Person author;

  const AuthorProfilePage({
    Key key,
    @required this.author
  }) :  assert(author != null),
        super(key: key);

  @override
  _AuthorProfilePageState createState() => _AuthorProfilePageState();
}

class _AuthorProfilePageState extends State<AuthorProfilePage> with SingleTickerProviderStateMixin {

  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static Person _author = new Person();
  static int _tabIndex = 0;
  bool _isFollowed = false;
  static List<Article> _articles = new List<Article>();
  static PageController _pageController;


  @override
  void initState() {
    _pageController = new PageController();
    _author = widget.author;
    _getAuthorDetails();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _getAuthorDetails();
    _getAuthorArticles();
    super.didChangeDependencies();
  }

_getAuthorDetails() async{
  _author = await PersonCollection(uid: _author.uid).getPersonDetails() ?? _author;

}

_getAuthorArticles() async{
    _articles = await ArticlesCollection().getAuthorArticles(_author)??[];
    setState(() {
    });
}

  int _getMyArticlesCount(){
    int i = 0;
    for(Article _a in _articles)
      if(_a.author.uid == _author.uid)
        i++;
    return i;
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
                                  Icons.arrow_back_rounded,
                                  size: 34.0,
                                  color: Colors.white,
                                ),
                                onPressed: ()=>Navigator.pop(context)
                            ),
                            SizedBox(width: 4.0,),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 15.0,
                            ),
                            GestureDetector(
                              onTap: ()=>Navigator.pushNamed(context, '/my-account'),
                              child: Container(
                                height: 68.0,
                                width: 68.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            _author.avatar?? 'http://via.placeholder.com/300x300'),
                                        fit: BoxFit.cover
                                    ),
                                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.0)
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_author.name,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFFFFFFF)
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(_author.type??" ",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: 'Poppins',
                                            color: Colors.grey.shade300
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Visibility(
                                        visible: true,
                                        child: GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              _isFollowed = true;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 1.0,
                                              horizontal: 10.0
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.0),
                                                color: _isFollowed
                                                    ?ThemeDetails.sYellowColor
                                                    : Colors.transparent,
                                              border: Border.all(
                                                color: ThemeDetails.sYellowColor,
                                                width:2.0
                                              )
                                            ),
                                            child: Text("FOLLOW",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontFamily: 'Poppins',
                                                  color:_isFollowed
                                                      ? Colors.white
                                                      :ThemeDetails.sYellowColor,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text('Articles Published',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: ThemeDetails.yellowColor
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal:5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18.0)
                                  ),
                                  child: Text("${_getMyArticlesCount()}",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: ThemeDetails.primaryColor
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10.0,),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0)
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Column(
                              children: [
                                Text('Followers',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: ThemeDetails.yellowColor
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal:5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18.0)
                                  ),
                                  child: Text('205',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: ThemeDetails.primaryColor
                                    ),
                                  ),
                                ),
                              ],
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
                            Padding(
                              padding:  EdgeInsets.fromLTRB(20.0, 20.0, 20.0,0.0),
                              child: Row(
                                children: ["Published", "Co-authored"]
                                    .asMap()
                                    .entries
                                    .map(
                                        (item) => Expanded(
                                      child: PageHeaderItem(
                                        onTab: ()=>setState((){
                                          _tabIndex = item.key;
                                          _pageController.jumpToPage(_tabIndex);
                                        }),
                                        isActive: _tabIndex == item.key,
                                        title: item.value,
                                        size: 30.0,
                                      ),
                                    )
                                )
                                    .toList(),
                              ),
                            ),
                            Expanded(
                                child: PageView(
                                    controller: _pageController,
                                    pageSnapping: true,
                                    onPageChanged: (index) {
                                      setState(() => _tabIndex = index);
                                    },
                                    children: <Widget>[
                                      FutureBuilder<List<Article>>(
                                          initialData: _articles,
                                          future: ArticlesCollection()
                                              .getAuthorArticles(_author),
                                          builder: (context, snapshot){

                                            if(snapshot.hasData) {
                                              _articles.clear();
                                              _articles = [..._articles, ...snapshot.data];
                                              return ProfileArticlesSection(
                                                articles: snapshot.data,
                                                section: 'authors',
                                              );
                                            }
                                            else
                                              return Container();
                                          }
                                      ),
                                      ProfileArticlesSection(
                                        articles: _articles,
                                        section: 'published',
                                      ),
                                      Container()
                                    ]
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
    _pageController.dispose();
    super.dispose();
  }
}
