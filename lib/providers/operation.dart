import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:adminpanel/api/operation.dart';
import 'package:adminpanel/models/operation.dart';

class OperationProvider extends ChangeNotifier {
  List<Operation> _notAccept = [];
  List<Operation> get notAccept => _notAccept;

  List<Operation> _accept = [];
  List<Operation> get accept => _accept;

  List<Operation> _closed = [];
  List<Operation> get closed => _closed;

  List<Operation> _operations = [];
  List<Operation> get operations => _operations;

  Future<List<Operation>> getOperations(BuildContext context) async {
    try {
      List<Operation> operationList =
          await OperationApi().getOperations(context);

      operationList.sort(
        (a, b) => DateTime.parse(
          DateFormat('dd/MM/yyyy HH:mm:ss')
              .parse(b.updateDateTime!.isNotEmpty
                  ? b.updateDateTime!
                  : b.currentDateTime!)
              .toIso8601String(),
        ).compareTo(
          DateTime.parse(
            DateFormat('dd/MM/yyyy HH:mm:ss')
                .parse(a.updateDateTime!.isNotEmpty
                    ? a.updateDateTime!
                    : a.currentDateTime!)
                .toIso8601String(),
          ),
        ),
      );

      operationList.sort((a, b) =>
          (a.supplierOpen == 'false' ? 0 : 1) -
          (b.supplierOpen == 'false' ? 0 : 1));

      _operations = operationList;

      _notAccept = operationList
          .where(
            (e) => e.supplierAccept == 'false' && e.closed == 'false',
          )
          .toList();

      _accept = operationList
          .where(
            (e) => e.supplierAccept == "true" && e.closed == 'false',
          )
          .toList();

      _closed = operationList
          .where(
            (e) => e.closed == "true",
          )
          .toList();
    } catch (error) {
      print(error);
    }

    notifyListeners();
    return _operations;
  }

  void cancelOperations() {
    _operations.clear();
    notifyListeners();
  }

  int _selectedSegment = 1;
  int get selectedSegment => _selectedSegment;

  void setSelectedSegment(int index) {
    _selectedSegment = index;
    notifyListeners();
  }

  String _selectedOperation = 'Medico/Specialista a domicilio';
  String get selectedOperation => _selectedOperation;
  void setSelectedOperation(String setOperation) {
    _selectedOperation = setOperation;
    notifyListeners();
  }

  final TextEditingController descriptionController = TextEditingController();
  final FocusNode descriptionNode = FocusNode();

  final TextEditingController dateController = TextEditingController();
  final FocusNode dateNode = FocusNode();

  List<TextEditingController> visitsControllers = [];
  List<FocusNode> visitsFocusNodes = [];
  void addTextField({
    String visitsDescription = '',
  }) {
    final visitsController = TextEditingController(text: visitsDescription);
    visitsControllers.add(visitsController);
    notifyListeners();
  }

  void removeTextField(int index) {
    final removedVisitsController = visitsControllers.removeAt(index);
    final removedVisitsFocusNode = visitsFocusNodes.removeAt(index);
    removedVisitsController.dispose();
    removedVisitsFocusNode.dispose();
    notifyListeners();
  }

  List<String> concatenateVisitsAndVisitsTimeControllers() {
    List<String> concatenatedList = [];
    for (int i = 0; i < visitsControllers.length; i++) {
      if (visitsControllers[i].text.isNotEmpty) {
        String concatenatedString = '${visitsControllers[i].text}}';
        concatenatedList.add(concatenatedString);
      }
    }
    return concatenatedList;
  }

  void removeAllTextField() {
    visitsControllers.clear();
    visitsFocusNodes.clear();
  }
}
