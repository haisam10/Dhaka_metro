// home.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'qr_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  HomePage({required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showWelcome = true;
  String? fromStation;
  String? toStation;
  int? fare;

  final List<String> stations = [
    'Uttara North', 'Uttara Center', 'Uttara South', 'Pallabi',
    'Mirpur 11', 'Mirpur 10', 'Kazipara', 'Shewrapara',
    'Agargaon', 'Bijoy Sarani', 'Farmgate', 'Karwan Bazar',
    'Shahbagh', 'Dhaka University', 'Bangladesh Secretariat', 'Motijheel'
  ];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        showWelcome = false;
      });
    });
  }

  void _calculateFare() {
    if (fromStation != null && toStation != null) {
      int fromIndex = stations.indexOf(fromStation!);
      int toIndex = stations.indexOf(toStation!);
      if (toIndex > fromIndex) {
        int stationsTravelled = toIndex - fromIndex;
        setState(() {
          fare = 30 * stationsTravelled;
        });
      } else {
        setState(() {
          fare = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid route selection')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: showWelcome
            ? const Text("WELCOME TO THE DMT", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                hint: const Text("From Station"),
                value: fromStation,
                onChanged: (value) => setState(() => fromStation = value),
                items: stations.map((station) => DropdownMenuItem(value: station, child: Text(station))).toList(),
              ),
              DropdownButton<String>(
                hint: const Text("To Station"),
                value: toStation,
                onChanged: (value) => setState(() => toStation = value),
                items: stations.map((station) => DropdownMenuItem(value: station, child: Text(station))).toList(),
              ),
              ElevatedButton(onPressed: _calculateFare, child: const Text("Calculate Fare")),
              if (fare != null) ...[
                Text("Fare: $fare Taka"),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QRPage(
                        ticketInfo: 'User: ${widget.username}\nFrom: $fromStation\nTo: $toStation\nFare: $fare\nTime: ${DateTime.now().toIso8601String()}',
                      ),
                    ),
                  ),
                  child: const Text("Generate QR"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}