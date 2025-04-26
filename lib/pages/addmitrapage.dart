import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitrakambing2/controller/controller.dart';
import 'package:mitrakambing2/model/model.dart';

class AddMitraPage extends StatelessWidget {
  AddMitraPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _desaController = TextEditingController();
  final _pengecekController = TextEditingController();
  final _pendampingController = TextEditingController();

  final MitraController mitraController = Get.find<MitraController>();

  void _saveMitra() async {
    if (_formKey.currentState!.validate()) {
      final mitra = Mitra(
        nama: _namaController.text,
        desa: _desaController.text,
        namaPengecek: _pengecekController.text,
        namaPendamping: _pendampingController.text,
      );
      await mitraController.insertMitra(mitra);
      Get.back(result: true); // Pop with result true
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Mitra',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Mitra",
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? "Isi nama mitra" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _desaController,
                decoration: const InputDecoration(
                  labelText: "Desa",
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? "Isi desa" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pengecekController,
                decoration: const InputDecoration(
                  labelText: "Nama Pengecek",
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? "Isi nama pengecek" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pendampingController,
                decoration: const InputDecoration(
                  labelText: "Nama Pendamping",
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? "Isi nama pendamping" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveMitra,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Simpan Mitra",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
