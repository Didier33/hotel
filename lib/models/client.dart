// models/client.dart
import 'dart:typed_data';

class Client {
  final int? id;
  final String nom;
  final String prenoms;
  final DateTime naissance_date;
  final String naissance_lieu;
  final String pere;
  final String mere;
  final String profession;
  final String domicile;
  final String adresse;
  final String telephone;
  final String nationalite;
  final String piece_type;
  final String piece_numero;
  final DateTime piece_delivrance_date;
  final String piece_delivrance_lieu;
  final String delivrance_by; // ✅ Nouveau champ
  final String photo_recto;
  final String photo_verso;
  final String numero_chambre; // ✅ Nouveau champ
  final Uint8List? signature;
  final String destination;
  final DateTime date_entree;
  final DateTime date_sortie;
  final int user_id; // ✅ ID du réceptionniste
  final int nb_mineur; // ✅ Nombre de mineurs (par défaut 0)

  Client(
      {this.id,
      required this.nom,
      required this.prenoms,
      required this.naissance_date,
      required this.naissance_lieu,
      required this.pere,
      required this.mere,
      required this.profession,
      required this.domicile,
      required this.adresse,
      required this.telephone,
      required this.nationalite,
      required this.piece_type,
      required this.piece_numero,
      required this.piece_delivrance_date,
      required this.piece_delivrance_lieu,
      required this.delivrance_by,
      required this.photo_recto,
      required this.photo_verso,
      required this.numero_chambre,
      required this.signature,
      required this.destination,
      required this.date_entree,
      required this.date_sortie,
      required this.user_id,
      required this.nb_mineur // Valeur par défaut
      });

  Client copyWith({
    int? id,
    String? nom,
    String? prenoms,
    DateTime? naissance_date,
    String? naissance_lieu,
    String? pere,
    String? mere,
    String? profession,
    String? domicile,
    String? adresse,
    String? telephone,
    String? nationalite,
    String? piece_type,
    String? piece_numero,
    DateTime? piece_delivrance_date,
    String? piece_delivrance_lieu,
    String? delivrance_by,
    String? photo_recto,
    String? photo_verso,
    String? numero_chambre,
    Uint8List? signature,
    String? destination,
    DateTime? date_entree,
    DateTime? date_sortie,
    int? userId,
    int? nb_mineur,
  }) {
    return Client(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenoms: prenoms ?? this.prenoms,
      naissance_date: naissance_date ?? this.naissance_date,
      naissance_lieu: naissance_lieu ?? this.naissance_lieu,
      pere: pere ?? this.pere,
      mere: mere ?? this.mere,
      profession: profession ?? this.profession,
      domicile: domicile ?? this.domicile,
      adresse: adresse ?? this.adresse,
      telephone: telephone ?? this.telephone,
      nationalite: nationalite ?? this.nationalite,
      piece_type: piece_type ?? this.piece_type,
      piece_numero: piece_numero ?? this.piece_numero,
      piece_delivrance_date:
          piece_delivrance_date ?? this.piece_delivrance_date,
      piece_delivrance_lieu:
          piece_delivrance_lieu ?? this.piece_delivrance_lieu,
      delivrance_by: delivrance_by ?? this.delivrance_by,
      photo_recto: photo_recto ?? this.photo_recto,
      photo_verso: photo_verso ?? this.photo_verso,
      numero_chambre: numero_chambre ?? this.numero_chambre,
      signature: signature ?? this.signature,
      destination: destination ?? this.destination,
      date_entree: date_entree ?? this.date_entree,
      date_sortie: date_sortie ?? this.date_sortie,
      user_id: user_id ?? this.user_id,
      nb_mineur: nb_mineur ?? this.nb_mineur,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenoms': prenoms,
      'naissance_date': naissance_date.toIso8601String(),
      'naissance_lieu': naissance_lieu,
      'pere': pere,
      'mere': mere,
      'profession': profession,
      'domicile': domicile,
      'adresse': adresse,
      'telephone': telephone,
      'nationalite': nationalite,
      'piece_type': piece_type,
      'piece_numero': piece_numero,
      'piece_delivrance_date': piece_delivrance_date.toIso8601String(),
      'piece_delivrance_lieu': piece_delivrance_lieu,
      'delivrance_by': delivrance_by,
      'photo_recto': photo_recto,
      'photo_verso': photo_verso,
      'numero_chambre': numero_chambre,
      'signature': signature, // sera stocké comme BLOB
      'destination': destination,
      'date_entree': date_entree.toIso8601String(),
      'date_sortie': date_sortie.toIso8601String(),
      'user_id': user_id,
      'nb_mineur': nb_mineur,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      nom: map['nom'],
      prenoms: map['prenoms'],
      naissance_date: DateTime.parse(map['naissance_date']),
      naissance_lieu: map['naissance_lieu'],
      pere: map['pere'],
      mere: map['mere'],
      profession: map['profession'],
      domicile: map['domicile'],
      adresse: map['adresse'],
      telephone: map['telephone'],
      nationalite: map['nationalite'],
      piece_type: map['piece_type'],
      piece_numero: map['piece_numero'],
      piece_delivrance_date: DateTime.parse(map['piece_delivrance_date']),
      piece_delivrance_lieu: map['piece_delivrance_lieu'],
      delivrance_by: map['delivrance_by'],
      photo_recto: map['photo_recto'],
      photo_verso: map['photo_verso'],
      numero_chambre: map['numero_chambre'],
      signature: map['signature'] != null
          ? Uint8List.fromList(map['signature'])
          : null,
      destination: map['destination'],
      date_entree: DateTime.parse(map['date_entree']),
      date_sortie: DateTime.parse(map['date_sortie']),
      user_id: map['user_id'],
      nb_mineur: map['nb_mineur'] ?? 0,
    );
  }
}
