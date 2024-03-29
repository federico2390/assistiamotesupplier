import 'package:adminpanel/models/visits.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/state.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';

class OperationApi {
  Future<List<Operation>> getOperations(BuildContext context) async {
    List<Operation> operations = [];

    try {
      final user = await context.read<UserProvider>().getLocalUser();

      if (user.supplierId != null && user.supplierId!.isNotEmpty) {
        var response = await AppConst().client.post(
          kIsWeb
              ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
              : Uri.parse(AppConst.operation),
          body: {
            'get_operation': 'get_operation',
            'supplier_email': user.supplierEmail,
            'supplier_cf': user.supplierCf,
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          operations = operationFromJson(response.body);
        } else {
          debugPrint('Can\'t get Operations');
        }
      } else {
        debugPrint('User ID not available to get Operations');
      }
    } catch (error) {
      debugPrint('ERROR_getOperations: $error');
    } finally {
      AppConst().client.close();
    }

    return operations;
  }

  Future editOperation(
    BuildContext context,
    Operation operation,
  ) async {
    var dateTime = DateFormat('dd/MM/yyyy HH:mm:ss');

    try {
      await Alerts.loadingAlert(context,
          title: 'Attendi...', subtitle: 'Modifico la richiesta');

      var requestBody = {
        'edit_operation': 'edit_operation',
        'operation_id': operation.operationId,
        'supplier_description': operation.supplierDescription,
        'updateDateTime': dateTime.format(DateTime.now()),
      };

      var response = await AppConst().client.post(
            kIsWeb
                ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
                : Uri.parse(AppConst.operation),
            body: requestBody,
          );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await Alerts.hideAlert();
        await Alerts.successAlert(context,
            title: 'Modificata', subtitle: 'La richiesta è stata modificata');
      } else {
        debugPrint('Can\'t edit Operation');
      }
    } catch (error) {
      debugPrint('ERROR_editOperation: $error');
    } finally {
      AppConst().client.close();
      await context.read<StateProvider>().buildFuture(context);
    }
  }

  Future markOperationAsOpen(
    BuildContext context,
    Operation operation,
  ) async {
    try {
      var response = await AppConst().client.post(
        kIsWeb
            ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
            : Uri.parse(AppConst.operation),
        body: {
          'mark_as_open': 'mark_as_open',
          'operation_id': operation.operationId,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Operation mark as open');
      } else {
        debugPrint('Can\'t mark as viewed Operation');
      }
    } catch (error) {
      debugPrint('ERROR_markOperationAsOpenh: $error');
    } finally {
      AppConst().client.close();
      await context.read<StateProvider>().buildFuture(context);
    }
  }

  Future markOperationAsAccept(
    BuildContext context,
    Operation operation,
    String accept,
  ) async {
    try {
      var response = await AppConst().client.post(
        kIsWeb
            ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
            : Uri.parse(AppConst.operation),
        body: {
          'mark_as_accept': 'mark_as_accept',
          'operation_id': operation.operationId,
          'supplier_accept': accept,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Operation mark as accept');
      } else {
        debugPrint('Can\'t mark as accept Operation');
      }
    } catch (error) {
      debugPrint('ERROR_markOperationAsAccept: $error');
    } finally {
      AppConst().client.close();
      await context.read<StateProvider>().buildFuture(context);
    }
  }

  Future markOperationAsClosed(
    BuildContext context,
    Operation operation,
    String operationState,
  ) async {
    try {
      var response = await AppConst().client.post(
        kIsWeb
            ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
            : Uri.parse(AppConst.operation),
        body: {
          'mark_as_closed': 'mark_as_closed',
          'operation_id': operation.operationId,
          'closed': operationState,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await Alerts.successAlert(
          context,
          title: 'Chiusa',
          subtitle: 'La richiesta è stata chiusa',
        );
      } else {
        debugPrint('Can\'t close Operation');
      }
    } catch (error) {
      debugPrint('ERROR_markOperationAsClosed: $error');
    } finally {
      AppConst().client.close();
      await context.read<StateProvider>().buildFuture(context);
    }
  }

  Future setVisitsDateTime(
    BuildContext context,
    Operation operation,
    String selectedDateTime,
    Visits visit,
  ) async {
    try {
      var response = await AppConst().client.post(
        kIsWeb
            ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
            : Uri.parse(AppConst.operation),
        body: {
          'set_visit_datetime': 'set_visit_datetime',
          'operation_id': operation.operationId,
          'selectedDateTime': selectedDateTime,
          'visit_name': visit.name,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('DateTime setted to Visits');
      } else {
        debugPrint('Can\'t set DateTime to Visits');
      }
    } catch (error) {
      debugPrint('ERROR_setVisitsDateTime: $error');
    } finally {
      AppConst().client.close();
      await context.read<StateProvider>().buildFuture(context);
    }
  }
}
