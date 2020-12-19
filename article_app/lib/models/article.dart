import 'package:article_app/models/person.dart';

class Article{
  String id;
  String image;
  String title;
  Person author;
  DateTime dateCreated;
  String description;
  String categories;
  List likes;

  Article({
    this.id,
    this.image,
    this.title,
    this.author,
    this.description,
    this.dateCreated,
    this.categories,
    this.likes
  }){
    this.dateCreated = dateCreated?? DateTime.now();
    this.likes = likes ?? [];
  }

  //change to map data
  Map<String, dynamic> toArticleJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    try {
      data['title'] = this.title;
      data['image'] = this.image;
      data['author'] = this.author.personToArticleJson();
      data['description'] = this.description;
      data['category'] = this.categories;
      data['dateCreated'] = this.dateCreated.millisecondsSinceEpoch;
    } catch (e, stack) {
      throw Exception(e);
    }
    return data;
  }

  //change from map to person object
  Article.fromArticleJson(Map<dynamic, dynamic> data, String _id) {
    try{
      id = _id;
      title = data['title']??'';
      description = data['description']??'';
      categories = data['category']??'';
      author = Person.fromAuthorJson(data['author']);
      image = data['image']??'http://via.placeholder.com/300x300';
      dateCreated =DateTime.fromMillisecondsSinceEpoch(data['dateCreated']);
      this.likes = likes??[];
    }
    catch(e){
     print(e);
    }
  }


}

String _desc = "Every Ghibli movie is written and scripted considering a 5-year old child as its core audience. For example, My Neighbor Totoro (movie from which the title image above is taken) has a story which IMDb summarizes as:"
    "The adventures of two girls with wonderous forest spirits Now that’s a simple story. But wait! There are so many rich layers to it. There’s the emotional background of their ailing mother. There’s the curiosity about growing up and exploring things. There’s the unuttered fear of responsibility. So while a 5-year old can ride along in the girls’ adventures; any adult can associate with its vivid non-melodramatic emotions."
    "Now let’s take a look at the Fantastical calendar app which applies this principle beautifully."
    "Ghibli"
    "Event Input in Fantastical for Mac"
    "The moment you hit ⌃⌥ Space on your mac, Fantastical takes you straight to the cursor and you can start typing whatever you want to schedule. Also even as you type, it modifies the event/reminder details in real-time in the details pane. So a new user (child) doesn’t require any learning curve whatsoever for accessing its core functionality."
    "At the same time, for a pro user (adult), Fantastical’s natural language parser will understand pretty much everything s/he can throw at it — when to alert, when to repeat, which calendar to use, event location et al."
    "Focus on one core functionality. Make it really simple for your user to access, use and become GREAT at that functionality."
    "Another good example of this is the Instagram app — with its clear and constant focus on the Camera button (Just open your phone and check)."
    "A product that fails miserably at this is Twitter.";

List<Article> articles = [
  Article(
    id: "1",
    image: "assets/images/ui.jpg",
    title: "6 Habits of Learners",
    author: Person(name: "Marco",uid: '2CeTS1xCVFVahVMXBzHO3pt1xQr1'),
    dateCreated: DateTime.now(),
    categories: 'UI UX Design',
    description:_desc
  ),
  Article(
      id: "2",
      image: "assets/images/stream.png",
      title: "Learn UI UX Design",
      categories: 'UI UX Design',
      author: Person(name:"Watson", uid: "rXMQ8AhWt5RCRMxWE2shxKlHHWr2"),
      dateCreated: DateTime.now(),
      description:_desc
  ),
  Article(
      id: "3",
      image: "assets/images/mockups.png",
      title: "2020 Make partner relationship with the articular",
      author: Person(name:"Darsene", uid: "f3yY0Yu4ZCZXW5zsfzvMctbJF9v2"),
      categories: 'Motivation',
      dateCreated: DateTime.now(),
      description:_desc
  ),
  Article(
      id: "4",
      image: "assets/images/float.png",
      title: "Common mistakes made by UI UX Designers",
      categories: 'UI UX Design',
      author: Person(name:"Darsene", uid: "f3yY0Yu4ZCZXW5zsfzvMctbJF9v2"),
      dateCreated: DateTime.now(),
      description:_desc
  ),
  Article(
      id: "5",
      image: "assets/images/scroll.png",
      title: "Dealing with customer objections",
      categories: 'Motivation',
      author: Person(name:"Thocco" ,uid: 'K2STGpTYEdWUi98IAwhCXO0y2Y92' ),
      dateCreated: DateTime.now(),
      description:_desc
  )

];