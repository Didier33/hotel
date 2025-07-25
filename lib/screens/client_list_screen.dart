// screens/client_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/client_provider.dart';
import '../utils/date_utils.dart' as DateUtils; // 🔥 Utilise un préfixe

class ClientListScreen extends StatelessWidget {
  static const String route = '/client-list';
  const ClientListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Liste des Clients")),
      body: FutureBuilder(
        future: clientProvider.fetchClients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else {
            return ListView.builder(
              itemCount: clientProvider.clients.length,
              itemBuilder: (context, index) {
                final client = clientProvider.clients[index];
                return Card(
                  child: ListTile(
                    title: Text("${client.nom} ${client.prenoms}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Téléphone : ${client.telephone}"),
                        Text(
                            "Entrée : ${DateUtils.DateUtils.format(client.date_entree)}"), // ✅ Utilisation avec préfixe
                        Text(
                            "Sortie : ${DateUtils.DateUtils.format(client.date_sortie)}"), // ✅
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
