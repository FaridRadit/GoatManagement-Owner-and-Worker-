import 'package:flutter/material.dart';
import 'package:mitrakambing2/controller/controller.dart';
import 'package:mitrakambing2/model/model.dart';
import 'mitra_detail_page.dart'; // Import halaman detail mitra
import 'addmitrapage.dart';

class ListMitraPage extends StatefulWidget {
  const ListMitraPage({super.key});

  @override
  State<ListMitraPage> createState() => _ListMitraPageState();
}

class _ListMitraPageState extends State<ListMitraPage> {
  List<Mitra> mitraList = [];

  // Load Mitra data
  Future<void> _loadData() async {
    final result = await MitraController().getAllMitra();
    setState(() {
      mitraList = result;
    });
  }

  // Delete Mitra
  Future<void> _deleteMitra(int mitraId) async {
    await MitraController().deleteMitra(mitraId);
    _loadData(); // Reload data after deletion
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Navigate to Add Mitra page
  void _navigateToAddMitra() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) =>  AddMitraPage()),
    );
    if (result == true) _loadData();
  }

  // Navigate to Mitra Detail page
  void _navigateToDetailMitra(Mitra mitra) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MitraDetailPage(mitraId: mitra.id!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Mitra", style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddMitra,
        child: const Icon(Icons.add, size: 30),
        backgroundColor: Colors.blueAccent,
        tooltip: 'Tambah Mitra',
      ),
      body: mitraList.isEmpty
          ? const Center(child: Text("Tidak ada mitra yang terdaftar", style: TextStyle(fontSize: 20)))
          : ListView.builder(
        itemCount: mitraList.length,
        itemBuilder: (_, index) {
          final mitra = mitraList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                mitra.nama,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Desa: ${mitra.desa}\nNama Pendamping: ${mitra.namaPendamping}\nNama Pengecek: ${mitra.namaPengecek}",
                style: const TextStyle(fontSize: 18),
              ),
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, size: 30),
                onSelected: (value) {
                  if (value == 'delete') {
                    _deleteMitra(mitra.id!);
                  } else {
                    _navigateToDetailMitra(mitra);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'detail',
                      child: Row(
                        children: const [
                          Icon(Icons.visibility),
                          SizedBox(width: 8),
                          Text('Lihat Detail', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: const [
                          Icon(Icons.delete),
                          SizedBox(width: 8),
                          Text('Hapus Mitra', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
