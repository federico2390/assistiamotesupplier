import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider extends ChangeNotifier {
  Position? _currentLocation;
  double _distance = 0;
  String _visitAddress = "";

  Position? get currentLocation => _currentLocation;
  double get distance => _distance;
  String get visitAddress => _visitAddress;

  Future<PermissionStatus> checkLocationPermission(String address) async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      _visitAddress = address;

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
        forceAndroidLocationManager: true,
      );

      _currentLocation = position;

      await updateDistance();
    } catch (error) {
      print('getCurrentLocation_ $error');
    }

    notifyListeners();
  }

  Future<void> updateDistance() async {
    final List<Location> locations = await locationFromAddress(_visitAddress);

    if (locations.isNotEmpty) {
      final double distanceInMeters = Geolocator.distanceBetween(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
        locations[0].latitude,
        locations[0].longitude,
      );

      _distance = distanceInMeters.ceilToDouble();

      print('geo__Address: $_visitAddress');
      print('geo__Current Location: $_currentLocation');
      print('geo__Destination Latitude: ${locations[0].latitude}');
      print('geo__Destination Longitude: ${locations[0].longitude}');
      print('geo__Distance: $_distance meters');
    } else {
      _distance = 0;
    }

    notifyListeners();
  }
}
