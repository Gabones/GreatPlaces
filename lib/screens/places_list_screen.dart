import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../screens/places_details_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            )
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<GreatPlaces>(
                  child: Center(
                      child:
                          Text('Você ainda não possui lugares cadastrados.')),
                  builder: (ctx, greatPlaces, child) =>
                      greatPlaces.items.length <= 0
                          ? child!
                          : ListView.builder(
                              itemCount: greatPlaces.items.length,
                              itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(greatPlaces.items[i].image)),
                                title: Text(greatPlaces.items[i].title),
                                subtitle: Text(greatPlaces.items[i].location!.address!),
                                onTap: () => Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: greatPlaces.items[i].id),
                              ),
                            ),
                ),
        ));
  }
}
