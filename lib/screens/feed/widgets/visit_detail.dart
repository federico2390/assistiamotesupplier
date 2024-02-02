import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:adminpanel/api/sign.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/location.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/providers/signature.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:adminpanel/utils/no_service.dart';
import 'package:adminpanel/utils/size.dart';

class VisitDetail extends StatefulWidget {
  const VisitDetail({super.key});

  @override
  State<VisitDetail> createState() => _VisitDetailState();
}

class _VisitDetailState extends State<VisitDetail> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint('###appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        debugPrint('###appLifeCycleState resumed');
        _checkPermission();
        break;
      case AppLifecycleState.paused:
        debugPrint('###appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        debugPrint('###appLifeCycleState detached');
        break;
      case AppLifecycleState.hidden:
        debugPrint('###appLifeCycleState hidden');
        break;
    }
  }

  _checkPermission() async {
    final visitArguments =
        ModalRoute.of(context)!.settings.arguments as VisitArguments;
    if (visitArguments.operation!.requestTypeService == 'Trasporto sanitario') {
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      locationProvider
          .checkLocationPermission(
              '${visitArguments.operation!.userAddress!}, ${visitArguments.operation!.userCity!}, ${visitArguments.operation!.userProvince!}, ${visitArguments.operation!.userRegion!}, ${visitArguments.operation!.userCountry!}')
          .then((permisison) async {
        if (permisison == true) {
          final settingProvider =
              Provider.of<SettingProvider>(context, listen: false);

          if (locationProvider.distance >
              double.parse(settingProvider.setting.settingsMeters!)) {
            if (ModalRoute.of(context)!.isCurrent) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  settings: const RouteSettings(name: 'noservice'),
                  builder: (context) => const NoService(),
                ),
              );
            }
          }
        } else {
          await Alerts.hideAlert();
          await Alerts.errorAlert(
            context,
            title: 'Attenzione',
            subtitle: 'Non riesco a determinare la tua posisiozne',
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final visitArguments =
        ModalRoute.of(context)!.settings.arguments as VisitArguments;

    final double size = ScreenSize.width(context);

    return PopScope(
      onPopInvoked: (value) async => kIsWeb ? false : true,
      child: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: Scaffold(
          appBar: appBar(context, visitArguments),
          body: body(visitArguments, size),
          bottomNavigationBar: SafeArea(
            maintainBottomViewPadding: true,
            minimum: const EdgeInsets.fromLTRB(
              AppConst.padding,
              0,
              AppConst.padding,
              AppConst.padding,
            ),
            child: TapDebouncer(
              onTap: () async {
                context.read<SignatureProvider>().clearCanvas();
              },
              builder: (context, onTap) {
                return Button(
                  width: ScreenSize.width(context),
                  text: 'Cancella firma',
                  color: Colors.black,
                  onPressed: onTap,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  ListView body(VisitArguments visitArguments, double size) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppConst.padding),
      children: [
        signature(visitArguments.operation!, size),
      ],
    );
  }

  AppBar appBar(BuildContext context, VisitArguments visitArguments) {
    return AppBar(
      leading: Ink(
        child: GestureDetector(
          child: const Icon(Icons.arrow_back_rounded),
          onTap: () {
            context.read<SignatureProvider>().clearCanvas();
            Navigator.of(context).pop();
          },
        ),
      ),
      title: const Text('Firma'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppConst.padding),
          child: Ink(
            child: GestureDetector(
              child: Icon(
                Icons.save_rounded,
                color: AppColors.primaryColor,
              ),
              onTap: () async {
                final byteImage =
                    await context.read<SignatureProvider>().export();

                if (byteImage != null) {
                  await SignApi().uploadSign(
                    context,
                    visitArguments.operation!,
                    byteImage,
                  );
                } else {
                  debugPrint('Errore nell\'ottenere i dati dell\'immagine.');
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Consumer<SignatureProvider> signature(Operation operation, double size) {
    return Consumer<SignatureProvider>(
      builder: (context, signatureProvider, child) {
        return Column(
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppConst.borderRadius / 2,
                ),
              ),
              child: Signature(
                controller: signatureProvider.signatureController,
                width: size,
                height: ScreenSize.height(context) - 200,
                backgroundColor: AppColors.secondaryColor.withOpacity(.15),
              ),
            ),
          ],
        );
      },
    );
  }
}
