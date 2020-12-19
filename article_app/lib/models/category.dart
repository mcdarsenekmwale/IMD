import 'package:flutter/cupertino.dart';

enum CATEGORIES{
  ARTS ,
  POLITICS ,
  UI_UX_DESIGNS ,
  TECHNOLOGIES,
  SPORTS,
  FASHION,
  MOTIVATIONS,
  HUMOROUS,
  GAMING,
  LIFESTYLE,
  TRAVEL,
  MUSIC
}

class Category{
  int id;
  String name;
  String image;
  String description;
  CATEGORIES section;

   Category({
    Key key,
    this.id,
     this.name,
     this.image,
     this.description,
     this.section
  });

   static List<Category> categories = [
     Category(id: 1, name: "Arts", section: CATEGORIES.ARTS,
      image: "assets/images/art.jpg",
      description: "The Art Story is the only resource where you will find consistent and detailed analysis of the most important works of each artist and movement -Pablo Picasso."
     ),
     Category(id: 2, name: "Fashion", section: CATEGORIES.FASHION,
         image: "assets/images/fashion.jpg",
         description: "Fashion articles get invited to major events, receive special perks, merchandise, and even business deals by top fashion brands."
     ),
     Category(id: 3, name: "Gaming", section: CATEGORIES.GAMING,
         image: "assets/images/gaming.jpg",
         description: "Most gaming articles belong to gamers, reviewers, and official communities of big game developing agencies. They have international events for gamers and reward plans for the winners."
     ),
     Category(id: 4, name: "Humorous", section: CATEGORIES.HUMOROUS,
         image: "assets/images/humor.jpg",
         description: "Humor can be therapeutic. Take a break from social media and boredom by visiting these funny articles for a laugh."
     ),
     Category(id: 5, name: "Politics", section: CATEGORIES.POLITICS,
         image: "assets/images/political.jpg",
         description: "Political articles have perhaps the most passionate audience of all. They cover news on politics, analysis of political news, and can quickly build a very large engaging audience."
     ),
     Category(id: 6, name: "Sports", section: CATEGORIES.SPORTS,
         image: "assets/images/sports.jpg",
         description: "Every place in the world has different sports and every sport has its own stars. Get the best Sports articles may also including for your favourite teams, athletes, and other organizations."
     ),
     Category(id: 7, name: "Technologies", section: CATEGORIES.TECHNOLOGIES,
         image: "assets/images/tech.jpg",
         description: "People from different walks of life are intrigued by the way technology is progressing at a profuse rate, shaping our lives into the digital world!. Stay relevant and learn about the newest technologies, digital industry, social media, and the web in general"
     ),
     Category(id: 8, name: "UI UX Design", section: CATEGORIES.UI_UX_DESIGNS,
         image: "assets/images/ui_ux_design.jpg",
         description: "UI/UX (user interface & user experience) field moves quickly as usability, accessibility, interaction, and visual design continue to advance. It also gives you a community of artists sharing helpful resources, tips and content for both the beginner and experienced designer."
     ),
     Category(id: 9, name: "Motivations", section: CATEGORIES.MOTIVATIONS,
         image: "assets/images/moti.jpg",
         description: "Motivational articles are aimed at sharing life experiences, adventures, and daily life with others. The purpose is wider that just motivating as it can be anything like making a difference through positive stories or influencing readers with own views."
     ),
     Category(id: 10, name: "LifeStyle", section: CATEGORIES.LIFESTYLE,
         image: "assets/images/lifestyle.jpg",
         description: "Lifestyle articles have a variety of readers, interested in topics ranging from culture, arts, local news, and politics. This gives the author a wide range of topics to cover, making it easier to plan their content strategy."
     ),
     Category(id: 11, name: "Travel", section: CATEGORIES.TRAVEL,
         image: "assets/images/travel.jpg",
         description: "Travel articles are becoming more popular each day. Due to cheap air travel, people are traveling more than ever, and they are always looking for travel tips, advice, and destination guides."
     ),
     Category(id: 12, name: "Music", section: CATEGORIES.MUSIC,
         image: "assets/images/music.jpg",
         description: "Music articles has a wide audience who search for critiques on the best and trending music. Music lovers enjoy songs from different languages, cultures and norms."
     )
   ];
}