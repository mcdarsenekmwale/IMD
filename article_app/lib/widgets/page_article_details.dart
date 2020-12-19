import 'package:article_app/models/article.dart';
import 'package:article_app/utils/constants.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageArticleDetails extends StatelessWidget {
  final Article article;

  const PageArticleDetails({
    Key key,
    @required this.article
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List images = [];
    images.clear();
    for(int i = 0; i < 2 ; i++){
      if(article.likes.length == 1)
        images.add(article.likes[i].avatar);
      else if (article.likes.length > 1)
        images.add(article.likes[i].avatar);
      else
        images.add('http://via.placeholder.com/300x300');
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
                Container(
                  width: size.width*0.23,
                  child: Visibility(
                    visible: article.likes.isNotEmpty,
                    child: Stack(
                      children:<Widget>[
                          Container(
                            height: 43.0,
                            width: 43.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:CachedNetworkImageProvider(images[0]),
                                    fit: BoxFit.cover
                                ),
                                border: Border.all(color:ThemeDetails.yellowColor.withOpacity(0.8), width: 1.0)
                            ),
                          ),
                          Positioned(
                            right: 24.0,
                            child: Visibility(
                              visible: article.likes.length > 1,
                              child: Container(
                                height: 43.0,
                                width: 43.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image:CachedNetworkImageProvider(images[1]),
                                        fit: BoxFit.cover
                                    ),
                                    border: Border.all(color:ThemeDetails.yellowColor.withOpacity(0.8), width: 1.0)
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0.0,
                            child: Visibility(
                              visible: article.likes.length > 2,
                              child: CircleAvatar(
                                backgroundColor: ThemeDetails.yellowColor,
                                child: Text("${article.likes.length -2}+",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0
                                  ),
                                ),
                                maxRadius: 21.5,
                              ),
                            ),
                          )

                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: size.width*0.8,
            child: Text(article.title,
              maxLines: 5,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 17.5,
                  fontFamily: 'Poppins',
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF)
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: ()=>Navigator.pushNamed(context, '/authors', arguments: article.author),
                child: Text('by  ${article.author.name}',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade400
                  ),
                ),
              ),
              SizedBox(
                width:15.0,
              ),
              CircleAvatar(
                backgroundColor:  Colors.grey.shade300,
                maxRadius: 2.0,
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
      ),
    );
  }
}
