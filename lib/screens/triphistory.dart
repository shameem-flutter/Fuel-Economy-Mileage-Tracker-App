import 'package:flutter/material.dart';
import '../../models/trip_model.dart';
import '../../services/trip_service.dart';

class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  late Future<List<TripModel>> _trips;

  @override
  void initState() {
    super.initState();
    _trips = TripService.getTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trip History')),
      body: FutureBuilder<List<TripModel>>(
        future: _trips,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final trips = snapshot.data ?? [];
          if (trips.isEmpty) {
            return const Center(child: Text('No trips yet.'));
          }
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(thickness: 2),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return ListTile(
                title: Text(
                  '${trip.vehicleType} | ${trip.date.toLocal().toString().split(' ')[0]}',
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Distance Travelled: ${trip.distance.toStringAsFixed(2)} km',
                    ),
                    Text('Mileage:${trip.mileage.toStringAsFixed(2)}km/L'),
                    Text('Fuel Cost:₹${trip.totalFuelCost.toStringAsFixed(2)}'),
                    Text('Fuel Economy:${trip.fuelEconomy.toStringAsFixed(2)}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
