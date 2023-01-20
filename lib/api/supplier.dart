import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/supplier.dart';
import 'package:http/http.dart' as http;

class SupplierApi {
  Future<List<Supplier>> getSuppliersType() async {
    List<Supplier> suppliersType = [];

    try {
      var response = await http.post(
        Uri.parse(AppConst.supplier),
        body: {
          "get_supplier_type": 'get_supplier_type',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        suppliersType = supplierFromJson(response.body);
      } else {
        print('Can\'t get SuppliersType');
      }
    } catch (error) {
      print('ERROR_getSuppliersType: $error');
    }
    return suppliersType;
  }
}
