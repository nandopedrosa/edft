// ignore_for_file: prefer_const_constructors

import 'package:edft/localization/localization_service.dart';
import 'package:edft/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AttractionEntry extends StatelessWidget {
  final bool isAdded;
  final String image;
  final String name;
  final String address;
  final String budget;
  final String category;
  final Map<String, String> budgetDollarMap = {
    "": "",
    "1": r" - $",
    "2": r" - $$",
    "3": r" - $$$",
    "4": r" - $$$$",
    "5": r" - $$$$$",
  };
  AttractionEntry({
    Key? key,
    required this.name,
    required this.image,
    required this.address,
    required this.budget,
    required this.category,
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
                    backgroundImage:
                        image.isNotEmpty ? NetworkImage(image) : null,
                    shape: GFAvatarShape.standard),
              ),
            ),
            title: Text(
              name,
              style: TextStyle(color: blueColor),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  LocalizationService.instance.getLocalizedString(category) +
                      budgetDollarMap[budget]!,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  address,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            trailing: isAdded
                ? Icon(
                    Icons.check,
                    color: successColor,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
