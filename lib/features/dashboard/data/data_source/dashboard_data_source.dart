import '/core/common/models/dishes.dart';
import '/core/common/models/order.dart';
import '/core/common/models/section.dart';
import '/core/common/models/species.dart';
import '/src/app_export.dart';

class DashboardDataSource {
  final _firebaseDatabase = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getOrders() async {
    return await _firebaseDatabase.collection('orders').get();
  }

  Future<void> addOrder(OrderModel order) async {
    final data =
        await _firebaseDatabase.collection('orders').add(order.toJson());
    await _firebaseDatabase
        .collection('orders')
        .doc(data.id)
        .update({'id': data.id});
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDishes() async {
    return await _firebaseDatabase.collection('dishes').get();
  }

  Future<void> addDish(DishesModel dish) async {
    final data =
        await _firebaseDatabase.collection('dishes').add(dish.toJson());
    await _firebaseDatabase
        .collection('dishes')
        .doc(data.id)
        .update({'id': data.id});
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSections() async {
    return await _firebaseDatabase.collection('sections').get();
  }

  Future<void> addSection(SectionModel section) async {
    final data =
        await _firebaseDatabase.collection('sections').add(section.toJson());
    await _firebaseDatabase
        .collection('sections')
        .doc(data.id)
        .update({'id': data.id});
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSpecies() async {
    return await _firebaseDatabase.collection('species').get();
  }

  Future<void> addSpecies(SpeciesModel species) async {
    final data =
        await _firebaseDatabase.collection('species').add(species.toJson());
    await _firebaseDatabase
        .collection('species')
        .doc(data.id)
        .update({'id': data.id});
  }
}
