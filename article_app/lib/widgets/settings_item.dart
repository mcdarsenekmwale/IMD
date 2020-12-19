import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {

  final VoidCallback onTap;
  final bool isActive;
  final ValueChanged valueChanged;
  final String title;
  final bool isTouched;

  const SettingsItem({Key key,
    this.onTap,
    this.isActive : false,
    this.valueChanged,
    @required this.title,
     this.isTouched : true
  }):
        assert(title != null),
        assert(isTouched != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(2.0),
        margin: isTouched? EdgeInsets.symmetric(
            vertical: 5.0
        ):EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 8.0,),
            Expanded(
              child: Text(title,
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(2.0),
              child: Visibility(
                visible: isTouched,
                child: Icon(
                  Icons.chevron_right_outlined,
                  color: Colors.grey.shade600,
                  size: 22.0,
                ),
                replacement: Switch(
                    value: isActive,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor:Theme.of(context).primaryColor,
                    onChanged: valueChanged
                ) ,
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
