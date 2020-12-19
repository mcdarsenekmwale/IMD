import 'package:article_app/models/article.dart';
import 'package:article_app/models/person.dart';
import 'package:article_app/utils/constants.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ArticleListCard extends StatelessWidget {

  final Article article;
  final VoidCallback onTap;

  const ArticleListCard({
    Key key,
    @required this.article,
    this.onTap
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Person _person = Provider.of<Person>(context)??Person();

    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: ()=>Navigator.pushNamed(context, '/full-article', arguments: {'article':article, 'tag':'list'}),
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(
          vertical: 5.0
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: "list${article.image}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: article.image.startsWith('https:')?
                  CachedNetworkImageProvider(article.image)
                  :AssetImage(article.image),
                  height: 125.0,
                  width: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:  getCategoryColor(article.categories),
                          maxRadius: 5.0,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(article.categories,
                          style: TextStyle(
                              fontSize: 14.5,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: getCategoryColor(article.categories)
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: _checkIfEditable(_person),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.15,
                          ),
                          InkWell(
                            child: Icon(Icons.edit_location_outlined,
                            color: ThemeDetails.accentColor,
                              size: 20.0,
                            ),
                            onTap: onTap,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  margin:EdgeInsets.symmetric(vertical: 2.0),
                  width: (MediaQuery.of(context).size.width -200),
                  child: Text(article.title,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15.5,
                        fontFamily: 'Poppins',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF)
                    ),
                  ),
                ),

                SizedBox(
                  height: 4.0,
                ),
                Row(
                  children: [
                    Text('by  ${article.author.name.split(' ')[0]}',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade400
                      ),
                    ),
                    SizedBox(
                      width:15.0,
                    ),
                    CircleAvatar(
                      backgroundColor:  Colors.grey.shade300,
                      maxRadius: 5.0,
                    ),
                    SizedBox(
                      width:15.0,
                    ),
                    Text(' ${DateFormat.MMMd().format(article.dateCreated)}',
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade400
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  bool _checkIfEditable(Person _person){
   int _difference =  DateTime.now().difference(article.dateCreated).inMinutes;
   bool _isOwner =  _person.uid == article.author.uid;
   bool _timeElapsed = _difference <= 3;
   return (_isOwner && _timeElapsed);
  }
}
