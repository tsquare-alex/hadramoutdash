
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hadramoutdash/core/common/models/client.dart';
import 'package:hadramoutdash/core/common/models/order.dart';
import 'package:hadramoutdash/core/common/models/section.dart';
import 'package:hadramoutdash/core/common/models/species.dart';
import 'package:hadramoutdash/features/dashboard/presentation/screens/dishes_page.dart';
import 'package:hadramoutdash/features/dashboard/presentation/screens/main_page.dart';
import 'package:hadramoutdash/features/dashboard/presentation/screens/menu_page.dart';
import 'package:hadramoutdash/features/dashboard/presentation/screens/order_page.dart';
import 'package:hadramoutdash/features/dashboard/presentation/screens/sections_page.dart';
import 'package:hadramoutdash/src/app_export.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../core/common/models/dishes.dart';
import '../data/repository/dashboard_repository.dart';
part 'dashboard_state.dart';


class DashboardBloc extends Cubit<DashboardState> {
  final DashboardRepository _dashboardRepository;

  DashboardBloc(
      this._dashboardRepository,
      ) : super(DashboardInitial());

  static DashboardBloc get(context) => BlocProvider.of<DashboardBloc>(context);
  AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;


  late List<SectionModel> _sections = [];

  List<SectionModel> get sections => _sections;


  late String errorMessage;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? fileName;
  String? downloadUrl;
  PlatformFile? pickedImage;


  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController createdAtController = TextEditingController();
  TextEditingController offerController = TextEditingController();
  TextEditingController offerValueController = TextEditingController();


  late List<OrderModel> _order = [];

  List<OrderModel> get order => _order;

  Future<void> getOrder() async {
    try {
      emit(GetOrderDashboardLoading());

      final List<OrderModel> orderList = await _dashboardRepository.getOrder();

      if (orderList.isNotEmpty) {
        _order = orderList;
        emit(GetOrderDashboardSuccess());
      } else {
        emit(GetOrderDashboardError(errorMessage: "Invalid or empty order data"));
      }
    } catch (error) {
      print('Error in getOrder: $error');
      emit(GetOrderDashboardError(errorMessage: error.toString()));
    }
  }




  Future<void> updateOrder(String orderId, OrderModel updatedOrder) async {
    try {


      await _dashboardRepository.updateOrder(orderId, updatedOrder);
      emit(UpdateOrderDashboardSuccess());
    } catch (error) {
      print("Error updating dish: $error");
      emit(UpdateOrderDashboardError(errorMessage: error.toString()));
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await _dashboardRepository.deleteOrder(orderId);

      _order.removeWhere((order) => order.id == orderId);
      emit(DeleteOrderDashboardSuccess());
    } catch (error) {
      emit(DeleteOrderDashboardError(errorMessage: error.toString()));
    }
  }

  Future<void> addSpecies() async {
    try {
      double price = double.parse(priceController.text);


      String? imageUrl;
      if (pickedImage != null) imageUrl = await uploadSpeciesImage();
      imageUrl ??= "";

      SpeciesModel specices = SpeciesModel(
        id: "",
        title: titleController.text,
        description: descController.text,
        image: imageUrl,
        price: price,
        createdAt: DateTime.now().toString(),
        section: SectionModel(id: "id", title: selectedSection),
        offer: false,
        offerValue: 20,
      );

      await _dashboardRepository.addSpecies(specices);
      emit(AddSpeciesDashboardSuccess());
    } catch (error) {
      print("Error adding dish: $error");
      emit(AddSpeciesDashboardError(errorMessage: error.toString()));
    }
  }
  late List<SpeciesModel> _species = [];

  List<SpeciesModel> get species => _species;
  Future<void> getSpecies() async {
    try {
      emit(GetSpeciesDashboardLoading());

      final species = await _dashboardRepository.getSpecies();


      _species = species;
      emit(GetSpeciesDashboardSuccess());

    } catch (error) {
      emit(GetSpeciesDashboardError(errorMessage: error.toString()));
    }
  }
  Future<void> updateSpecies(String speciesId, SpeciesModel updatedSpecies) async {
    try {
      // Get the old dish data
      SpeciesModel oldSpecies = _species.firstWhere((dish) => dish.id == speciesId);

      // Check if the image has been changed
      if (oldSpecies.image != updatedSpecies.image) {
        // Check if there is an old image to delete
        if (oldSpecies.image != null && oldSpecies.image!.isNotEmpty) {
          String imageName = Uri.parse(oldSpecies.image!).pathSegments.last;

          Reference oldImageRef = _storage.ref().child(imageName);

          try {
            // Attempt to get the download URL, will throw an error if not exists
            await oldImageRef.getDownloadURL();

            // If no error occurred, the file exists, proceed with deletion
            await oldImageRef.delete();
            print("Old Species image deleted successfully");
          } catch (error) {
            if (error is FirebaseException && error.code == 'storage/object-not-found') {
              // Handle the case where the file doesn't exist
              print("Old Species image does not exist");
            } else {
              // Handle other errors
              print("Error deleting old Species image: $error");
            }
          }
        }
      }

      // Update the dish data with the new image URL
      await _dashboardRepository.updateSpecies(speciesId, updatedSpecies);
      emit(UpdateSpeciesDashboardSuccess());
    } catch (error) {
      print("Error updating dish: $error");
      emit(UpdateSpeciesDashboardError(errorMessage: error.toString()));
    }
  }
  Future<void> deleteSpecies(String speciesId) async {
    try {
      await _dashboardRepository.deleteSpecies(speciesId);

      _species.removeWhere((species) => species.id == speciesId);
      emit(DeleteSpeciesDashboardSuccess());
    } catch (error) {
      emit(DeleteSpeciesDashboardError(errorMessage: error.toString()));
    }
  }

