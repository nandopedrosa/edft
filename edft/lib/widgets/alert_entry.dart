// ignore_for_file: prefer_const_constructors
import 'package:edft/utils/colors.dart';
import 'package:flutter/material.dart';

class AlertEntry extends StatelessWidget {
  const AlertEntry({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: ListTile(
            title: Text(
              'Muitas atividades',
            ),
            subtitle: Text(
              'Tente remover algumas atividades do seu roteiro.',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
