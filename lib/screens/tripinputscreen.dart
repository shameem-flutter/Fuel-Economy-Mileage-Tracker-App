import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/constants/color_constants.dart';
import 'package:task/models/trip_model.dart';
import 'package:task/responsive/responsive.dart';
import 'package:task/screens/auth/loginscreen.dart';
import 'package:task/screens/tripsummary.dart';
import 'package:task/services/trip_service.dart';
import 'package:task/widgets/textfield.dart';

class TripInputScreen extends StatefulWidget {
  const TripInputScreen({super.key});

  @override
  State<TripInputScreen> createState() => _TripInputScreenState();
}

class _TripInputScreenState extends State<TripInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleTypes = ['Car', 'Truck', 'Bike'];
  String _selectedVehicle = 'Car';

  final startOdoController = TextEditingController();
  final endOdoController = TextEditingController();
  final fuelFilledController = TextEditingController();
  final fuelPriceController = TextEditingController();

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    final startOdo = double.tryParse(startOdoController.text.trim());
    final endOdo = double.tryParse(endOdoController.text.trim());
    final fuelFilled = double.tryParse(fuelFilledController.text.trim());
    final fuelPrice = double.tryParse(fuelPriceController.text.trim());

    if (startOdo == null ||
        endOdo == null ||
        fuelFilled == null ||
        fuelPrice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid numbers in all fields')),
      );
      return;
    }

    if (endOdo <= startOdo) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('End odometer must be greater than start')),
      );
      return;
    }

    final trip = TripModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      vehicleType: _selectedVehicle,
      startOdometer: startOdo,
      endOdometer: endOdo,
      fuelFilled: fuelFilled,
      fuelPrice: fuelPrice,
      date: DateTime.now(),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );

    await TripService.addTrip(trip);

    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TripSummaryScreen(trip: trip)),
    );
  }

  @override
  void dispose() {
    startOdoController.dispose();
    endOdoController.dispose();
    fuelFilledController.dispose();
    fuelPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Fuel Trip Entry"),
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => Loginscreen()),
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [greyColor, secondaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text(
                      "🚗 Trip Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(R.sh(16, context)),
                        child: Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: _selectedVehicle,
                              dropdownColor: greyColor,
                              decoration: InputDecoration(
                                labelText: "Vehicle Type",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              items: _vehicleTypes
                                  .map(
                                    (v) => DropdownMenuItem(
                                      value: v,
                                      child: Text(v),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) =>
                                  setState(() => _selectedVehicle = val!),
                            ),
                            SizedBox(height: 16),
                            CustomTextField(
                              backgroundColor: greyColor,
                              controller: startOdoController,
                              labelText: 'Start Odometer (km)',
                              validator: _numberValidator,
                            ),
                            SizedBox(height: 12),
                            CustomTextField(
                              controller: endOdoController,
                              backgroundColor: greyColor,
                              labelText: 'End Odometer (km)',
                              validator: _numberValidator,
                            ),
                            SizedBox(height: 12),
                            CustomTextField(
                              controller: fuelFilledController,
                              backgroundColor: greyColor,
                              labelText: 'Fuel Filled (L)',
                              validator: _numberValidator,
                            ),
                            SizedBox(height: 12),
                            CustomTextField(
                              controller: fuelPriceController,
                              labelText: 'Fuel Price (₹/L)',
                              validator: _numberValidator,
                              backgroundColor: greyColor,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    ElevatedButton.icon(
                      icon: Icon(Icons.save),
                      label: Text("Save Trip"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: secondaryColor,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _numberValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    if (double.tryParse(value.trim()) == null) return 'Enter a valid number';
    return null;
  }
}
