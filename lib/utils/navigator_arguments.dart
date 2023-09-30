import 'package:adminpanel/models/operation.dart';

class OperationArguments {
  final String operationId;

  OperationArguments(
    this.operationId,
  );
}

class VisitArguments {
  final Operation? operation;
  final String? visitDescription;
  final String? visitDateTime;
  final int? visitIndex;

  VisitArguments({
    this.operation,
    this.visitDescription,
    this.visitDateTime,
    this.visitIndex,
  });
}
