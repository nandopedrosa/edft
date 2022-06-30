// ignore_for_file: prefer_const_constructors

import 'package:edft/localization/localization_service.dart';
import 'package:edft/models/attraction.dart';
import 'package:edft/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AttractionEntry extends StatelessWidget {
  final Attraction attr;
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
    required this.attr,
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
                        attr.image.isNotEmpty ? NetworkImage(attr.image) : null,
                    shape: GFAvatarShape.standard),
              ),
            ),
            title: Text(
              attr.name,
              style: TextStyle(color: blueColor),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  LocalizationService.instance
                          .getLocalizedString(attr.category) +
                      budgetDollarMap[attr.budget]!,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${attr.distanceToStayLocation} KM ${LocalizationService.instance.getLocalizedString("from_your_stay_location")}",
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            trailing: attr.isAdded!
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
