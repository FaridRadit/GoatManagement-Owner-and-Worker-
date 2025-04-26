import 'package:get/get.dart';
import 'package:mitrakambing2/database/db_helper.dart';
import 'package:mitrakambing2/model/model.dart';
import 'package:sqflite/sqflite.dart';

class MitraController {
  // Insert Mitra
  Future<int> insertMitra(Mitra mitra) async {
    final dbClient = await DBHelper.db;
    try {
      final id = await dbClient.insert(
        'mitra',
        mitra.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e) {
      print('Error inserting mitra data: $e');
      return -1;
    }
  }

  // Get all Mitra
  Future<List<Mitra>> getAllMitra() async {
    try {
      final dbClient = await DBHelper.db;
      final result = await dbClient.query('mitra');
      return result.map((data) => Mitra.fromJson(data)).toList();
    } catch (e) {
      print('Error fetching mitra data: $e');
      return [];
    }
  }

  // Get Mitra by ID
  Future<Mitra?> getMitraById(int id) async {
    final dbClient = await DBHelper.db;
    final result = await dbClient.query(
      'mitra',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Mitra.fromJson(result.first);
    }
    return null;
  }

  // Update Mitra
  Future<void> updateMitra(Mitra mitra) async {
    final dbClient = await DBHelper.db;
    try {
      await dbClient.update(
        'mitra',
        mitra.toJson(),
        where: 'id = ?',
        whereArgs: [mitra.id],
      );
    } catch (e) {
      print('Error updating mitra data: $e');
    }
  }

  // Delete Mitra
  Future<void> deleteMitra(int id) async {
    final dbClient = await DBHelper.db;
    try {
      await dbClient.delete(
        'mitra',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting mitra: $e');
    }
  }
}

class KambingController {
  // Insert Kambing
  Future<int> insertKambing(Kambing kambing) async {
    final dbClient = await DBHelper.db;
    try {
      final id = await dbClient.insert(
        'kambing',
        kambing.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e) {
      print('Error inserting kambing data: $e');
      return -1;
    }
  }

  // Get all Kambing
  Future<List<Kambing>> getAllKambing() async {
    final dbClient = await DBHelper.db;
    final result = await dbClient.query('kambing');
    return result.map((json) => Kambing.fromJson(json)).toList();
  }

  // Get Kambing by Mitra ID
  Future<List<Kambing>> getKambingByMitraId(int mitraId) async {
    final dbClient = await DBHelper.db;
    final result = await dbClient.query(
      'kambing',
      where: 'mitraId = ?', // make sure this matches your DB column
      whereArgs: [mitraId],
    );
    return result.map((json) => Kambing.fromJson(json)).toList();
  }

  // Get Kambing by ID
  Future<Kambing?> getKambingById(int id) async {
    final dbClient = await DBHelper.db;
    final result = await dbClient.query(
      'kambing',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Kambing.fromJson(result.first);
    }
    return null;
  }

  // Update Kambing
  Future<void> updateKambing(Kambing kambing) async {
    final dbClient = await DBHelper.db;
    try {
      await dbClient.update(
        'kambing',
        kambing.toJson(),
        where: 'id = ?',
        whereArgs: [kambing.id],
      );
    } catch (e) {
      print('Error updating kambing data: $e');
    }
  }

  // Delete Kambing
  Future<void> deleteKambing(int id) async {
    final dbClient = await DBHelper.db;
    try {
      await dbClient.delete(
        'kambing',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting kambing: $e');
    }
  }

  // Insert Foto Kambing
  Future<void> insertFotoKambing(FotoKambing fotoKambing) async {
    final dbClient = await DBHelper.db;
    try {
      await dbClient.insert(
        'foto_kambing',
        fotoKambing.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting foto kambing: $e');
    }
  }

  // Get Foto Kambing by Kambing ID
  Future<List<FotoKambing>> getFotoKambingByKambingId(int kambingId) async {
    final dbClient = await DBHelper.db;
    final result = await dbClient.query(
      'foto_kambing',
      where: 'kambingId = ?', // use camelCase to match your DB column
      whereArgs: [kambingId],
    );
    return result.map((json) => FotoKambing.fromJson(json)).toList();
  }

  // Delete Foto Kambing
  Future<void> deleteFotoKambing(int id) async {
    final dbClient = await DBHelper.db;
    try {
      await dbClient.delete(
        'foto_kambing',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting foto kambing: $e');
    }
  }
}

class MitraStateController extends GetxController {
  final MitraController _mitraController = MitraController();
  final KambingController _kambingController = KambingController();
  var mitraList = <Mitra>[].obs;
  var kambingMap = <int, List<Kambing>>{}.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadMitra();
    fetchAllData(); // Automatically load data when the controller is first used
  }

  // Fetch all Mitra and related Kambing data
  Future<void> fetchAllData() async {
    try {
      isLoading(true);
      List<Mitra> mitraFetched = await _mitraController.getAllMitra();
      mitraList.assignAll(mitraFetched); // Update mitraList

      for (var mitra in mitraFetched) {
        if (mitra.id != null) {
          List<Kambing> kambingFetched = await _kambingController.getKambingByMitraId(mitra.id!);
          kambingMap[mitra.id!] = kambingFetched; // Update kambingMap
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading(false); // Turn off loading state after data fetch
    }
  }

  // Load Mitra without re-fetching kambing (for optimized performance)
  Future<void> loadMitra() async {
    try {
      isLoading(true); // Set loading to true for initial load
      final list = await _mitraController.getAllMitra();
      mitraList.assignAll(list); // Update mitra list
    } catch (e) {
      print('Error loading mitra list: $e');
    } finally {
      isLoading(false); // Set loading to false when done
    }
  }

  // Add a new Mitra
  Future<void> addMitra(Mitra mitra) async {
    try {
      await _mitraController.insertMitra(mitra);
      await loadMitra(); // Refresh list after adding a new Mitra
    } catch (e) {
      print('Error adding mitra: $e');
    }
  }

  // Delete a Mitra by ID
  Future<void> deleteMitra(int id) async {
    try {
      await _mitraController.deleteMitra(id);
      await loadMitra(); // Refresh list after deleting a Mitra
    } catch (e) {
      print('Error deleting mitra: $e');
    }
  }

  // Update a Mitra
  Future<void> updateMitra(Mitra mitra) async {
    try {
      await _mitraController.updateMitra(mitra);
      await loadMitra(); // Refresh list after updating a Mitra
    } catch (e) {
      print('Error updating mitra: $e');
    }
  }

  // Get Mitra by ID
  Mitra? getMitraById(int id) {
    try {
      return mitraList.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}

class KambingControllerGetX extends GetxController {
  var kambingList = <Kambing>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  Future<void> loadKambing(int mitraId) async {
    try {
      isLoading(true);
      final result = await KambingController().getKambingByMitraId(mitraId);
      kambingList.assignAll(result);
      errorMessage('');
    } catch (e) {
      errorMessage('Error loading kambing: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteKambing(int kambingId) async {
    try {
      await KambingController().deleteKambing(kambingId);
      kambingList.removeWhere((k) => k.id == kambingId);
    } catch (e) {
      errorMessage('Error deleting kambing: $e');
    }
  }
}

class KambingDetailController extends GetxController {
  final KambingController _kambingController = KambingController();

  var fotoList = <FotoKambing>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  Future<void> fetchFotos(int kambingId) async {
    try {
      isLoading(true);
      errorMessage('');
      final result = await _kambingController.getFotoKambingByKambingId(kambingId);
      fotoList.assignAll(result);
    } catch (e) {
      errorMessage('Gagal memuat foto');
    } finally {
      isLoading(false);
    }
  }
}
