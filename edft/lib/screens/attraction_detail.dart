// ignore_for_file: avoid_print

import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import '../localization/localization_service.dart';

class AttractionDetail extends StatefulWidget {
  final String attractionTitle;
  final bool isAdded;
  const AttractionDetail({
    Key? key,
    required this.attractionTitle,
    required this.isAdded,
  }) : super(key: key);

  @override
  State<AttractionDetail> createState() => AttractionDetailState();
}

class AttractionDetailState extends State<AttractionDetail> {
  late String attractionTitle = widget.attractionTitle;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const MyBottomNavigationBar(currentPage: aboutPageIndex),
      appBar: AppBar(
        actions: <Widget>[
          Center(
            child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    //TODO: implementar add attraction to trip
                    print("adicionou atracao");
                  },
                  child: widget.isAdded
                      ? Text(
                          LocalizationService.instance
                              .getLocalizedString("remove"),
                          style: const TextStyle(color: blueColor),
                        )
                      : Text(
                          LocalizationService.instance
                              .getLocalizedString("add"),
                          style: const TextStyle(color: blueColor),
                        ),
                )),
          )
        ],
        titleTextStyle: appBarTitle,
        centerTitle: false,
        title:
            Text(LocalizationService.instance.getLocalizedString("attraction")),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  attractionTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  LocalizationService.instance
                      .getLocalizedString("lorem_ipsum"),
                  style: const TextStyle(color: Colors.white70),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
            ],
          )),
    );
  }
}
