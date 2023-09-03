import 'package:flutter/material.dart';

// Third Party Package Imports
import 'package:provider/provider.dart';

// Provider Imports
import '../providers/great_places.dart';

// Screen Imports
import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                builder: (ctx, greatplaces, ch) => greatplaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatplaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatplaces.items[i].image),
                          ),
                          title: Text(greatplaces.items[i].title),
                          onTap: () {},
                        ),
                      ),
                child: Center(child: Text('No places yet! Start adding some')),
              ),
      ),
    );
  }
}
