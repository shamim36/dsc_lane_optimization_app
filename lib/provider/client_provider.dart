import 'package:flutter/material.dart';

class ClientProvider with ChangeNotifier {
  String _client = 'admin'; // Default to 'user'

  String get client => _client;

  void setClient(String newClient) {
    _client = newClient;
    notifyListeners(); // Notify all listeners when the value changes
  }
}
