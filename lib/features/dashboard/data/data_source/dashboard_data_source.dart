import 'package:firebase_storage/firebase_storage.dart';
import 'package:hadramoutdash/core/common/models/order.dart';

import 'package:hadramoutdash/core/common/models/section.dart';
import 'package:hadramoutdash/core/common/models/species.dart';
import 'package:hadramoutdash/src/app_export.dart';

class DashboardDataSource {
  final _firebaseDatabase = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Future<QuerySnapshot<Map<String, dynamic>>> getOrders() async {
  //   return await _firebaseDatabase.collection('orders').get();
  // }
  //
  // Future<void> addOrder(OrderModel order) async {
  //   final data = await _firebaseDatabase.collection('orders').add(order.toJson());
  //   await _firebaseDatabase.collection('orders').doc(data.id).update({'id': data.id});
  // }


  Future<QuerySnapshot<Map<String, dynamic>>> getOrders() async {
    final result = await _firebaseDatabase.collection('orders')
        // .orderBy('created_at', descending: true)
        .get();
    return result;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrdersStream() {
    return _firebaseDatabase
        .collection('orders')
        .orderBy('created_at', descending: true)
        .snapshots();
  }

  Future<void> deleteOrder(String orderId) async {
    await _firebaseDatabase.collection('orders').doc(orderId).delete();
  }


  Future<void> updateOrder(String orderIdId, OrderModel updatedOrder) async {
    await _firebaseDatabase.collection('orders').doc(orderIdId).update(updatedOrder.toJson());
  }






  Future<QuerySnapshot<Map<String, dynamic>>> getSpecies() async {
    final result = await _firebaseDatabase.collection('species')
        .orderBy('created_at', descending: true)
        .get();
    return result;
  }




  Future<void> addSpecies(SpeciesModel species) async {
    final data = await _firebaseDatabase.collection('species').add(species.toJson());
    await _firebaseDatabase.collection('species').doc(data.id).update({'id': data.id});
  }


  // Future<String?> getOrderImagePath(String orderId) async {
  //   final speciesDoc = await _firebaseDatabase.collection('species').doc(orderId).get();
  //   final speciesData = speciesDoc.data() as Map<String, dynamic>?;
  //
  //   if (speciesData != null) {
  //     return speciesData['image'] as String?;
  //   }
  //
  //   return null;
  // }

  Future<String?> getSpeciesImagePath(String speciesId) async {
    final speciesDoc = await _firebaseDatabase.collection('species').doc(speciesId).get();
    final speciesData = speciesDoc.data() as Map<String, dynamic>?;

    if (speciesData != null) {
      return speciesData['image'] as String?;
    }

    return null;
  }



  Future<void> deleteImage(String imagePath) async {
    try {
      await _firebaseStorage.ref(imagePath).delete();
    } on FirebaseException catch (e) {
      // throw e;
    }
  }


  Future<void> deleteSpecies(String speciesId) async {
    await _firebaseDatabase.collection('species').doc(speciesId).delete();
  }


  Future<void> updateSpecies(String speciesId, SpeciesModel updatedSpecies) async {
    await _firebaseDatabase.collection('species').doc(speciesId).update(updatedSpecies.toJson());
  }


  Future<QuerySnapshot<Map<String, dynamic>>> getSections() async {
    return await _firebaseDatabase.collection('sections').get();
  }

  Future<void> addSection(SectionModel section) async {
    final data = await _firebaseDatabase.collection('sections').add(section.toJson());
    await _firebaseDatabase.collection('sections').doc(data.id).update({'id': data.id});
  }
  Future<void> updateSection(String sectionId, SectionModel updateSection) async {
    await _firebaseDatabase.collection('sections').doc(sectionId).update(updateSection.toJson());
  }
  Future<void> deleteSection(String sectionId) async {
    await _firebaseDatabase.collection('sections').doc(sectionId).delete();
  }



}
