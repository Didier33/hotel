import 'package:flutter/material.dart';
import '../models/client.dart';
import '../providers/client_provider.dart';
import 'package:provider/provider.dart';

class RegisterClientScreen extends StatefulWidget {
  static const String route = '/register-client';
  const RegisterClientScreen({super.key});
  @override
  _RegisterClientScreenState createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  final _formKey = GlobalKey<FormState>();
  late Client _client;

  @override
  void initState() {
    super.initState();
    _client = Client(
      nom: '',
      prenoms: '',
      naissanceDate: DateTime.now(),
      naissanceLieu: '',
      pere: '',
      mere: '',
      profession: '',
      domicile: '',
      adresse: '',
      telephone: '',
      nationalite: '',
      pieceType: '',
      pieceNumero: '',
      pieceDelivranceDate: DateTime.now(),
      pieceDelivranceLieu: '',
      photoRecto: '',
      photoVerso: '',
      empreinte: '',
      signature: '',
      destination: '',
      dateEntree: DateTime.now(),
      dateSortie: DateTime.now(),
      dateEnregistrement: DateTime.now(),
      utilisateurId: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enregistrer un client')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) => value!.isEmpty ? 'Entrez un nom' : null,
                onSaved: (value) => _client = _client.copyWith(nom: value),
              ),
              // Ajouter tous les autres champs ici
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await Provider.of<ClientProvider>(context, listen: false)
                        .addClient(_client);
                    Navigator.pop(context);
                  }
                },
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
