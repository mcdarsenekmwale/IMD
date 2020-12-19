import 'package:article_app/models/article.dart';
import 'package:article_app/models/person.dart';
import 'package:article_app/providers/articles_provider.dart';
import 'package:article_app/services/articles_collection.dart';
import 'package:article_app/services/person_collection.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:article_app/widgets/person_articles_section.dart';
import 'package:article_app/widgets/page_header_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{

  static Person _person;
  static int _tabIndex = 0;
  static ArticlesProvider provArticles;
  static PageController _pageController;


  @override
  void initState() {
    _pageController = new PageController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _initialLoader();
    _person = _person??Provider.of<Person>(context) ?? Person();
    provArticles = Provider.of<ArticlesProvider>(context);
    _getBookmarks();
    super.didChangeDependencies();
  }

  _getBookmarks()async{
    await ArticlesCollection().getBookmarkedArticles(_person.bookmarkedArticles, provArticles.articles)
        .then((data){
      provArticles.emptyBookmark();
      if(data !=null)
        provArticles.bookmarks = [...provArticles.bookmarks,...data];
    });
  }

  _initialLoader() {
    PersonCollection().person.asBroadcastStream().listen((person) {
        _person= person;
    });
  }

  int _getMyArticlesCount(){
    int i = 0;
    for(Article _a in provArticles.articles)
      if(_a.author.uid == _person.uid)
        i++;
      return i;
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                                        image: CachedNetworkImageProvider(_person.avatar),
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
                                  Text(_person.name,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFFFFFFF)
                                    ),
                                  ),
                                  Text(_person.type??" ",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'Poppins',
                                        color: Colors.grey.shade300
                                    ),
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
                                  child: Text('2',
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
                                children: ["Published", "Bookmark"]
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
                                      ProfileArticlesSection(
                                          articles: provArticles.articles,
                                          section: 'published',
                                      ),
                                      FutureBuilder<List<Article>>(
                                          initialData: provArticles.bookmarks,
                                          future: ArticlesCollection()
                                              .getBookmarkedArticles(_person.bookmarkedArticles, provArticles.articles),
                                          builder: (context, snapshot){

                                            if(snapshot.hasData) {

                                              return ProfileArticlesSection(
                                                articles: snapshot.data,
                                                section: 'saved',
                                              );
                                            }
                                            else
                                              return Container();
                                          }
                                      )
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
