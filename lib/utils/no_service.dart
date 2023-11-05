import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/location.dart';
import 'package:adminpanel/utils/alerts.dart';

class NoService extends StatefulWidget {
  const NoService({Key? key}) : super(key: key);

  @override
  State<NoService> createState() => _NoServiceState();
}

class _NoServiceState extends State<NoService> with WidgetsBindingObserver {
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
        print('###appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        print('###appLifeCycleState resumed');
        _checkPermission();
        break;
      case AppLifecycleState.paused:
        print('###appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('###appLifeCycleState detached');
        break;
      case AppLifecycleState.hidden:
        print('###appLifeCycleState hidden');
        break;
    }
  }

  _checkPermission() async {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider
        .checkLocationPermission(locationProvider.visitAddress)
        .then((permisison) async {
      if (permisison.isGranted) {
        if (locationProvider.distance < 50.0) {
          Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    _checkPermission();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Ink(
            child: GestureDetector(
              child: const Icon(Icons.close),
              onTap: () {
                Navigator.of(context).popUntil((route) {
                  return route.settings.name == '/operation_detail';
                });
              },
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/misc/search.png',
                  width: MediaQuery.of(context).size.width / 1.75),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConst.padding * 3),
                child: Column(
                  children: [
                    SizedBox(height: AppConst.padding),
                    Text('Servizio non disponibile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    SizedBox(height: AppConst.padding / 2),
                    Text(
                        'Assicurati che il GPS del tuo dispositivo sia attivo e che la tua posizione sia nelle immediate vicinanze dell\'indirizzo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
