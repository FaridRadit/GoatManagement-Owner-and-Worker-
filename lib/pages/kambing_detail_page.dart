import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import '../model/model.dart';
import 'package:mitrakambing2/controller/controller.dart';

class KambingDetailPage extends StatelessWidget {
  final Kambing kambing;

  KambingDetailPage({super.key, required this.kambing});

  final KambingDetailController  controller = Get.put(KambingDetailController ());

  @override
  Widget build(BuildContext context) {
    // Start fetching the photos on init
    controller.fetchFotos(kambing.id!);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Kambing",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nomor Kambing
              Text(
                "Nomor Kambing: ${kambing.nomorKambing}",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Kondisi
              Text(
                "Kondisi: ${kambing.kondisi}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 12),

              // Keterangan
              Text(
                "Keterangan: ${kambing.keterangan}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),

              // Foto Kambing
              const Text(
                "Foto Kambing:",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.errorMessage.isNotEmpty) {
                  return Text(
                    controller.errorMessage.value,
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  );
                } else if (controller.fotoList.isNotEmpty) {
                  return Column(
                    children: controller.fotoList.map((foto) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(foto.path),
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return const Text(
                    "Foto Kambing Tidak Tersedia",
                    style: TextStyle(fontSize: 18),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
