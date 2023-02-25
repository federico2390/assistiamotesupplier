import 'package:adminpanel/api/palace.dart';
import 'package:adminpanel/models/palace.dart';
import 'package:flutter/material.dart';

class PalaceProvider extends ChangeNotifier {
  List<Palace> _palaces = [];
  List<Palace> get palaces => _palaces;
  Future<List<Palace>> getPalaces(BuildContext context) async {
    List<Palace> palaceList = await PalaceApi().getPalaces(context);

    palaceList.sort((a, b) => a.palaceAddress!.compareTo(b.palaceAddress!));
    _palaces = palaceList;

    if (palaceList.length == 1) {
      setSelectedPalace(0);
    }

    notifyListeners();
    return _palaces;
  }

  Palace _palace = Palace();
  Palace get palace => _palace;
  void setPalace(Palace pal) {
    _palace = pal;
    notifyListeners();
  }

  int? _selectedPalace = 0;
  int get selectedPalace => _selectedPalace!;
  void setSelectedPalace(int index) {
    _selectedPalace = index;
    setPalace(_palaces[index]);
    notifyListeners();
  }
}
