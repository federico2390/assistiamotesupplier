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

  Future<bool> checkLocationPermission(String address) async {
    final request = await Permission.location.status;

    if (request.isGranted) {
      _visitAddress = address;

      await getCurrentLocation();
      return true;
    } else if (request.isDenied || request.isPermanentlyDenied) {
      final requestAgain = await Permission.location.request();
      if (requestAgain.isGranted) {
        _visitAddress = address;

        await getCurrentLocation();
        return true;
      } else {
        return false;
      }
    }

    return false;
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
      debugPrint('getCurrentLocation_ $error');
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

      debugPrint('geo__Address: $_visitAddress');
      debugPrint('geo__Current Location: $_currentLocation');
      debugPrint('geo__Destination Latitude: ${locations[0].latitude}');
      debugPrint('geo__Destination Longitude: ${locations[0].longitude}');
      debugPrint('geo__Distance: $_distance meters');
    } else {
      _distance = 0;
    }

    notifyListeners();
  }
}
