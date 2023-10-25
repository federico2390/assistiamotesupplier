import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider extends ChangeNotifier {
  Position? _currentLocation;
  String _address = "";
  double _distance = 0;

  Position? get currentLocation => _currentLocation;
  String get address => _address;
  double get distance => _distance;

  Future<PermissionStatus> checkLocationPermission() async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      await getCurrentLocation();
    } else if (status.isDenied || status.isPermanentlyDenied) {
      await Permission.location.request();
    }

    return status;
  }

  Future<void> getCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      final List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      _currentLocation = position;
      _address = placemarks[0].name ?? "";
      print('sdsa__ $_address');

      await updateDistance();
    } catch (error) {
      print('getCurrentLocation_ $error');
    }

    notifyListeners();
  }

  Future<void> updateDistance() async {
    final List<Location> locations = await locationFromAddress(_address);
    if (locations.isNotEmpty) {
      final double distanceInMeters = Geolocator.distanceBetween(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
        locations[0].latitude,
        locations[0].longitude,
      );
      _distance = distanceInMeters / 1000;
    } else {
      _distance = 0;
    }

    print('sdsa__ $_distance');
    notifyListeners();
  }
}
