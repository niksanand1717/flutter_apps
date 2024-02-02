import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location =
        const PlaceLocation(latitude: 37.422, longitude: -122.084, address: ''),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String locationImage() {
    final key =
        'AgOtvcn6cVKPLrLsZ7tauyea95HlxeELfcWHNE82zsMvIDPZNz8H71JC1HVRsTjp';
    final lat = widget.location.latitude;
    final lng = widget.location.longitude;
    return "https://dev.virtualearth.net/REST/v1/Imagery/Map/Road/$lat,$lng/16?mapSize=350,200&pp=$lat,$lng&mapLayer=Basemap&format=jpeg&key=$key";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {},
            ),
        ],
      ),
      // body: GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(
      //       widget.location.latitude,
      //       widget.location.longitude,
      //     ),
      //     zoom: 16,
      //   ),
      //   markers: {
      //     Marker(
      //       markerId: const MarkerId('m1'),
      //       position: LatLng(
      //         widget.location.latitude,
      //         widget.location.longitude,
      //       ),
      //     ),
      //   },
      // ),
      body: FutureBuilder(
        future: getBingUrlTemplate(
            // 'https://dev.virtualearth.net/REST/V1/Imagery/Metadata/RoadOnDemand?output=json&uriScheme=https&include=ImageryProviders&key=AgOtvcn6cVKPLrLsZ7tauyea95HlxeELfcWHNE82zsMvIDPZNz8H71JC1HVRsTjp'),
            'https://dev.virtualearth.net/REST/v1/Imagery/Metadata/RoadOnDemand/28.5801867,77.318085?zoomLevel=16&include=ImageryProviders&key=AgOtvcn6cVKPLrLsZ7tauyea95HlxeELfcWHNE82zsMvIDPZNz8H71JC1HVRsTjp'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SfMaps(
              layers: [
                MapTileLayer(
                  urlTemplate: snapshot.data as String,
                )
              ],
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
