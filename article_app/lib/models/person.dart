class Person{
  String uid;
  String name;
  String avatar;
  String email;
  String type;
  String about;
  String password;
  List bookmarkedArticles;

  Person(
  {
    this.uid,
    this.name,
    this.email,
    this.type,
    this.about,
    this.password
  }){
    this.bookmarkedArticles = bookmarkedArticles??[];
  }


  //change to map data
  Map<String, dynamic> toPersonJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    try {
      data['name'] = this.name;
      data['avatar'] = this.avatar;
      data['type'] = this.type;
      data['email'] = this.email;
      data['about'] = this.about;
      data['bookmarked'] =  this.bookmarkedArticles??[];
    } catch (e, stack) {
      throw Exception(e);
    }
    return data;
  }

  //change to map data
  Map<String, dynamic> personToArticleJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    try {
      data['uid'] = this.uid;
      data['name'] = this.name;
      data['avatar'] = this.avatar;
    } catch (e, stack) {
      throw Exception(e);
    }
    return data;
  }

  //change from map to person object
  Person.fromAuthorJson(Map<dynamic, dynamic> data) {
    uid = data['uid']??this.uid;
    avatar = data['avatar']??'';
    name = data['name']??'';
  }

  //change from map to person object
  Person.fromUserJson(Map<dynamic, dynamic> data) {
    uid = this.uid;
    email = data['email']??'';
    name = data['name']??'';
    about = data['about']??'';
    avatar = data['avatar']??'http://via.placeholder.com/300x300';
    type = data['type']?? '';
    bookmarkedArticles = data['bookmarked']??[];
  }
}