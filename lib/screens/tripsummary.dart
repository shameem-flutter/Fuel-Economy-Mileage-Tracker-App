import 'package:flutter/material.dart';
import 'package:task/constants/color_constants.dart';
import 'package:task/screens/triphistory.dart';
import 'package:task/screens/tripinputscreen.dart';
import '../../models/trip_model.dart';

class TripSummaryScreen extends StatelessWidget {
  final TripModel trip;
  const TripSummaryScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Trip Summary')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Text(
                'Trip Overview',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Card(
                color: greyColor,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          trip.vehicleType == 'Truck'
                              ? Icons.local_shipping_rounded
                              : trip.vehicleType == 'Bike'
                              ? Icons.directions_bike
                              : Icons.directions_car,
                        ),

                        title: Text('Vehicle'),
                        subtitle: Text(trip.vehicleType),
                      ),
                      ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text('Date'),
                        subtitle: Text('${trip.date.toLocal()}'.split(' ')[0]),
                      ),
                      const Divider(),

                      ListTile(
                        leading: Icon(Icons.speed),
                        title: Text('Odometer'),
                        subtitle: Text(
                          'Start: ${trip.startOdometer} km\nEnd: ${trip.endOdometer} km',
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_walk),
                        title: Text('Distance Travelled'),
                        subtitle: Text(
                          '${trip.distance.toStringAsFixed(2)} km',
                        ),
                      ),
                      const Divider(),

                      ListTile(
                        leading: Icon(Icons.local_gas_station),
                        title: Text('Fuel Details'),
                        subtitle: Text(
                          'Filled: ${trip.fuelFilled} L\nPrice: ₹${trip.fuelPrice}/litre',
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.attach_money),
                        title: Text('Total Fuel Cost'),
                        subtitle: Text(
                          '₹${trip.totalFuelCost.toStringAsFixed(2)}',
                        ),
                      ),
                      const Divider(),

                      ListTile(
                        leading: Icon(Icons.show_chart),
                        title: Text('Mileage'),
                        subtitle: Text(
                          '${trip.mileage.toStringAsFixed(2)} km/L',
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.paid),
                        title: Text('Fuel Economy'),
                        subtitle: Text(
                          '₹${trip.fuelEconomy.toStringAsFixed(2)}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TripHistoryScreen()),
                    ),
                    icon: Icon(Icons.history),
                    label: Text(
                      'Trip History',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TripInputScreen()),
                    ),
                    icon: Icon(Icons.done),
                    label: Text('DONE', style: TextStyle(color: primaryColor)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
