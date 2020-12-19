import 'package:article_app/models/article.dart';
import 'package:article_app/models/person.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProfileArticlesSection extends StatelessWidget {
  final List<Article> articles;
  final String section;

  const ProfileArticlesSection({
    Key key,
    this.articles : const [],
    @required this.section
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Person _person  = Provider.of<Person>(context);

    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 6.0
            ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Wrap(
                spacing: 4.5, // gap between adjacent chips
                runSpacing: 6.0,
                children: articles.map((article)
                => Visibility(
                  visible: _person.uid == article.author.uid,
                  child: GestureDetector(
                    behavior: HitTestBehavior.deferToChild,
                    onTap: ()=>Navigator.pushNamed(context, '/full-article', arguments: {'article':article, 'tag':section}),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: ThemeDetails.accentColor.withOpacity(0.5)),
                          color: Color(0xFFFFFFfF),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFf6f6fc),
                              offset: Offset(2,3),
                              spreadRadius: 6,
                              blurRadius: 6,
                            )
                          ]
                      ),
                      child: Hero(
                        tag: "$section${article.image}",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: article.image.startsWith('https:')?
                            CachedNetworkImageProvider(article.image)
                                :AssetImage(article.image),
                            height: 160.0,
                            width: size.width*0.305,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                ).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
