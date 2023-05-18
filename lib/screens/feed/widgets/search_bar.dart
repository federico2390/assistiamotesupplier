import 'package:flutter/material.dart';

import 'package:adminpanel/utils/search_bar.dart' as search_bar;

import 'package:adminpanel/utils/size.dart';

search_bar.SearchBar feedFilterSearch(BuildContext context) {
  return search_bar.SearchBar(
    width: ScreenSize.width(context),
    placeholder: 'Cerca',
  );
}
