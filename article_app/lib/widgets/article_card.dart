import 'package:article_app/models/article.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleCard extends StatelessWidget {

  final Article article;

  const ArticleCard({
    Key key,
    @required this.article
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: ()=>Navigator.pushNamed(context, '/full-article', arguments: {'article':article, 'tag':'popular'}),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0
        ),
        width: size.width*0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "popular${article.image}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                    image: AssetImage(article.image),
                    height: size.width*0.5,
                    width: size.width*0.7,
                    fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(article.title,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 17.5,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF030303)
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                Text('by  ${article.author.name}',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600
                  ),
                ),
                Spacer(),
                Text(' ${DateFormat.MMMd().format(article.dateCreated)}',
                  style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  

}
