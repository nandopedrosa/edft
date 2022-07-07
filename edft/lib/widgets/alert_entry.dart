// ignore_for_file: prefer_const_constructors
import 'package:edft/utils/colors.dart';
import 'package:flutter/material.dart';

class AlertEntry extends StatelessWidget {
  final String problem;
  final String solution;
  const AlertEntry({
    Key? key,
    required this.problem,
    required this.solution,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: ListTile(
            title: Text(problem),
            subtitle: Text(
              solution,
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
