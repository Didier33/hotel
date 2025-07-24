class Client {
  final int? id;
  final String nom;
  final String prenoms;
  final DateTime naissanceDate;
  final String naissanceLieu;
  final String pere;
  final String mere;
  final String profession;
  final String domicile;
  final String adresse;
  final String telephone;
  final String nationalite;
  final String pieceType;
  final String pieceNumero;
  final DateTime pieceDelivranceDate;
  final String pieceDelivranceLieu;
  final String photoRecto;
  final String photoVerso;
  final String empreinte;
  final String signature;
  final String destination;
  final DateTime dateEntree;
  final DateTime dateSortie;
  final DateTime dateEnregistrement;
  final int utilisateurId;

  Client({
    this.id,
    required this.nom,
    required this.prenoms,
    required this.naissanceDate,
    required this.naissanceLieu,
    required this.pere,
    required this.mere,
    required this.profession,
    required this.domicile,
    required this.adresse,
    required this.telephone,
    required this.nationalite,
    required this.pieceType,
    required this.pieceNumero,
    required this.pieceDelivranceDate,
    required this.pieceDelivranceLieu,
    required this.photoRecto,
    required this.photoVerso,
    required this.empreinte,
    required this.signature,
    required this.destination,
    required this.dateEntree,
    required this.dateSortie,
    required this.dateEnregistrement,
    required this.utilisateurId,
  });

  // ✅ Ajout de la méthode copyWith
  Client copyWith({
    int? id,
    String? nom,
    String? prenoms,
    DateTime? naissanceDate,
    String? naissanceLieu,
    String? pere,
    String? mere,
    String? profession,
    String? domicile,
    String? adresse,
    String? telephone,
    String? nationalite,
    String? pieceType,
    String? pieceNumero,
    DateTime? pieceDelivranceDate,
    String? pieceDelivranceLieu,
    String? photoRecto,
    String? photoVerso,
    String? empreinte,
    String? signature,
    String? destination,
    DateTime? dateEntree,
    DateTime? dateSortie,
    DateTime? dateEnregistrement,
    int? utilisateurId,
  }) {
    return Client(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenoms: prenoms ?? this.prenoms,
      naissanceDate: naissanceDate ?? this.naissanceDate,
      naissanceLieu: naissanceLieu ?? this.naissanceLieu,
      pere: pere ?? this.pere,
      mere: mere ?? this.mere,
      profession: profession ?? this.profession,
      domicile: domicile ?? this.domicile,
      adresse: adresse ?? this.adresse,
      telephone: telephone ?? this.telephone,
      nationalite: nationalite ?? this.nationalite,
      pieceType: pieceType ?? this.pieceType,
      pieceNumero: pieceNumero ?? this.pieceNumero,
      pieceDelivranceDate: pieceDelivranceDate ?? this.pieceDelivranceDate,
      pieceDelivranceLieu: pieceDelivranceLieu ?? this.pieceDelivranceLieu,
      photoRecto: photoRecto ?? this.photoRecto,
      photoVerso: photoVerso ?? this.photoVerso,
      empreinte: empreinte ?? this.empreinte,
      signature: signature ?? this.signature,
      destination: destination ?? this.destination,
      dateEntree: dateEntree ?? this.dateEntree,
      dateSortie: dateSortie ?? this.dateSortie,
      dateEnregistrement: dateEnregistrement ?? this.dateEnregistrement,
      utilisateurId: utilisateurId ?? this.utilisateurId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenoms': prenoms,
      'naissance_date': naissanceDate.toIso8601String(),
      'naissance_lieu': naissanceLieu,
      'pere': pere,
      'mere': mere,
      'profession': profession,
      'domicile': domicile,
      'adresse': adresse,
      'telephone': telephone,
      'nationalite': nationalite,
      'piece_type': pieceType,
      'piece_numero': pieceNumero,
      'piece_delivrance_date': pieceDelivranceDate.toIso8601String(),
      'piece_delivrance_lieu': pieceDelivranceLieu,
      'photo_recto': photoRecto,
      'photo_verso': photoVerso,
      'empreinte': empreinte,
      'signature': signature,
      'destination': destination,
      'date_entree': dateEntree.toIso8601String(),
      'date_sortie': dateSortie.toIso8601String(),
      'date_enregistrement': dateEnregistrement.toIso8601String(),
      'utilisateur_id': utilisateurId,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      nom: map['nom'],
      prenoms: map['prenoms'],
      naissanceDate: DateTime.parse(map['naissance_date']),
      naissanceLieu: map['naissance_lieu'],
      pere: map['pere'],
      mere: map['mere'],
      profession: map['profession'],
      domicile: map['domicile'],
      adresse: map['adresse'],
      telephone: map['telephone'],
      nationalite: map['nationalite'],
      pieceType: map['piece_type'],
      pieceNumero: map['piece_numero'],
      pieceDelivranceDate: DateTime.parse(map['piece_delivrance_date']),
      pieceDelivranceLieu: map['piece_delivrance_lieu'],
      photoRecto: map['photo_recto'],
      photoVerso: map['photo_verso'],
      empreinte: map['empreinte'],
      signature: map['signature'],
      destination: map['destination'],
      dateEntree: DateTime.parse(map['date_entree']),
      dateSortie: DateTime.parse(map['date_sortie']),
      dateEnregistrement: DateTime.parse(map['date_enregistrement']),
      utilisateurId: map['utilisateur_id'],
    );
  }
}
