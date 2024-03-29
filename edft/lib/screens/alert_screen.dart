// ignore_for_file: avoid_print
import 'package:edft/service/alert_service.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/alert_entry.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import '../localization/localization_service.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  State<AlertScreen> createState() => AlertScreenState();
}

class AlertScreenState extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const MyBottomNavigationBar(currentPage: homePageIndex),
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: appBarTitle,
        title: Text(
          LocalizationService.instance.getLocalizedString("alerts"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: AlertService.alerts.length,
          itemBuilder: (BuildContext ctx, int index) {
            List<Widget> children = [];
            Map<String, String> alertMap = AlertService.alerts[index];

            String problem = alertMap["problem"]!;
            String solution = alertMap["solution"]!;
            children.add(AlertEntry(problem: problem, solution: solution));
            children.add(const Divider(color: offWhiteColor));

            return Column(children: children);
          },
        ),
      ),
    );
  }
}
