import 'package:edft/models/attraction.dart';

class Day {
  int dayNumber;
  List<Attraction> attractions = [];
  List<String> periods = []; //each attraction has a period

  Day({
    required this.dayNumber,
  });
}
