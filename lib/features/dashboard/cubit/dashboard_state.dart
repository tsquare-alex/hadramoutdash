part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

//Todo:Order's State
class GetOrderDashboardLoading extends DashboardState {}
class GetOrderDashboardSuccess extends DashboardState {}
class GetOrderDashboardError extends DashboardState {
  final String errorMessage;

  GetOrderDashboardError({required this.errorMessage});
}
class UpdateOrderDashboardSuccess extends DashboardState {}
class UpdateOrderDashboardError extends DashboardState {
  final String errorMessage;
  UpdateOrderDashboardError({required this.errorMessage});
}
class DeleteOrderDashboardSuccess extends DashboardState {}
class DeleteOrderDashboardError extends DashboardState {
  final String errorMessage;
  DeleteOrderDashboardError({required this.errorMessage});
}



//Todo: Dishes
class GetSpeciesDashboardLoading extends DashboardState {}
class GetSpeciesDashboardSuccess extends DashboardState {}
class GetSpeciesDashboardError extends DashboardState {
  final String errorMessage;

  GetSpeciesDashboardError({required this.errorMessage});
}
class AddSpeciesDashboardSuccess extends DashboardState {}
class AddSpeciesImageDashboardSuccess extends DashboardState {}

class AddSpeciesImageDashboardError extends DashboardState {
  final String errorMessage;

  AddSpeciesImageDashboardError({required this.errorMessage});

}
class ImagePickLoading extends DashboardState {}

class ImagePickedSuccessfully extends DashboardState {
  final String imagePath;

  ImagePickedSuccessfully(this.imagePath);
}

class ImagePickError extends DashboardState {
  final String errorMessage;

  ImagePickError({required this.errorMessage});
}
class AddSpeciesDashboardError extends DashboardState {
  final String errorMessage;

  AddSpeciesDashboardError({required this.errorMessage});

}
class AddSpeciesDashboardLoading extends DashboardState {}
class DeleteSpeciesDashboardSuccess extends DashboardState {}

class DeleteSpeciesDashboardError extends DashboardState {
  final String errorMessage;
  DeleteSpeciesDashboardError({required this.errorMessage});
}
class DeleteSpeciesImageDashboardError extends DashboardState {
  final String errorMessage;
  DeleteSpeciesImageDashboardError({required this.errorMessage});
}

class UpdateSpeciesDashboardSuccess extends DashboardState {}
class UpdateSpeciesDashboardError extends DashboardState {
  final String errorMessage;
  UpdateSpeciesDashboardError({required this.errorMessage});
}
class DeleteOldSpeciesImageDashboardError extends DashboardState {
  final String errorMessage;
  DeleteOldSpeciesImageDashboardError({required this.errorMessage});
}



//Todo:Sections
class GetSectionDashboardLoading extends DashboardState {}
class GetSectionDashboardSuccess extends DashboardState {}
class GetSectionDashboardError extends DashboardState {
  final String errorMessage;

  GetSectionDashboardError({required this.errorMessage});
}
class AddSectionDashboardSuccess extends DashboardState {}
class AddSectionDashboardError extends DashboardState {
  final String errorMessage;

  AddSectionDashboardError({required this.errorMessage});

}
class AddSectionDashboardLoading extends DashboardState {}
class UpdateSectionDashboardSuccess extends DashboardState {}
class UpdateSectionDashboardError extends DashboardState {
  final String errorMessage;
  UpdateSectionDashboardError({required this.errorMessage});
}
class DeleteSectionDashboardSuccess extends DashboardState {}
class DeleteSectionDashboardError extends DashboardState {
  final String errorMessage;
  DeleteSectionDashboardError({required this.errorMessage});
}





class ChangeDrawerIndex extends DashboardState {}