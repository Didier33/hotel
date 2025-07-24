import 'package:flutter/material.dart';
import '../services/database.dart';
import '../models/client.dart';

class ClientProvider with ChangeNotifier {
  List<Client> _clients = [];

  List<Client> get clients => _clients;

  Future<void> fetchClients() async {
    final dbHelper = DatabaseHelper.instance;
    _clients = await dbHelper.getAllClients();
    notifyListeners();
  }

  Future<void> addClient(Client client) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.insertClient(client);
    await fetchClients();
  }
}
