import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/feature_repository.dart';

part 'feature_state.dart';

class FeatureBloc extends Cubit<FeatureState> {
  final FeatureRepository _featureRepository;
  FeatureBloc(
    this._featureRepository,
  ) : super(FeatureInitial());

  static FeatureBloc get(context) => BlocProvider.of<FeatureBloc>(context);

  void yourFunction() {
    _featureRepository.yourFunction();
  }
}
