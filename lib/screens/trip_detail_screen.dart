import 'package:flutter/material.dart';
import 'package:traveling_app/app_data.dart';

class TripDetailScreen extends StatelessWidget {
  static const screenRoute = '/trip-detail';

  final Function manageFavorite;
  final Function isFavorite;

  TripDetailScreen(this.manageFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String titleText) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.topRight,
      child: Text(
        titleText,
        style: TextStyle(
            color: Colors.deepOrange, fontSize: 30, fontFamily: "Elmessiri"),
      ),
    );
  }

  Widget buildListViewContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tripId = ModalRoute.of(context).settings.arguments as String;
    final selectedTrip = Trips_data.firstWhere((trip) => trip.id == tripId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        title: Text('${selectedTrip.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedTrip.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            buildSectionTitle(context, 'الأنشطة'),
            buildListViewContainer(
              ListView.builder(
                itemCount: selectedTrip.activities.length,
                itemBuilder: (ctx, index) => Card(
                  elevation: 0.3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedTrip.activities[index],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            buildSectionTitle(context, 'البرنامج اليومي'),
            buildListViewContainer(
              ListView.builder(
                itemCount: selectedTrip.program.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.deepOrange,
                        child: Text(
                          'يوم ${index + 1}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(selectedTrip.program[index]),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(tripId) ? Icons.star : Icons.star_border),
        onPressed: () => manageFavorite(tripId),
      ),
    );
  }
}
