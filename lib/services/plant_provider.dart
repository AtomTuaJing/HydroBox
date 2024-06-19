import 'package:flutter/material.dart';

class PlantProvider extends ChangeNotifier {
  String? selectedPlant;

  void changeSelectedPlant(String newPlant) {
    selectedPlant = newPlant;
    print(newPlant);
    notifyListeners();
  }
}
