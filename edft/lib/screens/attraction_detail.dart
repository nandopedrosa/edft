// ignore_for_file: avoid_print, must_be_immutable

import 'package:edft/models/attraction.dart';
import 'package:edft/providers/travel_provider.dart';
import 'package:edft/service/travel_service.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/functions.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/localization_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AttractionDetail extends StatefulWidget {
  final Attraction attr;
  const AttractionDetail({
    Key? key,
    required this.attr,
  }) : super(key: key);

  @override
  State<AttractionDetail> createState() => AttractionDetailState();
}

class AttractionDetailState extends State<AttractionDetail> {
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
              padding: const EdgeInsets.only(right: 30),
              child: GestureDetector(
                onTap: () {
                  String? travelId =
                      Provider.of<TravelProvider>(context, listen: false)
                          .getTravel!
                          .id;
                  TravelService().addOrRemoveAttraction(
                      travelId: travelId!,
                      attractionId: widget.attr.id,
                      isAdded: widget.attr.isAdded!,
                      context: context);
                  String? msg;
                  if (widget.attr.isAdded!) {
                    msg = LocalizationService.instance
                        .getLocalizedString("attraction_removed");
                  } else {
                    msg = LocalizationService.instance
                        .getLocalizedString("attraction_added");
                  }
                  showSnackBar(context, msg, "success");
                  setState(() {
                    widget.attr.isAdded = !widget.attr.isAdded!;
                  });
                },
                child: widget.attr.isAdded!
                    ? Text(
                        LocalizationService.instance
                            .getLocalizedString("remove"),
                        style: const TextStyle(color: blueColor),
                      )
                    : Text(
                        LocalizationService.instance.getLocalizedString("add"),
                        style: const TextStyle(color: blueColor),
                      ),
              ),
            ),
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
                  widget.attr.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.attr.description,
                  style: const TextStyle(color: Colors.white70),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (widget.attr.url.isNotEmpty) {
                    final Uri uri = Uri.parse(widget.attr.url);
                    await launchUrl(uri);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocalizationService.instance
                          .getLocalizedString("click_here_for_more_details"),
                      style: const TextStyle(color: blueColor),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(
                      Icons.open_in_browser,
                      color: blueColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          )),
    );
  }
}
