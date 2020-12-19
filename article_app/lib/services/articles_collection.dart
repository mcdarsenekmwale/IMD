import 'package:article_app/models/article.dart';
import 'package:article_app/models/person.dart';
import 'package:article_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticlesCollection{
  final String id;
  ArticlesCollection({this.id});

  final CollectionReference articleReference = FirebaseFirestore.instance.collection('articles');

  //change article format
  List<Article> _articlesFromSnapshot(QuerySnapshot snapshot){
    try {
      return snapshot.docs.map((snap)  =>
          Article.fromArticleJson(snap.data(), snap.id)).toList();
    }catch(e) {
      return null;
    }
  }

  Future<List<Person>> getListOfLikes(Article article) async{
    List<Person> likes = [];
    QuerySnapshot querySnapshot =  await articleReference.doc(article.id).collection('likes').get();
    querySnapshot.docs.map((_query) {
      likes.add(
          Person.fromAuthorJson(_query.data())
      );
    });
    return likes;
  }

  //get a list of article as a stream
  Stream<List<Person>> get likes=>
      articleReference.doc(id).collection('likes') .snapshots().map(_likesFromSnapshot);

  List<Person> _likesFromSnapshot(QuerySnapshot snapshot)
        =>snapshot.docs.map((_query) => Person.fromAuthorJson(_query.data())).toList();

  //get a list of article as a stream
  Stream<List<Article>> get streamArticles=>
      articleReference.snapshots().map(_articlesFromSnapshot);

  //collection reference for articles
  Future createArticleData(Article article) async {
    try {
      await articleReference.doc().set(article.toArticleJson());
      return article;
    }
    catch (e) {
      return null;
    }
  }

    //collection reference for articles
    Future updateArticleData(Article article) async{
      try{
        await articleReference.doc(article.id).update(article.toArticleJson());
        return article;
      }
      catch (e) {
        return null;
      }
  }

 Future removeArticle(Article _article) async {
    try{
      await articleReference.doc(_article.id).delete();
      return RESPONSES.REMOVED_SUCCESSFULLY;
    }
    catch(e){
      return RESPONSES.FAILED_TO_REMOVE;
    }
  }

  //
  //get a load of bookmarks
  Future<List<Article>> getBookmarkedArticles(List _bookmarks, List<Article> _articles) async{
    try{
      List<Article> _bookmarkArts = [];
       _articles.asMap().entries.map((_articleMapE) {
        if(_bookmarks.contains(_articleMapE.value.id))
          _bookmarkArts.add(_articleMapE.value);
      }).toList();
       return _bookmarkArts;
    }
    catch(e){
      return null;
    }
  }

  //liking article
  setLiking(Person _person, Article _article) async {
    try{
      final likeRef =  articleReference.doc(_article.id).collection('likes').doc(_person.uid);
      await FirebaseFirestore.instance.runTransaction((transaction) async{
          transaction.set(likeRef, _person.personToArticleJson(),);
      });
      return RESPONSES.SUCCESSFULLY_ADDED;
    }
    catch(e){
      return RESPONSES.FAILED_TO_ADD;
    }
  }

  setUnLiking(Person _person, Article _article) async {
    try{
      await articleReference.doc(_article.id)
          .collection('likes')
          .doc(_person.uid)
          .delete();
      return RESPONSES.REMOVED_SUCCESSFULLY;
    }
    catch(e){
      return RESPONSES.FAILED_TO_REMOVE;
    }
  }

  //get author articles
  Future<List<Article>> getAuthorArticles(Person _author)async{
    try{
      QuerySnapshot _documents = await articleReference.where('author.uid', isEqualTo:_author.uid ).get();
      return _articlesFromSnapshot(_documents);
    }
    catch(e){
      return null;
    }
  }


  //search for category s
  Future<List<Article>> getArticleByCategory(String category) async {
    try{
      QuerySnapshot data = await articleReference.
      where('category', isEqualTo: category.toLowerCase()).get();
      return data.docs.map(
              (_article) =>
                  Article.fromArticleJson(_article.data(), _article.id)
      ).toList();
    }
    catch(e){
      return null;
    }
  }

  Future<List<Article>> getArticleByTitle(String title) async {
    try{
      QuerySnapshot data = await articleReference.
      where('title', isEqualTo: title.toLowerCase()).get();
      return _articlesFromSnapshot(data);
    }
    catch(e){
      return null;
    }
  }

  Future<List<Article>> getArticleByDescription(String description) async {
    try{
      QuerySnapshot data = await articleReference.
      where('description', isEqualTo: description.toLowerCase()).get();
      return _articlesFromSnapshot(data);
    }
    catch(e){
      return null;
    }
  }

  Future<List<Article>> getArticleByAll() async {
    try{
      QuerySnapshot data = await articleReference
          .orderBy('dateCreated',descending: true).get();
      return _articlesFromSnapshot(data);
    }
    catch(e){
      return null;
    }
  }


}