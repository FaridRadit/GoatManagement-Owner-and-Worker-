import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mitrakambing2/model/model.dart';
import 'package:mitrakambing2/controller/controller.dart';

class InsertKambingPage extends StatefulWidget {
  final int mitraId; // Diperlukan untuk relasi ke mitra

  const InsertKambingPage({super.key, required this.mitraId});

  @override
  State<InsertKambingPage> createState() => _InsertKambingPageState();
}

class _InsertKambingPageState extends State<InsertKambingPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomorController = TextEditingController();
  final _kondisiController = TextEditingController();
  final _keteranganController = TextEditingController();

  List<File>? _imageFiles = []; // Menyimpan banyak gambar
  final ImagePicker _picker = ImagePicker();

  // Memilih beberapa gambar
  Future<void> _pickImages(ImageSource source) async {
    final pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _imageFiles = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  // Menampilkan bottom sheet untuk memilih sumber gambar
  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [

              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImages(ImageSource.gallery); // Pilih dari Galeri
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Menyimpan kambing dan foto
  Future<void> _saveKambing() async {
    if (_formKey.currentState!.validate() && _imageFiles!.isNotEmpty) {
      final kambing = Kambing(
        nomorKambing: int.parse(_nomorController.text),
        kondisi: _kondisiController.text,
        keterangan: _keteranganController.text,
        mitraId: widget.mitraId,
        foto: "",  // Kosongkan sementara karena foto akan disimpan terpisah
      );

      // Menyimpan kambing ke database dan mendapatkan ID-nya
      final kambingId = await KambingController().insertKambing(kambing);

      // Menyimpan foto kambing ke database
      for (var image in _imageFiles!) {
        final fotoKambing = FotoKambing(path: image.path, kambingId: kambingId);
        await KambingController().insertFotoKambing(fotoKambing);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data kambing berhasil disimpan')),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi semua field dan gambar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Kambing")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Nomor Kambing"),
                validator: (value) => value!.isEmpty ? "Isi nomor kambing" : null,
              ),
              TextFormField(
                controller: _kondisiController,
                decoration: const InputDecoration(labelText: "Kondisi"),
                validator: (value) => value!.isEmpty ? "Isi kondisi kambing" : null,
              ),
              TextFormField(
                controller: _keteranganController,
                decoration: const InputDecoration(
                    labelText: "Keterangan (Umur,Status, Berat, dll.)"),
                validator: (value) => value!.isEmpty ? "Isi keterangan kambing" : null,
              ),
              const SizedBox(height: 16),
              // Menampilkan foto kambing
              _imageFiles != null && _imageFiles!.isNotEmpty
                  ? Column(
                children: _imageFiles!
                    .map((file) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.file(file, height: 150),
                ))
                    .toList(),
              )
                  : const Text("Belum ada gambar"),
              TextButton.icon(
                onPressed: () => _showImageSourceActionSheet(context),
                icon: const Icon(Icons.photo),
                label: const Text("Ambil Gambar"),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveKambing,
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
