import '../data_source/dashboard_data_source.dart';
import '/core/common/models/dishes.dart';
import '/core/common/models/order.dart';
import '/core/common/models/section.dart';
import '/core/common/models/species.dart';
import '/src/app_export.dart';

class DashboardRepository {
  final DashboardDataSource _dashboardDataSource;

  DashboardRepository(this._dashboardDataSource);

  Future<List<OrderModel>> getOrders() async {
    try {
      final data = await _dashboardDataSource.getOrders();
      return data.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();
    } on FirebaseException catch (_) {
      return List.empty();
    }
  }

  Future<void> addOrder(OrderModel order) async {
    try {
      await _dashboardDataSource.addOrder(order);
    } on FirebaseException catch (_) {
      return;
    }
  }

  Future<List<DishesModel>> getDishes() async {
    try {
      final data = await _dashboardDataSource.getDishes();
      return data.docs.map((doc) => DishesModel.fromJson(doc.data())).toList();
    } on FirebaseException catch (_) {
      return List.empty();
    }
  }

  Future<void> addDish(DishesModel dishes) async {
    try {
      await _dashboardDataSource.addDish(dishes);
    } on FirebaseException catch (_) {
      return;
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

  Future<List<SpeciesModel>> getSpecies() async {
    try {
      final data = await _dashboardDataSource.getSpecies();
      return data.docs.map((doc) => SpeciesModel.fromJson(doc.data())).toList();
    } on FirebaseException catch (_) {
      return List.empty();
    }
  }

  Future<void> addSpecies(SpeciesModel species) async {
    try {
      await _dashboardDataSource.addSpecies(species);
    } on FirebaseException catch (_) {
      return;
    }
  }
}
