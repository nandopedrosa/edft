import 'package:edft/localization/localization_service.dart';
import 'package:edft/screens/alert_screen.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({Key? key}) : super(key: key);

  @override
  State<ItineraryScreen> createState() => ItineraryScreenState();
}

class ItineraryScreenState extends State<ItineraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const MyBottomNavigationBar(currentPage: aboutPageIndex),
      appBar: AppBar(
        titleTextStyle: appBarTitle,
        centerTitle: true,
        title: Text(
          LocalizationService.instance.getLocalizedString("itinerary"),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AlertScreen(),
                    ),
                  );
                },
                child: const ListTile(
                  title: Text('Alertas'),
                  subtitle: Text(
                    'Encontramos alguns alertas para sua viagem. Clique aqui para vê-los.',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Icon(
                    Icons.warning,
                    color: warningColor,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Divider(
                  color: offWhiteColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Dia 1",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Table(
                  border: const TableBorder(
                    horizontalInside: BorderSide(
                      color: secondaryColor,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(100),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                            child: Text(
                          LocalizationService.instance
                              .getLocalizedString("time"),
                          textAlign: TextAlign.center,
                        )),
                        TableCell(
                            child: Text(
                          LocalizationService.instance
                              .getLocalizedString("activity"),
                        )),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                            child: Text(
                          "2:30 PM",
                          textAlign: TextAlign.center,
                        )),
                        TableCell(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            LocalizationService.instance
                                .getLocalizedString("lorem_ipsum_small"),
                            style: const TextStyle(color: secondaryColor),
                          ),
                        )),
                      ],
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
