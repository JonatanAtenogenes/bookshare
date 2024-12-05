import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/common/widgets/button.dart';
import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../view_models/exchange/exchange_provider.dart';

class LocationSelectionScreen extends ConsumerStatefulWidget {
  const LocationSelectionScreen({super.key});

  // Define the initial center as a static constant
  static const LatLng center = LatLng(19.28786, -99.65324);

  @override
  ConsumerState<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState
    extends ConsumerState<LocationSelectionScreen> {
  GoogleMapController? mapController;

  // Get the current selected position from the provider
  LatLng? get selectedPosition => ref.watch(selectedLocationProvider);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onMapTapped(LatLng position) {
    // Update the selected position in the provider
    ref.read(selectedLocationProvider.notifier).state = position;
    ref.read(currentSessionExchangeInformation.notifier).update(
          (state) => state.copyWith(exchangeAddress: position),
        );
  }

  void onSelectLocation() {
    if (selectedPosition != null) {
      // Handle the location selection
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ubicacion seleccionada: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedLocation = ref.watch(selectedLocationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: Column(
        children: [
          const SubtitleText(subtitle: "Selecciona ubicacion de intercambio"),
          const SizedBox(height: 16),
          Expanded(
            child: GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: selectedLocation ?? LocationSelectionScreen.center,
                zoom: 15,
              ),
              onTap: onMapTapped,
              markers: {
                if (selectedPosition != null)
                  Marker(
                    markerId: const MarkerId('selected-marker'),
                    position: selectedPosition!,
                    infoWindow:
                        const InfoWindow(title: 'Ubicacion seleccionada'),
                  ),
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          onPressed: () {
            selectedPosition == null
                ? null
                : onSelectLocation; // Enable only when a location is selected
            context.pop();
          },
          text: 'Confirmar Ubicacion',
        ),
      ),
    );
  }
}
