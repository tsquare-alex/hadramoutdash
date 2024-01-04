import '../../../core/common/models/dishes.dart';
import '../data/repository/dashboard_repository.dart';
import '/core/common/models/client.dart';
import '/core/common/models/order.dart';
import '/core/common/models/section.dart';
import '/core/common/models/species.dart';
import '/features/dashboard/presentation/screens/dishes_page.dart';
import '/features/dashboard/presentation/screens/main_page.dart';
import '/features/dashboard/presentation/screens/menu_page.dart';
import '/features/dashboard/presentation/screens/offers_page.dart';
import '/features/dashboard/presentation/screens/sections_page.dart';
import '/src/app_export.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Cubit<DashboardState> {
  final DashboardRepository _dashboardRepository;

  DashboardBloc(
    this._dashboardRepository,
  ) : super(DashboardInitial());

  static DashboardBloc get(context) => BlocProvider.of<DashboardBloc>(context);

  late List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  late final List<DishesModel> _dishes = [];

  List<DishesModel> get dishes => _dishes;

  late final List<SectionModel> _sections = [];

  List<SectionModel> get sections => _sections;

  late final List<SpeciesModel> _species = [];

  List<SpeciesModel> get species => _species;
  late String errorMessage;

  //todo Order's Method
  Future<void> getOrders() async {
    emit(GetOrderDashboardLoading());
    final orders = await _dashboardRepository.getOrders();
    // orders.isEmpty ? errorMessage = 'No data' : _orders = orders;
    if (orders.isEmpty) {
      emit(GetOrderDashboardError(errorMessage: 'No data'));
    } else {
      _orders = orders;
      emit(GetOrderDashboardSuccess());
    }
  }

  Future<void> addOrder() async {
    emit(AddOrderDashboardLoading());
    var order = OrderModel(
      id: '',
      cancelled: false,
      client: const ClientModel(
        uid: '2',
        name: 'احمد شهاوي',
        number: 01246845852,
        address: '8 شارع البلح جمب البنزينة',
        building: '4',
        floor: '5',
        apartment: '25',
      ),
      confirmed: false,
      deliveryFees: 20,
      delivered: false,
      price: 7000,
      createdAt: DateTime.now().toIso8601String(),
      species: const [
        SpeciesModel(
          id: 'id',
          title: 'نص فرخة مشوية',
          price: 240,
          createdAt: 'createdAt',
          section: SectionModel(id: 'id', title: 'قسم الدجاج'),
          quantity: 2,
        ),
      ],
      dishes: null,
    );
    await _dashboardRepository.addOrder(order);
    emit(AddOrderDashboardSuccess());
  }

  //Todo Dishes's Method

  Future<void> getDishes() async {
    emit(GetDishDashboardLoading());
    final dishes = await _dashboardRepository.getDishes();
    // dishes.isEmpty ? errorMessage = 'No data' : _dishes = dishes;
    if (dishes.isEmpty) {
      emit(GetDishDashboardError(errorMessage: "'No data'"));
    } else {
      emit(GetDishDashboardSuccess());
    }
  }

  Future<void> addDish() async {
    emit(AddDishDashboardLoading());
    var dish = DishesModel(
      id: "",
      title: "Welcome Dish",
      description: "Montaser & Shahawy Created amazing Dish",
      image:
          "https://img.freepik.com/free-photo/beautiful-sea-ocean-with-cloud-blue-sky_74190-6828.jpg?size=626&ext=jpg&ga=GA1.1.1546980028.1704067200&semt=ais",
      price: 90000000000,
      createdAt: DateTime.now().toString(),
      section: const SectionModel(id: "id", title: "Chicken"),
      offer: false,
      offerValue: 20,
    );
    await _dashboardRepository.addDish(dish);
    emit(AddDishDashboardSuccess());
  }

  //Todo Dishes's Method

  Future<void> getSections() async {
    emit(GetSectionDashboardLoading());
    final sections = await _dashboardRepository.getSections();
    // dishes.isEmpty ? errorMessage = 'No data' : _dishes = dishes;
    if (sections.isEmpty) {
      emit(GetSectionDashboardError(errorMessage: "'No data'"));
    } else {
      emit(GetSectionDashboardSuccess());
    }
  }

  Future<void> addSection() async {
    emit(AddSectionDashboardLoading());
    var section = const SectionModel(id: "id", title: "Section");
    await _dashboardRepository.addSection(section);
    emit(AddSectionDashboardSuccess());
  }

  //Todo Species Method

  Future<void> getSpecies() async {
    emit(GetSpeciesDashboardLoading());
    final species = await _dashboardRepository.getSpecies();
    // dishes.isEmpty ? errorMessage = 'No data' : _dishes = dishes;
    if (species.isEmpty) {
      emit(GetSpeciesDashboardError(errorMessage: "'No data'"));
    } else {
      emit(GetSpeciesDashboardSuccess());
    }
  }

  Future<void> addSpecies() async {
    emit(AddSpeciesDashboardLoading());
    var section = SpeciesModel(
        id: "id",
        title: "New Meals",
        price: 30099,
        createdAt: DateTime.now().toIso8601String(),
        section: const SectionModel(id: "", title: "New Meals"));
    await _dashboardRepository.addSpecies(section);
    emit(AddSpeciesDashboardSuccess());
  }

  List<String> get drawerLabels => _drawerLabels;
  static const List<String> _drawerLabels = [
    'الرئيسية',
    'التصنيفات',
    'المنيو',
    'الاطباق',
    'العروض',
  ];

  List<String> get drawerSelectedIcons => _drawerSelectedIcons;
  static const List<String> _drawerSelectedIcons = [
    ImageConstants.homeIconFill,
    ImageConstants.sectionsIconFill,
    ImageConstants.menuIconFill,
    ImageConstants.dishesIconFill,
    ImageConstants.offersIconFill,
  ];
  List<String> get drawerUnselectedIcons => _drawerUnselectedIcons;
  static const List<String> _drawerUnselectedIcons = [
    ImageConstants.homeIcon,
    ImageConstants.sectionsIcon,
    ImageConstants.menuIcon,
    ImageConstants.dishesIcon,
    ImageConstants.offersIcon,
  ];

  int selectedIndex = 0;
  void changeIndex(int index) {
    emit(DashboardInitial());
    selectedIndex = index;
    emit(ChangeDrawerIndex());
  }

  List screens = [
    const MainPage(),
    const SectionsPage(),
    const MenuPage(),
    const DishesPage(),
    const OffersPage(),
  ];

  bool isSelectedTile(int index, String tileName) {
    return _drawerLabels.indexWhere((element) => element == tileName) ==
        selectedIndex;
  }
}
