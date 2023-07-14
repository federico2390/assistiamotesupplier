import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:adminpanel/api/operation.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/state.dart';
import 'package:adminpanel/screens/feed/widgets/top_bar.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/launcher.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';

class OperationDetail extends StatelessWidget {
  const OperationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final operationArguments =
        ModalRoute.of(context)!.settings.arguments as OperationArguments;

    var startDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    var endDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');

    bool isIPad = false;

    if (kIsWeb || Platform.isIOS) {
      final size = MediaQuery.of(context).size;
      if (size.width > 768) {
        isIPad = true;
      }
    }

    return WillPopScope(
      onWillPop: () async => kIsWeb ? false : true,
      child: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: Scaffold(
          appBar: appBar(context),
          body: body(
            operationArguments,
            endDateTimeFormat,
            startDateTimeFormat,
            isIPad,
          ),
        ),
      ),
    );
  }

  Consumer<OperationProvider> body(
    OperationArguments operationArguments,
    DateFormat endDateTimeFormat,
    DateFormat startDateTimeFormat,
    bool isIPad,
  ) {
    return Consumer<OperationProvider>(
      builder: (context, operationProvider, child) {
        Operation operation = operationProvider.operations
            .firstWhere((e) => e.operationId == operationArguments.operationId);

        return refreshPage(
          context,
          operation,
          endDateTimeFormat,
          startDateTimeFormat,
          isIPad,
        );
      },
    );
  }

  RefreshIndicator refreshPage(
    BuildContext context,
    Operation operation,
    DateFormat endDateTimeFormat,
    DateFormat startDateTimeFormat,
    bool isIPad,
  ) {
    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: () => context.read<StateProvider>().buildFuture(context),
      child: Column(
        children: [
          const SizedBox(height: AppConst.padding / 2),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(horizontal: AppConst.padding),
              children: [
                if (operation.closed == 'false' &&
                    operation.supplierAccept!.isEmpty)
                  acceptAnddCancelButtons(operation, context),
                if (operation.closed == 'false' &&
                    operation.supplierAccept!.isEmpty)
                  const SizedBox(height: AppConst.padding),
                if (operation.closed == 'false' &&
                    operation.supplierAccept!.isEmpty)
                  Divider(
                    height: 1,
                    color: AppColors.secondaryColor,
                  ),
                if (operation.closed == 'false' &&
                    operation.supplierAccept!.isEmpty)
                  const SizedBox(height: AppConst.padding),
                if (operation.closed == 'false' &&
                    operation.supplierAccept == 'true')
                  closeButton(operation, context),
                if (operation.closed == 'false' &&
                    operation.supplierAccept == 'true')
                  const SizedBox(height: AppConst.padding),
                if (operation.closed == 'false' &&
                    operation.supplierAccept == 'true')
                  Divider(
                    height: 1,
                    color: AppColors.secondaryColor,
                  ),
                if (operation.closed == 'false' &&
                    operation.supplierAccept == 'true')
                  const SizedBox(height: AppConst.padding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tipo di richiesta',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      operation.requestType!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConst.padding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Richiedente',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      operation.userName!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConst.padding),
                if (operation.countryFrom!.isEmpty &&
                    operation.regionFrom!.isEmpty &&
                    operation.provinceFrom!.isEmpty &&
                    operation.cityFrom!.isEmpty &&
                    operation.addressFrom!.isEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Indirizzo',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchMap(
                              '${operation.userAddress!} ${operation.userCity!} ${operation.userRegion!} ${operation.userCountry!}');
                        },
                        child: Text(
                          '${operation.userAddress!}, ${operation.userCity!}, ${operation.userRegion!}, ${operation.userCountry!}',
                          style: TextStyle(
                            fontSize: 17,
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                if (operation.countryFrom!.isEmpty &&
                    operation.regionFrom!.isEmpty &&
                    operation.provinceFrom!.isEmpty &&
                    operation.cityFrom!.isEmpty &&
                    operation.addressFrom!.isEmpty)
                  const SizedBox(height: AppConst.padding),
                if (operation.countryFrom!.isNotEmpty &&
                    operation.regionFrom!.isNotEmpty &&
                    operation.provinceFrom!.isNotEmpty &&
                    operation.cityFrom!.isNotEmpty &&
                    operation.addressFrom!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Indirizzo di partenza',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchMap(
                              '${operation.addressFrom!} ${operation.cityFrom!} ${operation.regionFrom!} ${operation.countryFrom!}');
                        },
                        child: Text(
                          '${operation.addressFrom!}, ${operation.cityFrom!}, ${operation.regionFrom!}, ${operation.countryFrom!}',
                          style: TextStyle(
                            fontSize: 17,
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppConst.padding),
                      Text(
                        'Indirizzo di arrivo',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchMap(
                              '${operation.addressTo!} ${operation.cityTo!} ${operation.regionTo!} ${operation.countryTo!}');
                        },
                        child: Text(
                          '${operation.addressTo!}, ${operation.cityTo!}, ${operation.regionTo!}, ${operation.countryTo!}',
                          style: TextStyle(
                            fontSize: 17,
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                if (operation.countryFrom!.isNotEmpty &&
                    operation.regionFrom!.isNotEmpty &&
                    operation.provinceFrom!.isNotEmpty &&
                    operation.cityFrom!.isNotEmpty &&
                    operation.addressFrom!.isNotEmpty)
                  const SizedBox(height: AppConst.padding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data di inserimento',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      endDateTimeFormat.format(startDateTimeFormat
                          .parse(operation.createdDateTime!)),
                    ),
                  ],
                ),
                const SizedBox(height: AppConst.padding),
                Divider(
                  height: 1,
                  color: AppColors.secondaryColor,
                ),
                const SizedBox(height: AppConst.padding),
                if (operation.visits!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Servizi',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      const SizedBox(height: AppConst.padding / 2),
                      visits(
                        context,
                        operation,
                        endDateTimeFormat,
                        startDateTimeFormat,
                      ),
                    ],
                  ),
                if (operation.visits!.isNotEmpty)
                  const SizedBox(height: AppConst.padding),
                if (operation.visits!.isNotEmpty)
                  Divider(
                    height: 1,
                    color: AppColors.secondaryColor,
                  ),
                if (operation.visits!.isNotEmpty)
                  const SizedBox(height: AppConst.padding),
                operation.supplierDescription!.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descrizione',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          supplierDescription(operation),
                        ],
                      )
                    : descriptionField(context),
                const SizedBox(height: AppConst.padding * 2),
                Divider(
                  height: 1,
                  color: AppColors.secondaryColor,
                ),
                const SizedBox(height: AppConst.padding * 2),
                operation.closed == 'false'
                    ? operation.supplierDescription!.isEmpty
                        ? saveButton(context, operation)
                        : const SizedBox()
                    : const SizedBox(),
                const SizedBox(height: AppConst.padding * 3)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column descriptionField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inserisci una descrizione di fine servizio',
          style: TextStyle(
            color: AppColors.secondaryColor,
          ),
        ),
        const SizedBox(height: AppConst.padding),
        TextFormField(
          controller: context.read<OperationProvider>().descriptionController,
          focusNode: context.read<OperationProvider>().descriptionNode,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          textCapitalization: TextCapitalization.sentences,
          enableInteractiveSelection: true,
          selectionControls: MaterialTextSelectionControls(),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Il campo non può essere vuoto';
            }
            return null;
          },
          maxLines: null,
          maxLength: null,
          decoration: InputDecoration(
            labelText: 'Descrizione',
            labelStyle: TextStyle(color: AppColors.secondaryColor),
            alignLabelWithHint: true,
            suffixIcon: context
                    .read<OperationProvider>()
                    .descriptionController
                    .text
                    .isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      context
                          .read<OperationProvider>()
                          .descriptionController
                          .clear();
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: AppColors.secondaryColor,
                    ),
                  )
                : null,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.focusedColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.errorColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.errorColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
          ),
        )
      ],
    );
  }

  ReadMoreText supplierDescription(Operation operation) {
    return ReadMoreText(
      operation.supplierDescription!,
      trimLines: 2,
      colorClickableText: AppColors.labelDarkColor,
      trimMode: TrimMode.Line,
      trimCollapsedText: '  altro',
      trimExpandedText: '   meno',
      style: const TextStyle(
        fontSize: 15,
      ),
      moreStyle: TextStyle(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      lessStyle: TextStyle(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }

  TapDebouncer saveButton(BuildContext context, Operation operation) {
    return TapDebouncer(
      onTap: () async {
        if (context
                .read<OperationProvider>()
                .descriptionController
                .text
                .isNotEmpty &&
            operation.closed == 'false') {
          await OperationApi()
              .editOperation(
            context,
            operation,
          )
              .whenComplete(() {
            context.read<OperationProvider>().descriptionController.clear();
            hideKeyboard(context);
          });
        }
      },
      builder: (BuildContext context, TapDebouncerFunc? onTap) {
        return Button(
          color: context
                      .read<OperationProvider>()
                      .descriptionController
                      .text
                      .isNotEmpty &&
                  operation.closed == 'false'
              ? AppColors.primaryColor
              : AppColors.secondaryColor.withOpacity(.5),
          text: 'Salva',
          onPressed: onTap,
        );
      },
    );
  }

  Widget visits(
    BuildContext context,
    Operation operation,
    DateFormat endDateTimeFormat,
    DateFormat startDateTimeFormat,
  ) {
    List<String> description = [];
    List<String> time = [];
    List<String> price = [];

    operation.visits!.split(',').forEach((visitsList) {
      List<String> visits = visitsList.split('§');

      description.add(visits.isNotEmpty ? visits[0] : '');
      time.add(visits.length > 1 ? visits[1] : '');
      price.add(visits.length > 2 ? visits[2] : '');
    });

    int itemCount = description.length;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppConst.padding),
      itemBuilder: (context, index) {
        String desc = description[index];
        String tim = time[index];

        return Card(
          elevation: 7,
          shadowColor: kIsWeb
              ? AppColors.secondaryColor.withOpacity(.5)
              : AppColors.secondaryColor.withOpacity(.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConst.borderRadius),
          ),
          color: AppColors.backgroundColor,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: AppConst.padding, vertical: 0),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.medical_services_rounded,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
            minLeadingWidth: 0,
            title: Text(
              desc,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.labelDarkColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppConst.padding / 4),
                Text(
                  endDateTimeFormat.format(startDateTimeFormat.parse(tim)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward,
              size: 20,
              color: AppColors.secondaryColor.withOpacity(.5),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/visit',
                arguments: VisitArguments(
                  operation: operation,
                  visitDescription: desc,
                  visitDateTime: tim,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Row acceptAnddCancelButtons(Operation operation, BuildContext context) {
    return Row(
      children: [
        TapDebouncer(
          onTap: () async {
            await Alerts.loadingAlert(context,
                title: 'Attendi...', subtitle: 'Accetto la richiesta');

            await OperationApi()
                .markOperationAsAccept(context, operation, 'true')
                .whenComplete(() async {
              context.read<OperationProvider>().descriptionController.clear();
              hideKeyboard(context);
              Alerts.hideAlert();
              await context.read<StateProvider>().buildFuture(context);
              Navigator.of(context).pop(context);
            });
          },
          builder: (BuildContext context, TapDebouncerFunc? onTap) {
            return Expanded(
              child: Button(
                color: AppColors.successColor,
                text: 'Accetta',
                onPressed: onTap,
              ),
            );
          },
        ),
        const SizedBox(width: AppConst.padding),
        TapDebouncer(
          onTap: () async {
            await Alerts.loadingAlert(context,
                title: 'Attendi...', subtitle: 'Rifiuto la richiesta');

            await OperationApi()
                .markOperationAsAccept(context, operation, 'false')
                .whenComplete(() async {
              context.read<OperationProvider>().descriptionController.clear();
              hideKeyboard(context);
              Alerts.hideAlert();
              await context.read<StateProvider>().buildFuture(context);
              Navigator.of(context).pop(context);
            });
          },
          builder: (BuildContext context, TapDebouncerFunc? onTap) {
            return Expanded(
              child: Button(
                color: AppColors.errorColor,
                text: 'Rifiuta',
                onPressed: onTap,
              ),
            );
          },
        ),
      ],
    );
  }

  Row closeButton(Operation operation, BuildContext context) {
    return Row(
      children: [
        TapDebouncer(
          onTap: () async {
            await Alerts.loadingAlert(context,
                title: 'Attendi...', subtitle: 'Chiudo la richiesta');

            await OperationApi()
                .markOperationAsClosed(context, operation, 'true')
                .whenComplete(() async {
              context.read<OperationProvider>().descriptionController.clear();
              hideKeyboard(context);
              Alerts.hideAlert();
              await context.read<StateProvider>().buildFuture(context);
              Navigator.of(context).pop(context);
            });
          },
          builder: (BuildContext context, TapDebouncerFunc? onTap) {
            return Expanded(
              child: Button(
                color: AppColors.errorColor,
                text: 'Chiudi',
                onPressed: onTap,
              ),
            );
          },
        ),
      ],
    );
  }
}
