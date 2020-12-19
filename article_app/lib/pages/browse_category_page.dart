import 'package:article_app/models/category.dart';
import 'package:article_app/providers/category_provider.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:article_app/widgets/category_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrowseCategoryPage extends StatefulWidget {
  @override
  _BrowseCategoryPageState createState() => _BrowseCategoryPageState();
}

class _BrowseCategoryPageState extends State<BrowseCategoryPage> with SingleTickerProviderStateMixin{


  static CategoryProvider _categoryProvider;
  List<Category> _categories = Category.categories;
  PersistentBottomSheetController _controller; // <------ Instance variable
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // <---- Another instance variable


  @override
  void initState() {
    // for(CATEGORIES i in CATEGORIES.values)
    //   _selectedList.add(i);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _categoryProvider = Provider.of<CategoryProvider>(context);
    _loadCategories();
    super.didChangeDependencies();
  }

  _loadCategories() async{
    await _categoryProvider.loadFromSharedPreference();
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
                            Expanded(
                                child: Center(
                                  child: Text('Browse Category',
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
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Text('What topic interest you the most ?',
                                style: TextStyle(
                                    fontSize: 23.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: ThemeDetails.yellowColor
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0,),

                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                        width: size.width,
                        padding:  EdgeInsets.symmetric(
                            horizontal: 6.0
                        ),
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
                            Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Center(
                                  child: Wrap(
                                    spacing: 10.5, // gap between adjacent chips
                                    runSpacing: 2.0,
                                    children: Category.categories.map((_category)
                                    => GestureDetector(
                                      behavior: HitTestBehavior.deferToChild,
                                      onTap: (){
                                        _editCategoryBottomSheet(context, _category);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          bottom:5.0
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            border: Border.all(color: ThemeDetails.accentColor.withOpacity(0.5)),
                                            color: Color(0xFFFFFFfF),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFFf6f6fc),
                                                offset: Offset(2,3),
                                                spreadRadius: 6,
                                                blurRadius: 6,
                                              )
                                            ]
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                                height: 230.0,
                                                width: size.width*0.45,
                                                decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: AssetImage(_category.image),
                                                  fit: BoxFit.cover,
                                                )
                                              ),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.black12.withOpacity(0.5),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                child: Visibility(
                                                  visible: _categoryProvider.exist(_category.section),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.check,
                                                      color: ThemeDetails.yellowColor.withOpacity(0.4),
                                                      size: 50.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 10.0,
                                                left: 5.0,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(_category.name,
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.5,
                                                          color: Color(0xFFFFFFFF)
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.width*0.41,
                                                      child: Text(_category.description,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 10.0,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w500,
                                                            letterSpacing: 0.5,
                                                            color: Colors.grey.shade400
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                    ).toList(),
                                  ),
                                ),
                              ),
                            ),
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

  void _editCategoryBottomSheet(BuildContext context, Category _category){
    bool _active = _categoryProvider.exist(_category.section);
    showModalBottomSheet(
        isScrollControlled:true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (context){
          return StatefulBuilder(
          builder: (BuildContext context, StateSetter innerState )  {
              return CategoryBottomSheet(
                  category: _category,
                  selected: _categoryProvider.exist(_category.section),
                  active: _active,
                  onSelected: (){
                    innerState(() {
                      if(!_active)
                        _active = true;
                      if(!_categoryProvider.exist(_category.section))
                        _categoryProvider.selectCategory(_category);
                      else
                        _categoryProvider.unSelectCategory(_category);
                    });
                    //setState(() { });
                  });
            }
          );
        });
  }
}
