import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  LocationService._();

  static Future<void> ensureLocationAndNavigate(
    BuildContext context,
    Widget destination,
  ) async {
    final status = await Permission.locationWhenInUse.status;

    if (status.isGranted) {
      _navigateToScreen(context, destination);
      return;
    }

    final result = await Permission.locationWhenInUse.request();

    if (result.isGranted) {
      _navigateToScreen(context, destination);
      return;
    }

    if (result.isPermanentlyDenied) {
      final open = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
            'This app needs location access to show your current location. Please enable it in app settings.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );

      if (open == true) await openAppSettings();
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Location permission denied - cannot continue.'),
      ),
    );
  }

  static Future<LocationResult> getCurrentLocationWithAddress() async {
    try {
      final perm = await Permission.locationWhenInUse.status;
      if (!perm.isGranted) {
        final req = await Permission.locationWhenInUse.request();
        if (!req.isGranted) {
          return LocationResult.error('Location permission denied');
        }
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
      );

      final latLng = LatLng(position.latitude, position.longitude);
      final address = await getFormattedAddress(latLng);

      return LocationResult.success(
        position: position,
        latLng: latLng,
        address: address,
      );
    } catch (e) {
      return LocationResult.error('Failed to get location: $e');
    }
  }

  static Future<String> getFormattedAddress(LatLng latLng) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        final String? street = place.street;
        final String? city = place.locality;

        if (street != null &&
            street.isNotEmpty &&
            city != null &&
            city.isNotEmpty) {
          return '$street، $city';
        } else if (street != null && street.isNotEmpty) {
          return street;
        } else if (city != null && city.isNotEmpty) {
          return city;
        } else {
          return 'موقع غير معروف';
        }
      }

      return 'موقع غير معروف';
    } catch (e) {
      return 'تعذر الحصول على العنوان';
    }
  }

  static void _navigateToScreen(BuildContext context, Widget destination) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
  }
}

class LocationResult {
  final bool isSuccess;
  final Position? position;
  final LatLng? latLng;
  final String? address;
  final String? errorMessage;

  LocationResult.success({
    required this.position,
    required this.latLng,
    required this.address,
  }) : isSuccess = true,
       errorMessage = null;

  LocationResult.error(this.errorMessage)
    : isSuccess = false,
      position = null,
      latLng = null,
      address = null;
}
