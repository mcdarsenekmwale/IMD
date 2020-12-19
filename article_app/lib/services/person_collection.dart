import 'package:article_app/models/article.dart';
import 'package:article_app/models/person.dart';
import 'package:article_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonCollection{
  final String uid;

  PersonCollection({this.uid});

  final CollectionReference personReference = FirebaseFirestore.instance.collection('users');


  //collection reference for user profile
  Future updateUserData(Person person) async{
    try {
       await personReference.doc(person.uid).set(person.toPersonJson());
       return person;
    }
    catch(e){
      return e;
    }
  }

  //get person data
  Person personDataFromSnapshot(DocumentSnapshot snapshot)=>
      Person.fromUserJson(snapshot.data());

  Stream<Person> get person  async*{
    try {
      Person person = await personReference.doc(
          FirebaseAuth.instance.currentUser.uid).get()
          .then((v) => personDataFromSnapshot(v)
      );
      person.uid = FirebaseAuth.instance.currentUser.uid;
      assert(person != null);
      yield person;
    }
    catch(e){
      // yield null;
      throw Exception(e);
    }
  }


  //bookmarking
  setBookmarkingArticle(Person _person, Article _article) async{
    try{
      await personReference.doc(_person.uid).update(
          {
            "bookmarked":FieldValue.arrayUnion([_article.id])
          });
      return RESPONSES.SUCCESSFULLY_ADDED;
    }
    catch(e){
      return RESPONSES.FAILED_TO_REMOVE;
    }
  }

  unSetBookmarkingArticle(Person _person, Article _article) async{
    try{
      await personReference.doc(_person.uid).update(
          {
            "bookmarked":FieldValue.arrayRemove([_article.id])
          });
      return RESPONSES.REMOVED_SUCCESSFULLY;
    }
    catch(e){
      return RESPONSES.FAILED_TO_REMOVE;
    }
  }

//get
Future<Person> getPersonDetails()async{
    try{
      DocumentSnapshot documentSnapshot = await personReference.doc(this.uid).get();
      Person _person = Person.fromUserJson(documentSnapshot.data());
      _person.uid = documentSnapshot.id;
      return _person;
    }
    catch(e){
      return null;
    }
}

  Future<List<Person>> getAllPerson() async {
    try{
      QuerySnapshot data = await personReference.orderBy('name',descending: true).get();
      return _personFromSnapshot(data);
    }
    catch(e){
      return null;
    }
  }

  Future<List<Person>> getPersonByType(String type) async {
    try{
      QuerySnapshot data = await personReference.
      where('type', isEqualTo: type.toLowerCase()).get();
      return _personFromSnapshot(data);
    }
    catch(e){
      return null;
    }
  }


  //
  //change article format
  List<Person> _personFromSnapshot(QuerySnapshot snapshot){
    try {
      return snapshot.docs.map((snap){
          Person _person = Person.fromUserJson(snap.data());
          _person.uid = snap.id;
          return _person;
      }).toList();
    }catch(e) {
      return null;
    }
  }

}