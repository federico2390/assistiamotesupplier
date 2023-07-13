import 'dart:async';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_status;

class UserLocation {
  final double? latitude;
  final double? longitude;
  final double? userLocationInMeters;

  UserLocation({
    this.latitude,
    this.longitude,
    this.userLocationInMeters,
  });
}

class LocationService extends ChangeNotifier {
  Location location = Location();

  StreamController<UserLocation> locationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => locationController.stream;

  UserLocation? _userLocation;
  UserLocation? get userLocation => _userLocation;

  bool? _locationServiceEnabled;
  bool? get locationServiceEnabled => _locationServiceEnabled;

  bool? _locationServiceGranted;
  bool? get locationServiceGranted => _locationServiceGranted;

  double? _locationServiceDistance = 0.0;
  double? get locationServiceDistance => _locationServiceDistance;

  Future<bool>? checkLocationServiceEnabled() async {
    await permission_status.Permission.location.request();
    if (await permission_status.Permission.location.serviceStatus.isEnabled) {
      location.getLocation();
      checkLocationServiceGranted();
      _locationServiceEnabled = true;
      return true;
    } else {
      location.requestService();
      _locationServiceEnabled = false;
      return false;
    }
  }

  Future<permission_status.PermissionStatus>
      checkLocationServiceGranted() async {
    permission_status.PermissionStatus status =
        await permission_status.Permission.location.status;
    _locationServiceGranted = status.isGranted;
    if (status.isGranted) {
      location.onLocationChanged.listen((locationData) {
        var checkDistance = Geolocator.distanceBetween(
          locationData.latitude!,
          locationData.longitude!,
          AppConst.latitude,
          AppConst.longitude,
        );
        if (locationData.latitude != null) {
          locationController.add(
            UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
              userLocationInMeters: checkDistance / 1000,
            ),
          );
          _userLocation = UserLocation(
            latitude: locationData.latitude,
            longitude: locationData.longitude,
            userLocationInMeters: checkDistance / 1000,
          );
          _locationServiceDistance = checkDistance / 1000;
          SharedPrefs.setString(
              'distance', _locationServiceDistance!.toString());
          notifyListeners();
        }
      });
    }
    return status;
  }
}
