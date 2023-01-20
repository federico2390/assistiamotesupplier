import 'package:adminpanel/api/supplier.dart';
import 'package:adminpanel/models/supplier.dart';
import 'package:flutter/material.dart';

class SupplierProvider extends ChangeNotifier {
  List<Supplier> _suppliersType = [];
  List<Supplier> get suppliersType => _suppliersType;

  Future<List<Supplier>> getSupplierType() async {
    List<Supplier> suppliersTypeList = await SupplierApi().getSuppliersType();
    suppliersTypeList
        .sort((a, b) => a.supplierType!.compareTo(b.supplierType!));
    _suppliersType = suppliersTypeList;
    print(DateTime.now());

    notifyListeners();
    return _suppliersType;
  }
}
