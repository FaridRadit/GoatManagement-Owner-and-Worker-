import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitrakambing2/controller/controller.dart';
import 'package:mitrakambing2/pages/insertkambingpage.dart';
import 'package:mitrakambing2/pages/kambing_detail_page.dart';
import '../model/model.dart';

class MitraDetailPage extends StatelessWidget {
  final int mitraId;
  final KambingControllerGetX kambingController = Get.put(KambingControllerGetX());

  MitraDetailPage({super.key, required this.mitraId}) {
    kambingController.loadKambing(mitraId);
  }

  void _navigateToAddKambing(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InsertKambingPage(mitraId: mitraId),
      ),
    );
    if (result == true) kambingController.loadKambing(mitraId);
  }

  void _navigateToDetailKambing(BuildContext context, Kambing kambing) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KambingDetailPage(kambing: kambing),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Mitra", style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddKambing(context),
        child: const Icon(Icons.add, size: 30),
        backgroundColor: Colors.blueAccent,
        tooltip: 'Tambah Kambing',
      ),
      body: Obx(() {
        if (kambingController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (kambingController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(kambingController.errorMessage.value, style: const TextStyle(color: Colors.red)),
          );
        }

        final list = kambingController.kambingList;

        if (list.isEmpty) {
          return const Center(child: Text("Tidak ada kambing yang terdaftar", style: TextStyle(fontSize: 20)));
        }

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, index) {
            final kambing = list[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  "Nomor Kambing: ${kambing.nomorKambing}",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Kondisi: ${kambing.kondisi}", style: const TextStyle(fontSize: 18)),
                trailing: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 30),
                  onSelected: (value) {
                    if (value == 'delete') {
                      kambingController.deleteKambing(kambing.id!);
                    } else {
                      _navigateToDetailKambing(context, kambing);
                    }
                  },
                  itemBuilder: (_) => [
                    const PopupMenuItem<String>(
                      value: 'detail',
                      child: Row(children: [Icon(Icons.visibility), SizedBox(width: 8), Text('Lihat Detail')]),
                    ),
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(children: [Icon(Icons.delete), SizedBox(width: 8), Text('Hapus Kambing')]),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
