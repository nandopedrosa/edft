// ignore_for_file: prefer_const_constructors

import 'package:edft/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AttractionEntry extends StatelessWidget {
  final bool isAdded;
  const AttractionEntry({
    Key? key,
    required this.isAdded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.zero,
              child: SizedBox(
                child: GFAvatar(
                    backgroundImage: NetworkImage(
                        "https://lh5.googleusercontent.com/p/AF1QipP3ZoWA9bfA1k9p5FVU3d0P7KfInQEjjGng1TLv=w408-h306-k-no"),
                    shape: GFAvatarShape.standard),
              ),
            ),
            title: Text(
              'Chica Bacana',
              style: TextStyle(color: blueColor),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'Restaurante - Comida Típica',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '0,4 KM da sua estadia',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            trailing: isAdded ? Icon(Icons.check) : null,
          ),
        ),
      ],
    );
  }
}
