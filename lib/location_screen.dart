import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // show a list of locations for a phone
  // when your location changes, add it to the list
  // maybe add time of location also

  final location = Location();

  // list of locations
  final locations = <LocationData>[];

  @override
  void initState() {
    // this code gets called before build
    // but it only gets called once
    _checkForLocationPermission();
    _listenForLocationChanges();
    super.initState();
  }

  // check if the user has enabled location permissions
  // if so, proceed
  void _checkForLocationPermission() async {
    var serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();

      if (!serviceEnabled) {
        // stops method
        return;
      }
    }
  }

  void _listenForLocationChanges() async {
    // after the screen has finished building
    // listen for location changes
    // when the location changes, add it to the list
    // then rebuild the screen to show the new list
    WidgetsBinding.instance.addPostFrameCallback((_) {
      location.onLocationChanged.listen((currentLocation) {
        setState(() {
          locations.add(currentLocation);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Locations'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];

          return Card(
            elevation: 8.0,
            child: ListTile(
              title: Text(
                  'Lat - ${location.latitude}, Long - ${location.longitude}'),
              subtitle: Text(
                  'Time of location - ${DateTime.fromMillisecondsSinceEpoch(location.time.toInt())}'),
            ),
          );
        },
      ),
    );
  }
}
