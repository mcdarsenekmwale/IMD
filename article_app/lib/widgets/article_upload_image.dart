import 'dart:io';

import 'package:article_app/utils/theme_data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleUploadImage extends StatelessWidget {

  final VoidCallback onTap;
 final Function onClear;
  final List<File> images;

  const ArticleUploadImage({
    Key key,
    @required this.onTap,
    @required this.onClear,
    @required this.images
  }) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          SizedBox(
            width: 5.0,
          ),
          Visibility(
            visible:images.isNotEmpty,
            child: Wrap(
              spacing: 1.5, // gap between adjacent chips
              runSpacing: 1.0, // gap between lines
              children: images.asMap().entries.map(
                    (image)
                =>  ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                    height: 70.0,
                    width: 70.0,
                    margin: EdgeInsets.only(
                        right: 10.0
                    ),
                    child:Visibility(
                        visible: (image) != null,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Image.file(
                                image.value,
                                width: 70.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () async{
                                  onClear(image.key);
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: ThemeDetails.primaryColor,
                                  size: 13.0,),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),
          InkWell(
            child: DottedBorder(
                borderType: BorderType.RRect,
                color: Colors.grey,
                dashPattern: [8, 4],
                strokeWidth: 1.5,
                radius: Radius.circular(6),
                child: Container(
                  child: Center(
                    child: Text(
                      ' + Add Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  height: 70.0,
                  width: 70.0,
                )
            ),
            onTap: onTap
          )

        ]
    );
  }
}
