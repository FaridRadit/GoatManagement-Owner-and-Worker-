import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../model/model.dart';

class MitraKambingTable extends StatelessWidget {
  MitraKambingTable({super.key});

  final MitraStateController controller = Get.put(MitraStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mitra and Kambing Data'),
      ),
      body: Obx(() {
        // If the data is still loading, show the progress indicator
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Mitra Data'),
              ),
              // Wrap DataTable in SingleChildScrollView horizontally to prevent overflow
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Nama')),
                    DataColumn(label: Text('Desa')),
                    DataColumn(label: Text('Pengecek')),
                    DataColumn(label: Text('Pendamping')),
                  ],
                  rows: controller.mitraList.map<DataRow>((mitra) {
                    return DataRow(cells: [
                      DataCell(Text(mitra.id.toString())),
                      DataCell(Text(mitra.nama)),
                      DataCell(Text(mitra.desa)),
                      DataCell(Text(mitra.namaPengecek)),
                      DataCell(Text(mitra.namaPendamping)),
                    ]);
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // Loop through mitra data and display kambing for each
              ListView.builder(
                shrinkWrap: true,  // Ensures the ListView takes up only the necessary space
                physics: NeverScrollableScrollPhysics(), // Disable scrolling inside ListView
                itemCount: controller.mitraList.length,
                itemBuilder: (context, index) {
                  var mitra = controller.mitraList[index];
                  print("Mitra ID: ${mitra.id}");  // Debug: Check mitra ID

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kambing Data for ${mitra.nama}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Obx(() {
                          final kambingList = controller.kambingMap[mitra.id] ?? [];

                          // Debug: Check kambing data
                          print("Kambing data for Mitra ID ${mitra.id}: $kambingList");

                          return kambingList.isNotEmpty
                              ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const <DataColumn>[
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('Nomor Kambing')),
                                DataColumn(label: Text('Kondisi')),
                                DataColumn(label: Text('Keterangan')),
                                DataColumn(label: Text('Foto')),
                              ],
                              rows: kambingList.map<DataRow>((kambing) {
                                return DataRow(cells: [
                                  DataCell(Text(kambing.id.toString())),
                                  DataCell(Text(kambing.nomorKambing.toString())),
                                  DataCell(Text(kambing.kondisi)),
                                  DataCell(Text(kambing.keterangan)),
                                  DataCell(kambing.foto.isEmpty
                                      ? const Icon(Icons.image_not_supported)
                                      : Image.network(kambing.foto, width: 50, height: 50)),
                                ]);
                              }).toList(),
                            ),
                          )
                              : const Text("No kambing data available.", style: TextStyle(color: Colors.grey));
                        }),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
