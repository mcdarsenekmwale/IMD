import 'package:article_app/models/article.dart';
import 'package:flutter/cupertino.dart';

class ArticlesProvider extends ChangeNotifier{
  //internal, private state of the articles
  Article _article;
  List<Article> _articles = new List<Article>();
  List<Article> _bookmarked = new List<Article>();
  List<Article> _liked = new List<Article>();
  List<Map<Article,int>> _freqSearched = new List<Map<Article,int>>();
  List<String> _likedIds= new List<String>();

  //getter and setter for a single article
Article get article =>_article;
set article(Article _art){
  assert(_art != null);
  _article = _art;
  // Notify listeners, in case the new store provides information
  // different from the previous one. For example, availability of an item
  // might have changed.
  notifyListeners();
}

//getter and setter for a list of articles
List<Article> get articles => _articles;
set articles(List<Article> _getArts){
  assert(_getArts != null);
  _articles = _getArts;

  notifyListeners();
}

//getter and setter for a list of bookmarked articles
  List<Article> get bookmarks => _bookmarked;
  set bookmarks(List<Article> _bookmarks){
    assert(_bookmarks != null);
    _bookmarked = _bookmarks;

    notifyListeners();
  }

  //getter and setter for a list of liked articles
  List<Article> get likes => _liked;
  set likes(List<Article> _newLikes){
    assert(_newLikes != null);
    _liked = _newLikes;

    notifyListeners();
  }

  //getter and setter for a list of liked articles
  List<Map<Article,int>> get freqSearched => _freqSearched;
  set freqSearched(List<Map<Article,int>> _current){
    assert(_current != null);
    _freqSearched = _current;

    notifyListeners();
  }

//total number of saved articles
int get totalNumberOfArticles =>
    articles.fold(0, (total, current) => total + 1);


  /// Adds to list of current articles. This and [removeAll] are the only ways to modify the
  void insertToList(Article _art) {
    _article = _art;
    _articles.add(_art);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeFromList(Article _art) {
    int _index = _getArticleIndex(article);
    if(_index >= 0)
      _articles.removeAt(_index);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  //get the index
  int _getArticleIndex(Article article){
    int _index = -1;
    if(_articles.isNotEmpty) {
      int index = 0;
      for (Article _art in _articles)
        if (_art.id == article.id) {
          _index = index;
          break;
        }
      index++;
    }
    return _index;
  }
  /// Removes all items from the cart.
  void removeAll() {
    _articles.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void saved(Article bookmark) {
    _bookmarked.add(bookmark);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void unSave(Article bookmark, int index) {
    _bookmarked.removeAt(index);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void emptyBookmark() {
    _bookmarked.clear();
    notifyListeners();
  }

  void like(Article article) {
    _likedIds.add(article.id);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void unLike(Article article) {
    int i = _likedIds.indexOf(article.id);
    _likedIds.removeAt(i);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  bool isLiked(String _id){
    return _likedIds.contains(_id);
  }

  void searched(Article article ) {
    int _check = _countOccurrence(article);
    if(_check == 1)
        _freqSearched.add( {
          article:1
      });
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeSearch(Article article ) {
    int index = 0;
    if(_freqSearched.isNotEmpty)
      for(Map<Article, int> _art in _freqSearched) {
        if ( _art.keys.first.id == article.id) {
          _freqSearched.removeAt(index);
          break;
        }
        index++;
      }
  // This call tells the widgets that are listening to this model to rebuild.
  notifyListeners();
  }

 int _countOccurrence(Article article){
    int index = 0, count = 1;
    if(_freqSearched.isNotEmpty)
      for(Map<Article, int> _art in _freqSearched) {
          if ( _art.keys.first.id == article.id) {
            count += _freqSearched[index].values.first;
            _freqSearched[index].update(_art.keys.first, (value) => count);
          }
          index++;
      }
    return count;
 }

  void unLikeAll() {
    _likedIds.clear();
    notifyListeners();
  }

}