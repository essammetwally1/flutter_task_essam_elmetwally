import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_task_essam_elmetwally/services/location_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  String _selectedAddress = 'انقر على الخريطة لاختيار موقع';
  bool _loading = true;
  CameraPosition _initialCamera = const CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    final result = await LocationService.getCurrentLocationWithAddress();
    if (result.isSuccess) {
      setState(() {
        _initialCamera = CameraPosition(target: result.latLng!, zoom: 14);
        _selectedLocation = result.latLng;
        _selectedAddress = result.address!;
      });
    }
    setState(() => _loading = false);
  }

  void _onMapTap(LatLng location) async {
    setState(() => _selectedLocation = location);

    final address = await LocationService.getFormattedAddress(location);
    setState(() => _selectedAddress = address);
  }

  void _onConfirm() {
    if (_selectedLocation != null) {
      Navigator.pop(context, {
        'latLng': _selectedLocation,
        'address': _selectedAddress,
      });
    }
  }

  void _onMyLocationPressed() async {
    final result = await LocationService.getCurrentLocationWithAddress();
    if (result.isSuccess) {
      _mapController?.animateCamera(CameraUpdate.newLatLng(result.latLng!));
      setState(() {
        _selectedLocation = result.latLng;
        _selectedAddress = result.address!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر الموقع'),
        actions: [
          TextButton(
            onPressed: _selectedLocation == null ? null : _onConfirm,
            child: Text(
              'تأكيد',
              style: TextStyle(
                color: _selectedLocation == null
                    ? Colors.white54
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: _initialCamera,
                  onMapCreated: (controller) => _mapController = controller,
                  onTap: _onMapTap,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  markers: _selectedLocation == null
                      ? {}
                      : {
                          Marker(
                            markerId: const MarkerId('selected'),
                            position: _selectedLocation!,
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed,
                            ),
                          ),
                        },
                ),

                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'الموقع المحدد:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _selectedAddress,
                            style: const TextStyle(fontSize: 14),
                          ),
                          if (_selectedLocation != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              'الإحداثيات: ${_selectedLocation!.latitude.toStringAsFixed(4)}, ${_selectedLocation!.longitude.toStringAsFixed(4)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'my_location',
            onPressed: _onMyLocationPressed,
            mini: true,
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 16),
          if (_selectedLocation != null)
            FloatingActionButton.extended(
              heroTag: 'confirm_location',
              onPressed: _onConfirm,
              icon: const Icon(Icons.check),
              label: const Text('استخدم هذا الموقع'),
            ),
        ],
      ),
    );
  }
}
