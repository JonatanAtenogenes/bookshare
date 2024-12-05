import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  // Define the initial center as a static constant
  static const LatLng center = LatLng(19.28786, -99.65324);

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  GoogleMapController? mapController;

  // State variables to handle the selected position and markers
  LatLng? selectedPosition;
  Set<Marker> markers = {};

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onMapTapped(LatLng position) {
    setState(() {
      selectedPosition = position;
      // Only allow one marker
      markers = {
        Marker(
          markerId: const MarkerId('selected-marker'),
          position: position,
          infoWindow: const InfoWindow(title: 'Selected Location'),
        ),
      };
    });
  }

  void onSubmit() {
    if (selectedPosition != null) {
      // Handle the submit action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Submitted location: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: Column(
        children: [
          const SubtitleText(
            subtitle: AppStrings.submitProblem,
          ),
          const SizedBox(height: 16),
          if (selectedPosition != null) ...[
            Text(
              'Selected Position: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
          ],
          Expanded(
            child: GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LocationSelectionScreen.center,
                zoom: 15,
              ),
              onTap: onMapTapped,
              markers: markers,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: selectedPosition == null
              ? null
              : onSubmit, // Enable only when a marker exists
          child: const Text('Submit Problem'),
        ),
      ),
    );
  }
}