  String selectedSection = '';

  void updateSelectedSection(SectionModel section) {
    selectedSection = section.title;
  }

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      pickedImage = result.files.first;
      fileName = pickedImage!.name;
      emit(AddSpeciesImageDashboardSuccess());
    }
  }


  Future<String?> uploadSpeciesImage() async {
    try {
      String imageName = Uuid().v4(); // This will generate a unique UUID

      // Reference ref = _storage.ref().child("Species").child(fileName!);
      Reference ref = _storage.ref().child("Species").child("$imageName.png");
      SettableMetadata metadata = SettableMetadata(contentType: 'image/png');
      Uint8List imageData = pickedImage!.bytes!;
      await ref.putData(imageData, metadata);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print("Error uploading Species image: $error");
      emit(AddSpeciesImageDashboardError(errorMessage: error.toString()));
      return null;
    }
  }

//todo updaet dishes
  final GlobalKey<FormState> updateDishFormKey = GlobalKey<FormState>();
  late TextEditingController updateDishTitleController;
  late TextEditingController updateDishDescriptionController;
  late TextEditingController updateDishPriceController;
  late TextEditingController updateDishSectionController;
  late TextEditingController updateDishOfferValueController;


  bool isLoading = false;

  Future<void> deleteSection(String sectionId) async {
    try {
      await _dashboardRepository.deleteSection(sectionId);

      _sections.removeWhere((section) => section.id == sectionId);
      emit(DeleteSectionDashboardSuccess());
    } catch (error) {
      emit(DeleteSectionDashboardError(errorMessage: error.toString()));
    }
  }


  Future<void> updateSection(String sectionId, SectionModel updatedSection) async {
    try {
      await _dashboardRepository.updateSection(sectionId, updatedSection);
      emit(UpdateSectionDashboardSuccess());
    } catch (error) {
      print("Error updating dish: $error");
      emit(UpdateSectionDashboardError(errorMessage: error.toString()));
    }
  }


  Future<void> getSections() async {
    try{
    emit(GetSectionDashboardLoading());

    final sections = await _dashboardRepository.getSections();
    print("${sections} =========================================================");

      _sections = sections;
      emit(GetSectionDashboardSuccess());
    }catch (error){
      emit(GetSectionDashboardError(errorMessage: error.toString()));

    }
  }




  TextEditingController sectionTitleController = TextEditingController();

  Future<void> addSection() async {
    emit(AddSectionDashboardLoading());
    var section =  SectionModel(id: "id", title: sectionTitleController.text);
    await _dashboardRepository.addSection(section);
    emit(AddSectionDashboardSuccess());
  }









  List<String> get drawerLabels => _drawerLabels;
  static const List<String> _drawerLabels = [
    // 'الرئيسية',
    'التصنيفات',
    'المنيو',
    // 'الاطباق',
    'الاوردرات',
  ];

  List<String> get drawerSelectedIcons => _drawerSelectedIcons;
  static const List<String> _drawerSelectedIcons = [
    // ImageConstants.homeIconFill,
    ImageConstants.sectionsIconFill,
    ImageConstants.menuIconFill,
    // ImageConstants.dishesIconFill,
    ImageConstants.offersIconFill,
  ];
  List<String> get drawerUnselectedIcons => _drawerUnselectedIcons;
  static const List<String> _drawerUnselectedIcons = [
    // ImageConstants.homeIcon,
    ImageConstants.sectionsIcon,
    ImageConstants.menuIcon,
    // ImageConstants.dishesIcon,
    ImageConstants.offersIcon,
  ];

  int selectedIndex = 0;
  void changeIndex(int index) {
    emit(DashboardInitial());
    selectedIndex = index;
    emit(ChangeDrawerIndex());
  }

  List screens = [
    // const MainPage(),
    const SectionsPage(),
    const MenuPage(),
    // DishesPage(),
    const OrderPage(),
  ];

  bool isSelectedTile(int index, String tileName) {
    return _drawerLabels.indexWhere((element) => element == tileName) ==
        selectedIndex;
  }
}