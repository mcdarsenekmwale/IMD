import 'package:article_app/models/article.dart';
import 'package:article_app/pages/create_new_article_page.dart';
import 'package:article_app/providers/articles_provider.dart';
import 'package:article_app/services/articles_collection.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:article_app/widgets/article_card.dart';
import 'package:article_app/widgets/article_list_card.dart';
import 'package:article_app/widgets/edit_article_bottom_sheet.dart';
import 'package:article_app/widgets/sidebar_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();
  ArticlesProvider provArticles;
  Animation<Matrix4> _animationReset;
  AnimationController _controllerReset;
  final TransformationController _transformationController =
  new TransformationController();
  Matrix4 _homeMatrix;
  bool _draggable = false;
  double height;
  Size mSize;

  @override
  void initState() {
    _controllerReset = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    provArticles = Provider.of<ArticlesProvider>(context);
    height = MediaQuery.of(context).size.width;
    mSize = MediaQuery.of(context).size;
    _loadArticles();
    super.didChangeDependencies();
  }

  _loadArticles(){
    ArticlesCollection().streamArticles.listen((_articles) {
      if(_articles != null)
        setState(() {
          provArticles.removeAll();
          provArticles.articles = _articles;
          provArticles.articles = [ ...provArticles.articles, ...articles.reversed.toList()];
        });
    });
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    _controllerReset?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final _articles = provArticles.articles.isEmpty
        ?articles.reversed.toList():provArticles.articles;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBarDrawer(onHideSideBar:()=>_scaffoldKey.currentState.openEndDrawer(),),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12.0
              ),
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap:()=>_scaffoldKey.currentState.openDrawer(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        "assets/icons/menu.svg",
                        height: 28.0,
                        width: 28,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container()
                  ),
                  GestureDetector(
                    onTap:()=>Navigator.of(context).pushNamed('/search'),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        "assets/icons/loupe.svg",
                        height: 24.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap:()=>Navigator.of(context).pushNamed('/notifications'),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        "assets/icons/sliders.svg",
                        height: 25.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    color: Color(0xFF612c56),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(30.0)
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 15.0
                                ),
                                child: Row(
                                  children: [
                                    Text('Popular',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.0,
                                          color: Color(0xFF030303)
                                      ),
                                    ),
                                    Spacer(),
                                    Text(DateFormat.yMMMEd().format(DateTime.now()),
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Poppins',
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: (articles.length/2).ceil(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index){
                                      return ArticleCard(article: articles[index]);
                                    }
                                ),
                              ),
                              GestureDetector(
                                onScaleStart:_onScaleStart ,
                                onHorizontalDragDown: _onHorizontalDragDown,
                                onScaleUpdate:_onScaleUpdate ,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
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
                                    SizedBox(
                                      height: size.width*0.05,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              top: 30.0,
                              left: 15.0,
                              right: 15.0,
                            ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Recent Articles',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.0,
                                    color: Color(0xFFFFFFFF)
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Column(
                                children:_articles.map((_article)
                                => ArticleListCard(
                                    article: _article,
                                    onTap: (){
                                      _editArticleBottomSheet(context,_article);
                                    },
                                ) )
                                    .toList(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
      floatingActionButton: Hero(
        tag: 'Float',
        child: SizedBox(
          height: 68,
          width: 68,
          child: FlatButton(
            onPressed: (){
              if(provArticles.articles.isEmpty) {
                provArticles.articles = articles.reversed.toList();
              }
              Navigator.of(context).push(
                  PageTransition(
                      child: CreateNewArticlePage(),
                      type: PageTransitionType.rippleRightUp
                  )
              );
            },//=>Navigator.pushNamed(context, '/create-newArticle'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            color:  ThemeDetails.yellowColor,
            child: Icon(Icons.add,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
      ),
    );
  }

  //drag functions
_onScaleStart(ScaleStartDetails details){
  if (_controllerReset.status == AnimationStatus.forward) {
    _animateResetStop();
  }
  print(details);
  setState(() {
    _draggable= !_draggable;
  });
}

  _onHorizontalDragDown(DragDownDetails details){
    _controllerReset.reset();
    _animationReset = Matrix4Tween(
      begin: _transformationController.value,
      end: _homeMatrix,
    ).animate(_controllerReset);
    _controllerReset.duration = const Duration(milliseconds: 400);
    _animationReset.addListener(_onAnimateReset);
    _controllerReset.forward();
    if(mSize.width <  details.globalPosition.dy && height < mSize.height *0.8 )
        setState(() {
        height = details.globalPosition.dy;
        });
  }

  _onScaleUpdate(ScaleUpdateDetails details){
    print(details);
  }

// Handle reset to home transform animation.
  void _onAnimateReset() {
    //_transformationController.value = _animationReset.value;
    if (!_controllerReset.isAnimating) {
      _animationReset?.removeListener(_onAnimateReset);
      _animationReset = null;
      _controllerReset.reset();
    }
  }

  // Stop a running reset to home transform animation.
  void _animateResetStop() {
    _controllerReset.stop();
    _animationReset?.removeListener(_onAnimateReset);
    _animationReset = null;
    _controllerReset.reset();
  }


  //
//show modal
  void _editArticleBottomSheet(BuildContext context, Article _article){
    showModalBottomSheet(
        isScrollControlled:true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (context){
          return EditArticleBottomSheet(
            article: _article,
          );
        });
  }
}
