import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/geocoding.dart';

class NoService extends StatefulWidget {
  const NoService({Key? key, this.permission, this.serviceStatus})
      : super(key: key);

  final bool? serviceStatus;
  final bool? permission;

  @override
  State<NoService> createState() => _NoServiceState();
}

class _NoServiceState extends State<NoService> with WidgetsBindingObserver {
  bool? serviceStatus = false;
  bool? permission = false;

  @override
  void initState() {
    serviceStatus = widget.serviceStatus;
    permission = widget.permission;
    _checkPermission();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
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
    var location = Location();
    serviceStatus = await location.serviceEnabled();
    if (serviceStatus == true) {
      await location.hasPermission().then((value) async {
        if (value == PermissionStatus.granted) {
          if (context.read<LocationService>().locationServiceDistance! > 50) {
            setState(() {
              serviceStatus = true;
              permission = true;
            });
          } else {
            Navigator.of(context).pop();
          }
        } else if (value == PermissionStatus.denied ||
            value == PermissionStatus.deniedForever) {
          setState(() {
            serviceStatus = true;
            permission = false;
          });
        }
      });
    } else {
      setState(() {
        serviceStatus = false;
        permission = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConst.padding * 3),
              child: Column(
                children: [
                  const SizedBox(height: AppConst.padding),
                  Text(
                      permission == true && serviceStatus == true
                          ? 'Servizio non disponibile'
                          : 'Non posso determinare la tua posiszione',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  const SizedBox(height: AppConst.padding / 2),
                  Text(
                      permission == true && serviceStatus == true
                          ? 'La tua posizione non coincide con l\'indirizzo della richiesta.'
                          : 'Assicurati che il GPS del tuo dispositivo sia attivo e che l\'app abbia il consenso ad utilizzarlo. '
                              'Se così non fosse, abilità la tua app nelle impostazioni sulla posizione del tuo dispositivo.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
