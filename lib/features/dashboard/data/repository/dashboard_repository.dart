import 'package:hadramoutdash/core/common/models/order.dart';
import 'package:hadramoutdash/core/common/models/dishes.dart';
import 'package:hadramoutdash/core/common/models/order.dart';
import 'package:hadramoutdash/core/common/models/section.dart';
import 'package:hadramoutdash/core/common/models/species.dart';
import 'package:hadramoutdash/src/app_export.dart';

import '../data_source/dashboard_data_source.dart';

class DashboardRepository {
  final DashboardDataSource _dashboardDataSource;

  DashboardRepository(this._dashboardDataSource);

  Future<List<OrderModel>> getOrder() async {
    try {
      final data = await _dashboardDataSource.getOrders();
      return data.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();
    } on FirebaseException catch (_) {
      return List.empty();
    }
  }

  Stream<List<OrderModel>> getOrderStream() async* {
    try {
      await for (var data in _dashboardDataSource.getOrdersStream()) {
        yield data.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();
      }
    } catch (_) {
      yield List.empty();
    }
  }

  Future<void> updateOrder(String orderId, OrderModel updatedOrder) async {
    try {
      await _dashboardDataSource.updateOrder(orderId, updatedOrder);
    } on FirebaseException catch (_) {
      rethrow; // Rethrow the exception
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      // final imagePath = await getSpeciesImagePath(speciesId);

      await _dashboardDataSource.deleteOrder(orderId);

      // if (imagePath != null) {
      //   await _dashboardDataSource.deleteImage(imagePath);
      // }
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<void> addSpecies(SpeciesModel species) async {
    try {
      await _dashboardDataSource.addSpecies(species);
    } on FirebaseException catch (_) {
      return;
    }
  }

  Future<void> updateSpecies(
      String speciesId, SpeciesModel updatedSpecies) async {
    try {
      await _dashboardDataSource.updateSpecies(speciesId, updatedSpecies);
    } on FirebaseException catch (_) {
      rethrow; // Rethrow the exception
    }
  }

  Future<String?> getSpeciesImagePath(String speciesId) async {
    return await _dashboardDataSource.getSpeciesImagePath(speciesId);
  }

  Future<List<SpeciesModel>> getSpecies() async {
    try {
      final data = await _dashboardDataSource.getSpecies();
      return data.docs.map((doc) => SpeciesModel.fromJson(doc.data())).toList();
    } on FirebaseException catch (_) {
      return List.empty();
    }
  }

  // Future<String?> getSpeciesImagePath(String speciesId) async {
  //   return await _dashboardDataSource.getSpeciesImagePath(speciesId);
  // }

  Future<void> deleteSpecies(String speciesId) async {
    try {
      final imagePath = await getSpeciesImagePath(speciesId);

      await _dashboardDataSource.deleteSpecies(speciesId);

      if (imagePath != null) {
        await _dashboardDataSource.deleteImage(imagePath);
      }
    } on FirebaseException catch (_) {
      rethrow; // throw e;
    }
  }

  Future<void> deleteSection(String sectionId) async {
    try {
      await _dashboardDataSource.deleteSection(sectionId);
    } on FirebaseException catch (_) {
      rethrow; // throw e;
    }
  }

  Future<void> updateSection(
      String sectionId, SectionModel updateSection) async {
    try {
      await _dashboardDataSource.updateSection(sectionId, updateSection);
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<List<SectionModel>> getSections() async {
    try {
      final data = await _dashboardDataSource.getSections();
      return data.docs.map((doc) => SectionModel.fromJson(doc.data())).toList();
    } on FirebaseException catch (_) {
      return List.empty();
    }
  }

  Future<void> addSection(SectionModel section) async {
    try {
      await _dashboardDataSource.addSection(section);
    } on FirebaseException catch (_) {
      return;
    }
  }
}
