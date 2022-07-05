import 'package:edft/localization/localization_service.dart';
import 'package:edft/models/attraction.dart';
import 'package:edft/models/day.dart';
import 'package:edft/models/travel.dart';
import 'package:edft/screens/alert_screen.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ItineraryScreen extends StatefulWidget {
  final Travel travel;
  const ItineraryScreen({Key? key, required this.travel}) : super(key: key);

  @override
  State<ItineraryScreen> createState() => ItineraryScreenState();
}

class ItineraryScreenState extends State<ItineraryScreen> {
  late Future<List<Day>> days;

  @override
  void initState() {
    days = _organizeDays(travel: widget.travel);
    super.initState();
  }

  //Organize Itinerary day-by-day
  Future<List<Day>> _organizeDays({required Travel travel}) async {
    List<Day> res = [];
    List<Attraction> attractions = await travel.getAttractions();
    int dayNumber = 1;
    int numberOfAttractions = attractions.length;
    int totalAdded = 0;

    //Cycle through attraction periods
    while (totalAdded < numberOfAttractions) {
      Day d = Day(dayNumber: dayNumber++);
      for (String period in attractionPeriods) {
        // Get the next attraction by period (morning, mid, afternoon, night)
        Attraction a =
            attractions.firstWhere((attr) => attr.period.contains(period));
        // Add the attraction to Day
        d.attractions.add(a);
        // Remove from the attractions list (avoid duplicates)
        attractions.removeWhere((attr) => attr.id == a.id);
        // Increment total
        totalAdded++;
      }
      res.add(d);
    }
    return res;
  }

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
        child: Column(
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
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Divider(
                color: offWhiteColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<Day>>(
                future: days,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Day>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(LocalizationService.instance
                            .getLocalizedString("no_attractions_added_yet")),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Day d = snapshot.data![index];
                          List<Widget> children = [];
                          children.add(Text(
                            "${LocalizationService.instance.getLocalizedString("day")} ${d.dayNumber}",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ));
                          for (Attraction a in d.attractions) {
                            children.add(DayAttractionEntry(attr: a));
                          }
                          return Column(
                            children: children,
                          );
                        },
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DayAttractionEntry extends StatelessWidget {
  const DayAttractionEntry({
    Key? key,
    required this.attr,
  }) : super(key: key);

  final Attraction attr;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        style: const TextStyle(color: blueColor),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            "${attr.distanceToStayLocation} KM ${LocalizationService.instance.getLocalizedString("from_your_stay_location")}",
            style: const TextStyle(
              color: secondaryColor,
              fontSize: 12,
            ),
          )
        ],
      ),
      trailing: const Text("manhã"),
    );
  }
}
