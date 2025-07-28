class TripModel {
  final String id;
  final String vehicleType;
  final double startOdometer;
  final double endOdometer;
  final double fuelFilled;
  final double fuelPrice;
  final DateTime date;

  TripModel({
    required this.id,
    required this.vehicleType,
    required this.startOdometer,
    required this.endOdometer,
    required this.fuelFilled,
    required this.fuelPrice,
    required this.date,
  });

  double get distance {
    return endOdometer - startOdometer;
  }

  double get mileage {
    return distance / fuelFilled;
  }

  double get totalFuelCost {
    return fuelFilled * fuelPrice;
  }

  double get fuelEconomy {
    return totalFuelCost / distance;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicleType': vehicleType,
      'startOdometer': startOdometer,
      'endOdometer': endOdometer,
      'fuelFilled': fuelFilled,
      'fuelPrice': fuelPrice,
      'date': date.toIso8601String(),
    };
  }

  factory TripModel.fromMap(Map<String, dynamic> map) {
    return TripModel(
      id: map['id'],
      vehicleType: map['vehicleType'],
      startOdometer: map['startOdometer'],
      endOdometer: map['endOdometer'],
      fuelFilled: map['fuelFilled'],
      fuelPrice: map['fuelPrice'],
      date: DateTime.parse(map['date']),
    );
  }
}
