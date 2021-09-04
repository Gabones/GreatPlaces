import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({this.initialLocation = const PlaceLocation(latitude: -29.16826, longitude: -51.17938), this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> _markers = [];

  @override
  Widget build(BuildContext context) {
    LatLng? _pickedLocation;
    void _selectLocation(LatLng position) {
      setState(() {
        _pickedLocation = position;
        _markers.add(Marker(
          width: 50.0,
          height: 50.0,
          point: _pickedLocation!,
          builder: (ctx) =>
              Container(
                child: FlutterLogo(),
              ),
        ));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Map'),
        actions: [
          if(widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null ?
              null : () => Navigator.of(context).pop(_pickedLocation),
            )
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
          zoom: 13.0,
          onLongPress: widget.isSelecting ? _selectLocation : null,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://api.mapbox.com/styles/v1/gabaoalb/ckt27mev516qh18qifbbkrkim/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZ2FiYW9hbGIiLCJhIjoiY2t0MjVheWpxMGs1eTJubngxbWw5azhoZyJ9.OFePsKmBnWUJlwJ0AZP-lw",
              additionalOptions: {
                'accessToken': 'pk.eyJ1IjoiZ2FiYW9hbGIiLCJhIjoiY2t0MjVheWpxMGs1eTJubngxbWw5azhoZyJ9.OFePsKmBnWUJlwJ0AZP-lw',
                'id': 'mapbox.mapbox-streets-v8'
              }
          ),
          // _pickedLocation == null ? {} :
          MarkerLayerOptions(
            markers: _markers,
          ),
        ],
      ),
    );
  }
}
