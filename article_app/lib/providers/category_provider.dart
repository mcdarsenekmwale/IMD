import 'package:article_app/models/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider extends ChangeNotifier{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Category _category;
  List<Category> _categories = new List<Category>();
  List<CATEGORIES> _selectedCategories = new List<CATEGORIES>();

  //setters and getters
  Category get category  =>_category;
  set category (Category _newCat){
    assert(_newCat != null);
    _category = _newCat;

    notifyListeners();
  }

  //setters and getters
  List<Category> get categories =>_categories;
  set categories(List<Category> _listCat){
    assert(_listCat != null);
    assert(_selectedCategories.every((sec) => (sec) != null),'');
    _categories = _listCat;

    notifyListeners();
  }


  //selected category
  void selectCategory(Category _category){
    _selectedCategories.add(_category.section);
    _categories.add(_category);
    storeInSharedPreference();
    notifyListeners();
  }

  //selected category
  void unSelectCategory(Category _category){
    int i = _selectedCategories.indexOf(_category.section);
    _categories.removeAt(i);
    _selectedCategories.removeAt(i);

    storeInSharedPreference();
    notifyListeners();
  }

  bool exist(CATEGORIES _section){
    return _selectedCategories.contains(_section);
  }

  void unSelectAll(){
    _categories.clear();
    _selectedCategories.clear();
    storeInSharedPreference();
    notifyListeners();
  }

  Future<void> loadFromSharedPreference() async {
    final SharedPreferences prefs = await _prefs;
    final List<String> sCategories = (prefs.getStringList('MYCATEGORIES')??[]);
    _categories.clear();
    _selectedCategories.clear();
   Category.categories.map((sharedCat) {
     if(sCategories.contains(sharedCat.name))
       selectCategory(sharedCat);
   }).toList();

  }

  Future<void> storeInSharedPreference() async {
    final SharedPreferences prefs = await _prefs;
   List<String> sharedCats = _categories.map((e) => e.name).toList() ;
    prefs.setStringList("MYCATEGORIES", sharedCats).then((bool success) {
      return sharedCats;
    });
  }

}