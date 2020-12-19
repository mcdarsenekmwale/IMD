import 'package:article_app/models/person.dart';
import 'package:article_app/services/person_collection.dart';
import 'package:article_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication{

  final FirebaseAuth _auth = FirebaseAuth.instance;

// code of how to sign in with email and password.
  Future signInWithEmailAndPassword(Person _person) async {
    try {
      print(_person.toPersonJson());
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _person.email,
        password:_person.password,
      )).user;

      return {
       'Response' :RESPONSES.SUCCESSFULLY_LOGIN,
        'data':user
      };
    } catch (e) {
      return {
        'Response' :RESPONSES.FAILED_TO_LOGIN,
        'data':'Your credentials do not match our records'
      };
    }
  }

  // code for registration.
  Future register(Person _person) async {
    try{
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: _person.email,
        password:_person.password,
      )).user;
      _createAccountDocumentFromUser(user,_person);
      return {
        'Response' :RESPONSES.CREATED_SUCCESSFULLY,
        'data':user
      };
    }
    catch (e) {
      return {
        'Response' :RESPONSES.FAILED_TO_CREATE,
        'data':'Failed to create user, check our details and try again'
      };
    }
  }

  //create user object
  void _createAccountDocumentFromUser(User user, Person person) async{
       await PersonCollection(uid:user.uid ).updateUserData(new Person(
          uid: user.uid,
          name: person.name,
          email: user.email,
      ));
  }

  Stream<User> get user =>_auth.authStateChanges();
}