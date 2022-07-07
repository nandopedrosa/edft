import 'package:edft/localization/localization_service.dart';
import 'package:edft/models/attraction.dart';
import 'package:edft/models/travel.dart';
import 'package:edft/service/user_service.dart';
import 'package:edft/utils/functions.dart';
import 'package:edft/utils/globals.dart';

class AlertService {
  static List<Map<String, String>> alerts = [];

  //Returns an array of {"problem" : ... , "solution" : ...}
  static updateAlerts({
    required Travel travel,
    required int numberOfItineraryDays,
  }) {
    _checkIfEnoughDays(travel, numberOfItineraryDays);
    travel.getAttractions().then((attractions) {
      for (Attraction a in attractions) {
        _checkDistance(travel, a);
        _checkBudget(a);
      }
    });
  }

  static void _checkIfEnoughDays(Travel travel, int numberOfItineraryDays) {
    final arrival = DateTime.parse(travel.arrivalDate!);
    final departure = DateTime.parse(travel.departureDate!);
    final daysOfTravel = departure.difference(arrival).inDays;
    if (numberOfItineraryDays > daysOfTravel) {
      alerts.add({
        "problem": LocalizationService.instance
            .getLocalizedString("not_enough_days_problem"),
        "solution": LocalizationService.instance
            .getLocalizedString("not_enough_days_solution")
      });
    }
  }

  static void _checkDistance(Travel travel, Attraction a) {
    if (travel.transportCode == "foot" &&
        calculateDistance(
                lat1: double.parse(a.latitude),
                lng1: double.parse(a.longitude),
                lat2: double.parse(travel.stayLat!),
                lng2: double.parse(travel.stayLng!)) >
            maxFootDistance) {
      alerts.add({
        "problem": LocalizationService.instance
            .getLocalizedString("attraction_too_far_problem")
            .replaceFirst("#NAME#", a.name),
        "solution": LocalizationService.instance
            .getLocalizedString("attraction_too_far_solution")
      });
    }
  }

  static void _checkBudget(Attraction a) {
    if (a.budget.isNotEmpty) {
      UserService().getUserDetails().then((user) {
        if (int.parse(a.budget) > getBudgetThreshold(user.preferenceBudget)) {
          alerts.add({
            "problem": LocalizationService.instance
                .getLocalizedString("attraction_budget_problem")
                .replaceFirst("#NAME#", a.name),
            "solution": LocalizationService.instance
                .getLocalizedString("attraction_budget_solution")
          });
        }
      });
    }
  }
}
