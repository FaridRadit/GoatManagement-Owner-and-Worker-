import 'dart:convert';

// MITRA
class Mitra {
  final int? id;
  final String nama;
  final String desa;
  final String namaPengecek;
  final String namaPendamping;

  Mitra({
    this.id,
    required this.nama,
    required this.desa,
    required this.namaPengecek,
    required this.namaPendamping,
  });

  factory Mitra.fromJson(Map<String, dynamic> json) => Mitra(
    id: json['id'],
    nama: json['nama'] ?? 'Unknown',
    desa: json['desa'] ?? 'Unknown',
    namaPengecek: json['nama_pengecek'] ?? 'Unknown',
    namaPendamping: json['nama_pendamping'] ?? 'Unknown',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'desa': desa,
    'nama_pengecek': namaPengecek,
    'nama_pendamping': namaPendamping,
  };

  // JSON string helpers
  String toJsonString() => jsonEncode(toJson());
  static Mitra fromJsonString(String jsonString) =>
      Mitra.fromJson(jsonDecode(jsonString));
}

// KAMBING
class Kambing {
  final int? id;
  final int nomorKambing;
  final String kondisi;
  final String keterangan;
  final int mitraId;
  final String foto;

  Kambing({
    this.id,
    required this.nomorKambing,
    required this.kondisi,
    required this.keterangan,
    required this.mitraId,
    required this.foto,
  });

  factory Kambing.fromJson(Map<String, dynamic> json) => Kambing(
    id: json['id'],
    nomorKambing: json['nomorKambing'],
    kondisi: json['kondisi'],
    keterangan: json['keterangan'],
    mitraId: json['mitraId'],
    foto: json['foto'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nomorKambing': nomorKambing,
    'kondisi': kondisi,
    'keterangan': keterangan,
    'mitraId': mitraId,
    'foto': foto,
  };

  String toJsonString() => jsonEncode(toJson());
  static Kambing fromJsonString(String jsonString) =>
      Kambing.fromJson(jsonDecode(jsonString));
}

// FOTO KAMBING
class FotoKambing {
  final int? id;
  final String path;
  final int kambingId;

  FotoKambing({
    this.id,
    required this.path,
    required this.kambingId,
  });

  factory FotoKambing.fromJson(Map<String, dynamic> json) => FotoKambing(
    id: json['id'],
    path: json['path'],
    kambingId: json['kambingId'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'path': path,
    'kambingId': kambingId,
  };

  String toJsonString() => jsonEncode(toJson());
  static FotoKambing fromJsonString(String jsonString) =>
      FotoKambing.fromJson(jsonDecode(jsonString));
}
