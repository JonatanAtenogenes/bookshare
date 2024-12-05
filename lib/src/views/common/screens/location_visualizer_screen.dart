import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../view_models/exchange/exchange_provider.dart';

class LocationvisualizerScreen extends ConsumerStatefulWidget {
  const LocationvisualizerScreen({super.key});

  @override
  ConsumerState<LocationvisualizerScreen> createState() =>
      _LocationvisualizerscreenState();
}

class _LocationvisualizerscreenState
    extends ConsumerState<LocationvisualizerScreen> {
  GoogleMapController? mapController;

  // Get the current location from the provider
  LatLng? get selectedPosition =>
      ref.watch(currentExchangeInformation).exchangeAddress;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: Column(
        children: [
          const SubtitleText(subtitle: "Ubicacion del intercambio"),
          const SizedBox(height: 16),
          Expanded(
            child: GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: selectedPosition ?? const LatLng(19.28786, -99.65324),
                // Default center if no location is available
                zoom: 15,
              ),
              markers: {
                if (selectedPosition != null)
                  Marker(
                    markerId: const MarkerId('selected-marker'),
                    position:
                        selectedPosition ?? const LatLng(19.28786, -99.65324),
                    infoWindow:
                        const InfoWindow(title: 'Ubicación de intercambio'),
                  ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
