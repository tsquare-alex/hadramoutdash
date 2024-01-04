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
class AddOrderDashboardSuccess extends DashboardState {}
class AddOrderDashboardError extends DashboardState {
  final String errorMessage;

  AddOrderDashboardError({required this.errorMessage});

}
class AddOrderDashboardLoading extends DashboardState {}



//Todo: Dishes
class GetDishDashboardLoading extends DashboardState {}
class GetDishDashboardSuccess extends DashboardState {}
class GetDishDashboardError extends DashboardState {
  final String errorMessage;

  GetDishDashboardError({required this.errorMessage});
}
class AddDishDashboardSuccess extends DashboardState {}
class AddDishDashboardError extends DashboardState {
  final String errorMessage;

  AddDishDashboardError({required this.errorMessage});

}
class AddDishDashboardLoading extends DashboardState {}



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


//Todo:Species
class GetSpeciesDashboardLoading extends DashboardState {}
class GetSpeciesDashboardSuccess extends DashboardState {}
class GetSpeciesDashboardError extends DashboardState {
  final String errorMessage;

  GetSpeciesDashboardError({required this.errorMessage});
}
class AddSpeciesDashboardSuccess extends DashboardState {}
class AddSpeciesDashboardError extends DashboardState {
  final String errorMessage;

  AddSpeciesDashboardError({required this.errorMessage});

}
class AddSpeciesDashboardLoading extends DashboardState {}

class ChangeDrawerIndex extends DashboardState {}