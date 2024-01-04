import '../data_source/feature_data_source.dart';

class FeatureRepository {
  final FeatureDataSource _featureDataSource;

  FeatureRepository(this._featureDataSource);

  void yourFunction() {
    _featureDataSource.yourGetDataFunction();
  }
}
