import 'package:article_app/models/article.dart';
import 'package:article_app/models/person.dart';
import 'package:article_app/providers/articles_provider.dart';
import 'package:article_app/services/articles_collection.dart';
import 'package:article_app/services/person_collection.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _searchController;
  ArticlesProvider _articlesProvider;
  List<Article> _searchedArticles = new List<Article>();
  List<Person> _searchedPeople = new List<Person>();
  var _personSearchStore = [];
  var _articleSearchStore = [];
  bool _pSelected = true;
  bool _isSelected = true;
  bool _isSearched = false;

  @override
  void initState() {
    _searchController = new TextEditingController();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _articlesProvider = Provider.of<ArticlesProvider>(context);
    _getPeopleData();
    _getArticleData();
    _sortMostSearched();
    super.didChangeDependencies();
  }

  _sortMostSearched(){
    if(_articlesProvider.freqSearched.length > 1)
    _articlesProvider.freqSearched.sort(
            (a,b)=>
                b.values.first.compareTo(a.values.first)
    );
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
                  _searchPageHeader(),
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
                              height: 10.0,
                            ),
                            _buildFilterHeader(),
                            SizedBox(
                              height: 10.0,
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  primary: true,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 5.0
                                    ),
                                    child: Visibility(
                                      visible: _searchController.text.isNotEmpty,
                                      replacement:Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10.0
                                        ),
                                        child: Visibility(
                                          visible: _articlesProvider.freqSearched.isNotEmpty,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Recent Searched', style: TextStyle(
                                                fontSize: 14.0,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade600,
                                              ),
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              Column(
                                                children: _articlesProvider.freqSearched.map(
                                                        (article) =>
                                                        GestureDetector(
                                                          behavior: HitTestBehavior.opaque,
                                                          onTap: (){
                                                            Navigator.pushNamed(context, '/full-article', arguments: {'article':article.keys.first, 'tag':'searched'});
                                                            _articlesProvider.searched(article.keys.first);
                                                          },
                                                          onHorizontalDragStart: (DragStartDetails details){
                                                            setState(() {
                                                              _articlesProvider.removeSearch(article.keys.first);
                                                            });
                                                          },
                                                          child: _searchResults(
                                                              image:article.keys.first.image,
                                                              title: article.keys.first.title,
                                                              subtitle: article.keys.first.description
                                                          ),
                                                        )
                                                ).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Visibility(
                                              visible: _searchedArticles.isNotEmpty && _isSelected,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Articles', style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  ),
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Column(
                                                    children: _searchedArticles.map(
                                                            (article) =>
                                                                GestureDetector(
                                                                  behavior: HitTestBehavior.opaque,
                                                                  onTap: (){
                                                                      Navigator.pushNamed(context, '/full-article', arguments: {'article':article, 'tag':'searched'});
                                                                      _articlesProvider.searched(article);
                                                                    },
                                                                  child: _searchResults(
                                                                      image:article.image,
                                                                      title: article.title,
                                                                      subtitle: article.description
                                                                  ),
                                                                )
                                                    ).toList(),
                                                  ),
                                                  SizedBox(
                                                    height: 15.0,
                                                  )
                                                ],
                                              ),
                                          ),
                                          Visibility(
                                            visible: _searchedPeople.isNotEmpty  && _pSelected,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('People', style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey.shade600,
                                                ),
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Column(
                                                  children: _searchedPeople.map(
                                                          (person) =>
                                                          GestureDetector(
                                                              behavior: HitTestBehavior.opaque,
                                                              onTap: ()=>Navigator.pushNamed(context, '/authors', arguments: person),
                                                            child: _searchResults(
                                                                image:person.avatar,
                                                                title: person.name,
                                                                subtitle: person.type
                                                            ),
                                                          )
                                                  ).toList(),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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

  _startSearching() async{
    if(_searchController.text.isNotEmpty){
      await _getPeople(_searchController.text);
       await _getArticles(_searchController.text);
       _isSearched = true;
    }else{
      _isSearched = false;
    }
    setState(() {});
  }

  _getPeopleData()async{
    _personSearchStore = await PersonCollection().getAllPerson()??[];
  }
  _getArticleData()async{
    //_articleSearchStore.clear();
    _articleSearchStore = await ArticlesCollection().getArticleByAll()??[];
    _articleSearchStore = [..._articleSearchStore, ..._articlesProvider.articles];
    _removeArticleDuplicates(_articleSearchStore, "Articles");
  }

  _getPeople(String _term){
    try{
      _searchedPeople = [];
      for(Person person in _personSearchStore){
        var value = _term.toString().toLowerCase();
        if(person.name.toString().toLowerCase().contains(value) ||
            person.type.toString().toLowerCase().startsWith(value)) {
          setState(() {
            _searchedPeople.add(person);
          });
        }
      }
      // _removeArticleDuplicates(_searchedPeople, "People");
    }
    catch(e){}
  }
  _getArticles( String _term) {
    try{
      _searchedArticles = [];
      for(Article article in _articleSearchStore){
        var value = _term.toString()..toLowerCase();
        if(article.title.toString().toLowerCase().contains(value)
            || article.categories.toString().toLowerCase().startsWith(value)
            || article.author.name.toString().toLowerCase().contains(value)
            || article.description.toString().toLowerCase().contains(value)
        ) {
          setState(() {
            _searchedArticles.add(article);
          });
        }
      }
    }
    catch(e){}
  }

  //remove duplicates
  _removeArticleDuplicates(List _list, String _type){
    for (int _i= 0; _i < _list.length; _i++ )
    {
      int _z = 0;
      for(dynamic i in _list)
        if(_isExists(i , _list[_i], _type))
          _z++;
      if (_z > 1)
        _list.removeAt(_i);
    }
  }

  //check
 bool _isExists(dynamic i, dynamic y, String t){
    if(t == "Articles")
      return i.id == y.id;
    else if(t == "People")
      return i.uid == y.uid;
    return false;
  }

  Widget _buildFilterHeader(){
    return Visibility(
      visible: _isSearched,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                _isSelected = !_isSelected;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 1.0,
                  horizontal: 10.0
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: _isSelected
                      ?ThemeDetails.sYellowColor
                      : Colors.transparent,
                  border: Border.all(
                      color: ThemeDetails.sYellowColor,
                      width:2.0
                  )
              ),
              child: Row(
                children: [
                  Text("Articles",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Poppins',
                        color:_isSelected
                            ? Colors.white
                            :ThemeDetails.sYellowColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                   _isSelected? Icons.clear : Icons.check,
                    size: 20.0,
                    color:_isSelected
                        ? Colors.white
                        :ThemeDetails.sYellowColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                _pSelected = !_pSelected;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 1.0,
                  horizontal: 10.0
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: _pSelected
                      ?ThemeDetails.sYellowColor
                      : Colors.transparent,
                  border: Border.all(
                      color: ThemeDetails.sYellowColor,
                      width:2.0
                  )
              ),
              child: Row(
                children: [
                  Text("People",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Poppins',
                        color:_pSelected
                            ? Colors.white
                            :ThemeDetails.sYellowColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    _pSelected? Icons.clear : Icons.check,
                    size: 20.0,
                    color:_pSelected
                        ? Colors.white
                        :ThemeDetails.sYellowColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //search page header
  Widget _searchPageHeader(){
    return Padding(
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
                color:  Colors.white,
              ),
              onPressed: ()=>Navigator.pop(context)
          ),
          SizedBox(width: 4.0,),
          Expanded(
            child: Container(
              height: 46,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color:Colors.grey.shade300.withOpacity(0.93),
                  border: Border.all(
                      color: ThemeDetails.primaryColor.withOpacity(0.4)
                  )
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(2.0),
              child: TextField(
                autofocus: false,
                controller: _searchController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.grey.shade800,
                textInputAction: TextInputAction.search,
                style: TextStyle(
                    color:Colors.grey.shade800,
                    fontFamily: "Poppins"
                ),
                decoration: InputDecoration(
                  contentPadding:EdgeInsets.all(0.0) ,
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 18.0,
                      fontFamily: "Poppins",
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 26.0,
                    color: Colors.grey.shade500,
                  ),
                ),
                onTap: (){},
                onChanged:(v){
                  _startSearching();
                },
                onSubmitted:(v){
                  _startSearching();
                },
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.sort_by_alpha_rounded,
                size: 33.0,
                color: Colors.white,
              ),
              onPressed: (){
                bool v = _searchedArticles.isNotEmpty && _searchedArticles.length>1;
                bool x = _searchedPeople.isNotEmpty && _searchedPeople.length>1;
                if(v)
                  _searchedArticles.sort((a, b)=>a.title.compareTo(b.title));
                if(x)
                  _searchedPeople.sort((a, b)=>a.name.compareTo(b.name));
                setState(() {

                });
                if(v||x)
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        backgroundColor: ThemeDetails.sYellowColor,
                        content: Text('Sorted',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 16.0
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.7,
                          right: 10.0,
                          bottom: 5.0
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      )
                  );
              }
          ),
          SizedBox(
            width: 5.0,
          ),
        ],
      ),
    );
  }

  Widget _searchResults({String image, String title, String subtitle }){
    return Container(
      child: Row(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
           margin: EdgeInsets.symmetric(
             vertical: 5.0
           ),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(8.0),
             image: DecorationImage(
               image: image.startsWith('https:')?
               CachedNetworkImageProvider(image)
                   :AssetImage(image),
               fit: BoxFit.cover
             )
           ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12.0,
                    fontFamily: "Poppins"
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
