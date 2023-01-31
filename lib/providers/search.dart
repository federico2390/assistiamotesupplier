import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String _searchText = '';
  String get searchText => _searchText;
  void setSearchText(String text) {
    _searchText = text;
  }

  void clearSearchBar() {
    _searchText = '';
    searchController.clear();
  }

  TextEditingController searchController = TextEditingController();
}
