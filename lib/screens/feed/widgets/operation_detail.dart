import 'dart:io';

import 'package:flutter/cupertino.dart';
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
import 'package:adminpanel/models/visits.dart';
import 'package:adminpanel/providers/location.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/providers/state.dart';
import 'package:adminpanel/screens/feed/widgets/top_bar.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/launcher.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:adminpanel/utils/no_service.dart';
import 'package:adminpanel/utils/size.dart';

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

    return PopScope(
      onPopInvoked: (value) async => kIsWeb ? false : true,
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
                  acceptAndCancelButtons(operation, context),
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
                if (operation.userCountry!.isNotEmpty &&
                    operation.userRegion!.isNotEmpty &&
                    operation.userProvince!.isNotEmpty &&
                    operation.userCity!.isNotEmpty &&
                    operation.userAddress!.isNotEmpty)
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
                              '${operation.userAddress!} ${operation.userCity!} ${operation.userProvince!} ${operation.userRegion!} ${operation.userCountry!}');
                        },
                        child: Text(
                          '${operation.userAddress!}, ${operation.userCity!}, ${operation.userProvince!}, ${operation.userRegion!}, ${operation.userCountry!}',
                          style: TextStyle(
                            fontSize: 17,
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                if (operation.userCountry!.isNotEmpty &&
                    operation.userRegion!.isNotEmpty &&
                    operation.userProvince!.isNotEmpty &&
                    operation.userCity!.isNotEmpty &&
                    operation.userAddress!.isNotEmpty)
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
                              '${operation.addressFrom!} ${operation.cityFrom!} ${operation.provinceFrom!} ${operation.regionFrom!} ${operation.countryFrom!}');
                        },
                        child: Text(
                          '${operation.addressFrom!}, ${operation.cityFrom!}, ${operation.provinceFrom!}, ${operation.regionFrom!}, ${operation.countryFrom!}',
                          style: TextStyle(
                            fontSize: 17,
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (operation.countryTo!.isNotEmpty &&
                    operation.regionTo!.isNotEmpty &&
                    operation.provinceTo!.isNotEmpty &&
                    operation.cityTo!.isNotEmpty &&
                    operation.addressTo!.isNotEmpty)
                  const SizedBox(height: AppConst.padding),
                if (operation.countryTo!.isNotEmpty &&
                    operation.regionTo!.isNotEmpty &&
                    operation.provinceTo!.isNotEmpty &&
                    operation.cityTo!.isNotEmpty &&
                    operation.addressTo!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Indirizzo di arrivo',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchMap(
                              '${operation.addressTo!} ${operation.cityTo!} ${operation.provinceTo!} ${operation.regionTo!} ${operation.countryTo!}');
                        },
                        child: Text(
                          '${operation.addressTo!}, ${operation.cityTo!}, ${operation.provinceTo!}, ${operation.regionTo!}, ${operation.countryTo!}',
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
                if (operation.visits!.isNotEmpty || operation.cost!.isNotEmpty)
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
                if (operation.visits!.isNotEmpty ||
                    operation.cost!.isNotEmpty && operation.closed == 'false')
                  const SizedBox(height: AppConst.padding),
                if (operation.visits!.isNotEmpty ||
                    operation.cost!.isNotEmpty && operation.closed == 'false')
                  Divider(
                    height: 1,
                    color: AppColors.secondaryColor,
                  ),
                if (operation.visits!.isNotEmpty ||
                    operation.cost!.isNotEmpty && operation.closed == 'false')
                  const SizedBox(height: AppConst.padding),
                if (operation.supplierDescription!.isNotEmpty)
                  Column(
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
                else if (operation.closed == 'false')
                  descriptionField(context),
                if (operation.closed == 'false')
                  if (operation.supplierDescription!.isEmpty)
                    const SizedBox(height: AppConst.padding),
                // if (operation.closed == 'false')
                //   if (operation.supplierDescription!.isEmpty)
                //     Divider(
                //       height: 1,
                //       color: AppColors.secondaryColor,
                //     ),
                // const SizedBox(height: AppConst.padding * 2),
                if (operation.closed == 'false')
                  if (operation.supplierDescription!.isEmpty)
                    saveButton(context, operation),
                if (operation.closed == 'false')
                  if (operation.supplierDescription!.isEmpty)
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
        Text(
          'Attenzione: Una volta che contrassegnerai la visita come chiusa, '
          'non sarai più in grado di inserire ulteriori informazioni.',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.bold,
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
                        .isNotEmpty ||
                    context
                            .read<OperationProvider>()
                            .descriptionController
                            .text !=
                        ''
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
            operation.closed == 'false' &&
            operation.supplierAccept! == 'true') {
          await OperationApi()
              .editOperation(
            context,
            Operation(
              operationId: operation.operationId,
              supplierDescription:
                  context.read<OperationProvider>().descriptionController.text,
            ),
          )
              .whenComplete(() {
            context.read<OperationProvider>().descriptionController.clear();
            hideKeyboard(context);
          });
        } else {
          Alerts.errorAlert(context,
              title: 'Attenzione', subtitle: 'Devi inserire una descrizione');
        }
      },
      builder: (BuildContext context, TapDebouncerFunc? onTap) {
        return Button(
          color: context
                      .read<OperationProvider>()
                      .descriptionController
                      .text
                      .isNotEmpty &&
                  operation.closed == 'false' &&
                  operation.supplierAccept! == 'true'
              ? AppColors.primaryColor
              : AppColors.secondaryColor.withOpacity(.5),
          text: 'Salva descrizione',
          onPressed: onTap,
        );
      },
    );
  }

  _showMaterialDatePicker(
      BuildContext context, Operation operation, Visits visit) async {
    DateTime now = DateTime.now();
    TimeOfDay timeNow = TimeOfDay.now();
    DateTime? selectedDateTime;

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      currentDate: now,
      cancelText: 'Annulla',
      confirmText: 'Conferma',
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: timeNow,
        helpText: 'Aiuto',
        hourLabelText: 'Ore',
        minuteLabelText: 'Minuti',
        cancelText: 'Annulla',
        confirmText: 'Conferma',
        errorInvalidText: 'Data non valida',
      );

      if (selectedTime != null) {
        final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

        selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        final selectedDT = dateFormat.format(selectedDateTime);
        OperationApi().setVisitsDateTime(context, operation, selectedDT, visit);
      }
    }
  }

  _showCupertinoDatePicker(
      BuildContext context, Operation operation, Visits visit) async {
    DateTime now = DateTime.now();
    DateTime? selectedDateTime;

    return await showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (_) => Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: ScreenSize.height(context) / 3,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(AppConst.borderRadius),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CupertinoButton(
                  child: Text(
                    'Annulla',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(),
                CupertinoButton(
                  child: const Text(
                    'Conferma',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
                    if (selectedDateTime != null) {
                      final selectedDate = dateFormat.format(selectedDateTime!);
                      OperationApi().setVisitsDateTime(
                          context, operation, selectedDate, visit);
                    } else {
                      final selectedDate = dateFormat.format(now);
                      OperationApi().setVisitsDateTime(
                          context, operation, selectedDate, visit);
                    }

                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: now,
                minimumDate: now,
                use24hFormat: true,
                onDateTimeChanged: (val) {
                  selectedDateTime = val;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField supplierSetVisitsDate(
      BuildContext context, Operation operation, Visits visit) {
    return TextFormField(
      readOnly: true,
      controller: context.read<OperationProvider>().dateTimeController,
      focusNode: context.read<OperationProvider>().dateTimeNode,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      enableInteractiveSelection: true,
      selectionControls: MaterialTextSelectionControls(),
      onTap: () {
        if (Platform.isAndroid) {
          _showMaterialDatePicker(context, operation, visit);
        } else {
          _showCupertinoDatePicker(context, operation, visit);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Il campo non può essere vuoto';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Data della visita',
        labelStyle: TextStyle(color: AppColors.secondaryColor),
        alignLabelWithHint: true,
        suffixIcon: context
                    .read<OperationProvider>()
                    .dateTimeController
                    .text
                    .isNotEmpty ||
                context.read<OperationProvider>().dateTimeController.text != ''
            ? GestureDetector(
                onTap: () {
                  context.read<OperationProvider>().dateTimeController.clear();
                },
                child: Icon(
                  Icons.cancel_rounded,
                  color: AppColors.secondaryColor,
                ),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryColor),
          borderRadius: BorderRadius.circular(AppConst.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryColor),
          borderRadius: BorderRadius.circular(AppConst.borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor),
          borderRadius: BorderRadius.circular(AppConst.borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor),
          borderRadius: BorderRadius.circular(AppConst.borderRadius),
        ),
      ),
    );
  }

  Widget visits(
    BuildContext context,
    Operation operation,
    DateFormat endDateTimeFormat,
    DateFormat startDateTimeFormat,
  ) {
    List<Visits> visits = [];

    if (operation.visits!.isNotEmpty) {
      List<String> visitList = operation.visits!.contains(',')
          ? operation.visits!.split(',')
          : [operation.visits!];
      List<String> signedUrlList = operation.signedUrl!.contains(',')
          ? operation.signedUrl!.split(',')
          : [operation.signedUrl!];
      List<String> signedDateTimeList = operation.signedDateTime!.contains(',')
          ? operation.signedDateTime!.split(',')
          : [operation.signedDateTime!];

      for (int i = 0; i < visitList.length; i++) {
        var visitFields = visitList[i].split('§');

        String visitsDescription = visitFields[0];
        DateTime? visitsTime;
        DateTime? visitsSignedDateTime;

        if (visitFields.length >= 2) {
          try {
            var parsedDate = startDateTimeFormat.parse(visitFields[1]);
            visitsTime = parsedDate;
          } catch (e) {
            // print(e);
          }
        }

        String? signedUrl = signedUrlList.length > i ? signedUrlList[i] : null;

        try {
          var parsedDate = startDateTimeFormat.parse(signedDateTimeList[i]);
          visitsSignedDateTime = parsedDate;
        } catch (e) {
          // print(e);
        }

        visits.add(
          Visits(
            name: visitsDescription,
            time: visitsTime,
            signedUrl: signedUrl,
            signedDateTime: visitsSignedDateTime,
          ),
        );
      }
    } else {
      visits.add(
        Visits(
          name: operation.requestType,
          time: startDateTimeFormat.parse(operation.currentDateTime!),
          signedUrl: operation.signedUrl!,
          signedDateTime: operation.signedDateTime!.isNotEmpty
              ? startDateTimeFormat.parse(operation.signedDateTime!)
              : null,
        ),
      );
    }

    int itemCount = visits.length;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppConst.padding),
      itemBuilder: (context, index) {
        Visits visit = visits[index];

        return Card(
          elevation: 7,
          shadowColor: kIsWeb
              ? AppColors.secondaryColor.withOpacity(.5)
              : AppColors.secondaryColor.withOpacity(.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConst.borderRadius),
          ),
          color: AppColors.backgroundColor,
          child: Column(
            children: [
              if (visit.time == null) const SizedBox(height: AppConst.padding),
              if (visit.time == null)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppConst.padding),
                  child: supplierSetVisitsDate(context, operation, visit),
                ),
              if (visit.time == null)
                const SizedBox(height: AppConst.padding / 2),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: AppConst.padding),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services_rounded,
                      color: (operation.closed == 'true')
                          ? AppColors.secondaryColor.withOpacity(.5)
                          : (visit.signedUrl == null ||
                                      visit.signedUrl!.isEmpty) &&
                                  visit.time != null
                              ? AppColors.primaryColor
                              : AppColors.secondaryColor.withOpacity(.5),
                    ),
                  ],
                ),
                minLeadingWidth: 0,
                title: Text(
                  visit.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (operation.closed == 'true')
                        ? AppColors.secondaryColor.withOpacity(.5)
                        : (visit.signedUrl == null ||
                                    visit.signedUrl!.isEmpty) &&
                                visit.time != null
                            ? AppColors.labelDarkColor
                            : AppColors.secondaryColor.withOpacity(.5),
                  ),
                ),
                subtitle: visit.time != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppConst.padding / 4),
                          Text(
                            endDateTimeFormat.format(visit.time!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: (operation.closed == 'true')
                                  ? AppColors.secondaryColor.withOpacity(.5)
                                  : (visit.signedUrl == null ||
                                              visit.signedUrl!.isEmpty) &&
                                          visit.time != null
                                      ? AppColors.secondaryColor
                                      : AppColors.secondaryColor
                                          .withOpacity(.5),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    : null,
                trailing: (operation.closed == 'true')
                    ? null
                    : (visit.signedUrl == null || visit.signedUrl!.isEmpty) &&
                            visit.time != null
                        ? Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: AppColors.secondaryColor.withOpacity(.5),
                          )
                        : null,
                onTap: (operation.closed == 'false' &&
                        operation.supplierAccept! == 'true')
                    ? (visit.signedUrl == null || visit.signedUrl!.isEmpty) &&
                            visit.time != null
                        ? () async {
                            if (operation.requestTypeService !=
                                'Trasporto sanitario') {
                              await Alerts.hideAlert();
                              Navigator.pushNamed(
                                context,
                                '/visit',
                                arguments: VisitArguments(
                                  operation: operation,
                                  visitDescription: visit.name,
                                  visitDateTime:
                                      startDateTimeFormat.format(visit.time!),
                                  visitIndex: index,
                                ),
                              );
                            } else {
                              if (operation.userCountry!.isNotEmpty &&
                                  operation.userRegion!.isNotEmpty &&
                                  operation.userProvince!.isNotEmpty &&
                                  operation.userCity!.isNotEmpty &&
                                  operation.userAddress!.isNotEmpty) {
                                await Alerts.hideAlert();
                                await Alerts.loadingAlert(
                                  context,
                                  title: 'Attendi',
                                  subtitle: 'Determino la tua posizione',
                                );

                                final locationProvider =
                                    Provider.of<LocationProvider>(context,
                                        listen: false);
                                locationProvider
                                    .checkLocationPermission(
                                        '${operation.userAddress!}, ${operation.userCity!}, ${operation.userProvince!}, ${operation.userRegion!}, ${operation.userCountry!}')
                                    .then((permisison) async {
                                  if (permisison == true) {
                                    final settingProvider =
                                        Provider.of<SettingProvider>(context,
                                            listen: false);

                                    if (locationProvider.distance >
                                        double.parse(settingProvider
                                            .setting.settingsMeters!)) {
                                      await Alerts.hideAlert();
                                      if (ModalRoute.of(context)!.isCurrent) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            fullscreenDialog: true,
                                            settings: const RouteSettings(
                                                name: 'noservice'),
                                            builder: (context) =>
                                                const NoService(),
                                          ),
                                        );
                                      }
                                    } else if (locationProvider.distance <
                                        double.parse(settingProvider
                                            .setting.settingsMeters!)) {
                                      await Alerts.hideAlert();
                                      Navigator.pushNamed(
                                        context,
                                        '/visit',
                                        arguments: VisitArguments(
                                          operation: operation,
                                          visitDescription: visit.name,
                                          visitDateTime: startDateTimeFormat
                                              .format(visit.time!),
                                          visitIndex: index,
                                        ),
                                      );
                                    }
                                  } else {
                                    await Alerts.hideAlert();
                                    await Alerts.errorAlert(
                                      context,
                                      title: 'Attenzione',
                                      subtitle:
                                          'Non riesco a determinare la tua posisiozne',
                                    );
                                  }
                                });
                              } else if (operation.regionFrom!.isNotEmpty &&
                                  operation.regionFrom!.isNotEmpty &&
                                  operation.provinceFrom!.isNotEmpty &&
                                  operation.cityFrom!.isNotEmpty &&
                                  operation.addressFrom!.isNotEmpty) {
                                await Alerts.hideAlert();
                                await Alerts.loadingAlert(
                                  context,
                                  title: 'Attendi',
                                  subtitle: 'Determino la tua posizione',
                                );

                                final locationProvider =
                                    Provider.of<LocationProvider>(context,
                                        listen: false);
                                locationProvider
                                    .checkLocationPermission(
                                        '${operation.addressFrom!}, ${operation.cityFrom!}, ${operation.provinceFrom!}, ${operation.regionFrom!}, ${operation.regionFrom!}')
                                    .then((permisison) async {
                                  if (permisison == true) {
                                    final settingProvider =
                                        Provider.of<SettingProvider>(context,
                                            listen: false);

                                    if (locationProvider.distance >
                                        double.parse(settingProvider
                                            .setting.settingsMeters!)) {
                                      await Alerts.hideAlert();
                                      if (ModalRoute.of(context)!.isCurrent) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            fullscreenDialog: true,
                                            settings: const RouteSettings(
                                                name: 'noservice'),
                                            builder: (context) =>
                                                const NoService(),
                                          ),
                                        );
                                      }
                                    } else if (locationProvider.distance <
                                        double.parse(settingProvider
                                            .setting.settingsMeters!)) {
                                      await Alerts.hideAlert();
                                      Navigator.pushNamed(
                                        context,
                                        '/visit',
                                        arguments: VisitArguments(
                                          operation: operation,
                                          visitDescription: visit.name,
                                          visitDateTime: startDateTimeFormat
                                              .format(visit.time!),
                                          visitIndex: index,
                                        ),
                                      );
                                    }
                                  } else {
                                    await Alerts.hideAlert();
                                    await Alerts.errorAlert(
                                      context,
                                      title: 'Attenzione',
                                      subtitle:
                                          'Non riesco a determinare la tua posisiozne',
                                    );
                                  }
                                });
                              } else {
                                await Alerts.errorAlert(
                                  context,
                                  title: 'Attenzione',
                                  subtitle:
                                      'Firma non accessibile\nL\'indirizzo è assente',
                                );
                              }
                            }
                          }
                        : (visit.signedUrl != null)
                            ? () async {
                                await Alerts.errorAlert(
                                  context,
                                  title: 'Attenzione',
                                  subtitle: 'Hai già firmato questa visita',
                                );
                              }
                            : () async {
                                await Alerts.errorAlert(
                                  context,
                                  title: 'Attenzione',
                                  subtitle:
                                      'Devi inserire la data della visita',
                                );
                              }
                    : (operation.closed == 'true')
                        ? () async {
                            await Alerts.errorAlert(
                              context,
                              title: 'Attenzione',
                              subtitle: 'Hai già firmato questa visita',
                            );
                          }
                        : () async {
                            await Alerts.errorAlert(
                              context,
                              title: 'Attenzione',
                              subtitle: 'Devi prima accettare la visita',
                            );
                          },
              ),
              if (visit.time == null)
                const SizedBox(height: AppConst.padding / 2.5),
            ],
          ),
        );
      },
    );
  }

  Row acceptAndCancelButtons(Operation operation, BuildContext context) {
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
              // Navigator.of(context).pop(context);
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
              // Navigator.of(context).pop(context);
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
