// qr_page.dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatelessWidget {
  final String ticketInfo;

  QRPage({required this.ticketInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Ticket")),
      body: Center(
        child: QrImageView(
          data: ticketInfo,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}