import 'package:edft/models/travel.dart';
import 'package:edft/service/travel_service.dart';
import 'package:flutter/material.dart';

class TravelProvider extends ChangeNotifier {
  Travel? _travel;

  Travel get getTravel => _travel!;

  Future<void> refreshTravel(String travelId) async {
    _travel = await TravelService().getTravelDetails(travelId);
    notifyListeners();
  }
}
