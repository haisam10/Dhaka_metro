// forgot.dart
import 'package:flutter/material.dart';
import 'api_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController nidController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  String? username;

  void _retrieveUsername() async {
    final result = await ApiService.getUsernameByNid(nidController.text);
    if (result['success'] == true) {
      setState(() {
        username = result['username'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'])));
    }
  }

  void _resetPassword() async {
    if (username != null) {
      final result = await ApiService.forgotPassword(nidController.text, newPasswordController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'])));
      if (result['success'] == true) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.green], // Royal blue gradient
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              color: Colors.white, // White card background
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Forgot Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: nidController,
                      decoration: InputDecoration(
                        labelText: "NID Number",
                        labelStyle: TextStyle(color: Colors.blue[900]),
                        prefixIcon: Icon(Icons.card_membership, color: Colors.green),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.blue[900]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.blue[900]!, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: _retrieveUsername,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text("Retrieve Username", style: TextStyle(fontSize: 18.0, color: Colors.white)),
                    ),
                    if (username != null) ...[
                      const SizedBox(height: 16.0),
                      Text("Username: $username", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue[900], fontSize: 16.0)),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "New Password",
                          labelStyle: TextStyle(color: Colors.blue[900]),
                          prefixIcon: Icon(Icons.lock, color: Colors.blue[900]),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue[900]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue[900]!, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      ElevatedButton(
                        onPressed: _resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                        ),
                        child: const Text("Reset Password", style: TextStyle(fontSize: 18.0, color: Colors.white)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}