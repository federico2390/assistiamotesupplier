import 'package:flutter/material.dart';

import 'package:adminpanel/utils/search_bar.dart';
import 'package:adminpanel/utils/size.dart';

SearchBar feedFilterSearch(BuildContext context) {
  return SearchBar(
    width: ScreenSize.width(context),
    placeholder: 'Cerca',
  );
}
