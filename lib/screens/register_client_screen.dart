import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/client.dart';
import '../providers/client_provider.dart';
import '../widgets/signature_pad.dart'; // Assure-toi que ce widget existe
import '../utils/date_utils.dart' as DateUtils;

class RegisterClientScreen extends StatefulWidget {
  static const String route = '/register-client';
  @override
  _RegisterClientScreenState createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late Client _client;
  Uint8List? _signatureData; // Pour stocker la signature en binaire

  @override
  void initState() {
    super.initState();
    _client = Client(
      nom: '',
      prenoms: '',
      naissance_date: DateTime.now(),
      naissance_lieu: '',
      pere: '',
      mere: '',
      profession: '',
      domicile: '',
      adresse: '',
      telephone: '',
      nb_mineur: 0,
      nationalite: '',
      piece_type: '',
      piece_numero: '',
      piece_delivrance_date: DateTime.now(),
      piece_delivrance_lieu: '',
      photo_recto: '',
      photo_verso: '',
      numero_chambre: '',
      delivrance_by: '',
      signature: null, // ✅ Doit être Uint8List? ou String selon ton modèle
      destination: '',
      date_entree: DateTime.now(),
      date_sortie: DateTime.now(),

      user_id: 1,
    );
  }

  // Sélection d'image
  Future<void> _pickImage(ImageSource source, String type) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        if (type == 'recto') {
          _client = _client.copyWith(photo_recto: image.path);
        } else if (type == 'verso') {
          _client = _client.copyWith(photo_verso: image.path);
        }
      });
    }
  }

  // Sauvegarde de la signature
  void _saveSignature(Uint8List? data) {
    if (data != null) {
      setState(() {
        _signatureData = data;
        _client =
            _client.copyWith(signature: data); // ✅ Si signature est Uint8List?
      });
    }
  }

  // Fonction de validation et soumission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Applique tous les `onSaved`

      // Vérifie que la signature est faite
      if (_signatureData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("⚠️ Veuillez signer avant d'enregistrer.")),
        );
        return;
      }

      // Enregistre le client
      Provider.of<ClientProvider>(context, listen: false).addClient(_client);

      // ✅ Message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("✅ Client enregistré avec succès !"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Retour à l'écran précédent
      Navigator.pop(context);
    }
  }

  // Style de champ avec bordure arrondie et vert au focus
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.green, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red),
      ),
      fillColor: Colors.white,
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enregistrer un client")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 8),
            children: [
              // --- Nom ---
              TextFormField(
                decoration: _inputDecoration('Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le nom est obligatoire';
                  }
                  if (value.length < 2) {
                    return 'Le nom doit contenir au moins 2 caractères';
                  }
                  return null;
                },
                onSaved: (value) =>
                    _client = _client.copyWith(nom: value ?? ''),
              ),
              SizedBox(height: 16),

              // --- Prénoms ---
              TextFormField(
                decoration: _inputDecoration('Prénoms'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Les prénoms sont obligatoires';
                  }
                  return null;
                },
                onSaved: (value) =>
                    _client = _client.copyWith(prenoms: value ?? ''),
              ),
              SizedBox(height: 16),

              // --- Date de naissance ---
              Text("Né le", style: TextStyle(fontWeight: FontWeight.w500)),
              TextButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _client.naissance_date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _client = _client.copyWith(naissance_date: date);
                    });
                  }
                },
                child: Text(DateUtils.DateUtils.format(_client.naissance_date)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // --- Lieu de naissance ---
              TextFormField(
                decoration: _inputDecoration('Lieu de naissance'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Champ obligatoire' : null,
                onSaved: (value) =>
                    _client = _client.copyWith(naissance_lieu: value ?? ''),
              ),
              SizedBox(height: 16),

              // --- Fils de / Et de ---
              TextFormField(
                decoration: _inputDecoration('Fils de'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Nom du père requis' : null,
                onSaved: (value) =>
                    _client = _client.copyWith(pere: value ?? ''),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: _inputDecoration('Et de'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Nom de la mère requis' : null,
                onSaved: (value) =>
                    _client = _client.copyWith(mere: value ?? ''),
              ),
              SizedBox(height: 16),

              // --- Profession ---
              TextFormField(
                decoration: _inputDecoration('Profession'),
                onSaved: (value) =>
                    _client = _client.copyWith(profession: value ?? ''),
              ),
              SizedBox(height: 16),

              // --- Domicile / Adresse ---
              TextFormField(
                decoration: _inputDecoration('Domicile habituel'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Champ obligatoire' : null,
                onSaved: (value) =>
                    _client = _client.copyWith(domicile: value ?? ''),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: _inputDecoration('Adresse'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Champ obligatoire' : null,
                onSaved: (value) =>
                    _client = _client.copyWith(adresse: value ?? ''),
              ),
              SizedBox(height: 16),

              // --- Téléphone ---
              TextFormField(
                decoration: _inputDecoration('Téléphone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Numéro requis';
                  if (!RegExp(r'^[+]?[0-9]{8,15}$').hasMatch(value)) {
                    return 'Numéro invalide';
                  }
                  return null;
                },
                onSaved: (value) =>
                    _client = _client.copyWith(telephone: value ?? ''),
              ),
              SizedBox(height: 16),

              // --- Nationalité ---
              TextFormField(
                decoration: _inputDecoration('Nationalité'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Champ obligatoire' : null,
                onSaved: (value) =>
                    _client = _client.copyWith(nationalite: value ?? ''),
              ),
              SizedBox(height: 16),

              // --- Pièce d'identité ---
              TextFormField(
                decoration: _inputDecoration('Nature de la pièce'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Champ obligatoire' : null,
                onSaved: (value) =>
                    _client = _client.copyWith(piece_type: value ?? ''),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: _inputDecoration('Numéro de la pièce'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Champ obligatoire' : null,
                onSaved: (value) =>
                    _client = _client.copyWith(piece_numero: value ?? ''),
              ),
              SizedBox(height: 16),

              // --- Date de délivrance ---
              Text("Délivré le", style: TextStyle(fontWeight: FontWeight.w500)),
              TextButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _client.piece_delivrance_date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _client = _client.copyWith(piece_delivrance_date: date);
                    });
                  }
                },
                child: Text(
                    DateUtils.DateUtils.format(_client.piece_delivrance_date)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // --- Lieu de délivrance ---
              TextFormField(
                decoration: _inputDecoration('Lieu de délivrance'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Champ obligatoire' : null,
                onSaved: (value) => _client =
                    _client.copyWith(piece_delivrance_lieu: value ?? ''),
              ),
              SizedBox(height: 20),

              // --- Photos ---
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera, 'recto'),
                      icon: Icon(Icons.camera_alt, size: 18),
                      label: Text("Photo Recto"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery, 'recto'),
                      icon: Icon(Icons.image, size: 18),
                      label: Text("Choisir Recto"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera, 'verso'),
                      icon: Icon(Icons.camera_alt, size: 18),
                      label: Text("Photo Verso"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery, 'verso'),
                      icon: Icon(Icons.image, size: 18),
                      label: Text("Choisir Verso"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),

              // --- Signature ---
              SizedBox(height: 20),
              Text("Signature du client",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              SignaturePad(onSignatureSaved: _saveSignature), // ✅ Nom corrigé
              if (_signatureData == null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "⚠️ La signature est obligatoire",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              // --- Destination ---
              SizedBox(height: 20),
              TextFormField(
                decoration: _inputDecoration('Destination exacte'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Champ obligatoire' : null,
                onSaved: (value) =>
                    _client = _client.copyWith(destination: value ?? ''),
              ),
              SizedBox(height: 16),

              // --- Date d'entrée ---
              Text("Date d'entrée",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              TextButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _client.date_entree,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _client = _client.copyWith(date_entree: date);
                    });
                  }
                },
                child: Text(DateUtils.DateUtils.format(_client.date_entree)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // --- Date de sortie ---
              Text("Date de sortie",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              TextButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _client.date_sortie,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _client = _client.copyWith(date_sortie: date);
                    });
                  }
                },
                child: Text(DateUtils.DateUtils.format(_client.date_sortie)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),

              // --- Bouton Enregistrer ---
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: Icon(Icons.save, size: 20),
                  label: Text("Enregistrer", style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
