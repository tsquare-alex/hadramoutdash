import 'package:hadramoutdash/src/app_export.dart';

import '../../../../core/common/models/species.dart';
import '../../cubit/dashboard_cubit.dart';
import '../widgets/add_species_dialog/add_species_dialog.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/dashboard_widgets/custom_elevated_button.dart';
import '../widgets/update_species_dialog/update_dialog.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    DashboardBloc.get(context).getSections();

    DashboardBloc.get(context).getSpecies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: AppColors.greyOp50,
          child: Column(

            children: [
              CustomElevatedButton(
                icon: Icons.add,
                label: "اضافة طبق",
                onPressed: () async {
                  showAddSpeciesDialog(context);
                },
              ),
              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is GetSpeciesDashboardLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetSpeciesDashboardError) {
                    return Text('Error: ${state.errorMessage}');
                  } else if (state is GetSpeciesDashboardSuccess) {
                    final List<SpeciesModel> species =
                        context
                            .read<DashboardBloc>()
                            .species;

                    if (species.isEmpty) {
                      return const Center(child: CustomText(title: "لا يوجد اصناف فى المنيو",isTitle: true,));
                    } else {
                      // Group species by section
                      Map<String, List<SpeciesModel>> groupedSpecies =
                      groupSpeciesBySection(species);

                      return ListView(
                        shrinkWrap: true,
                        children: groupedSpecies.entries
                            .map(
                              (entry) =>
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    entry.key,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 380,
                                    // color: Colors.grey,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: entry.value.length,
                                      itemBuilder: (context, index) {
                                        final SpeciesModel item = entry.value[index];
                                        return  Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children:[
                                              Column(
                                                children:[
                                                  Container(
                                                    height:50.0,
                                                    color: Colors.white,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: 315,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.whiteOp100,
                                                        borderRadius: BorderRadius.circular(22),
                                                      ),

                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          const Gap(60),
                                                          CustomText(title: "${item.title}"),
                                                          const Gap(10),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                            child: Text("${item.description}",maxLines: 3,style: AppTextStyles.font16BlackOp50Medium),
                                                          ),
                                                          const Gap(10),
                                                          CustomText(title: "${item.price}"),
                                                          const Gap(10),
                                                          CustomText(title: "${item.createdAt}"),
                                                          const Spacer(),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              CustomActionButton(
                                                                onElevatedButtonPressed: () {
                                                                  showUpdateDishDialog(context, item.id, item);
                                                                },
                                                                onIconButtonPressed: () {
                                                                  context
                                                                      .read<DashboardBloc>()
                                                                      .deleteSpecies(item.id);
                                                                },

                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // Profile image
                                              Positioned(
                                                top: 10.0,
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      item.image!,
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        print('Error loading image: $error');
                                                        return Image.asset("assets/images/dashboard_logo.png");
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  const Divider(),
                                ],
                              ),
                        )
                            .toList(),

                      );




                    }
                  } else if (state is AddSpeciesDashboardSuccess ||
                      state is DeleteSpeciesDashboardSuccess ||
                      state is UpdateSpeciesDashboardSuccess ||
                      state is ImagePickLoading ||
                      state is ImagePickedSuccessfully ||
                      state is ImagePickError ||
                      state is AddSpeciesImageDashboardSuccess ||
                      state is DeleteSpeciesDashboardError)
                  {
                    context.read<DashboardBloc>().getSpecies();
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    print("Unexpected State: $state");
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),


            ],
          ),
        ),
      ),
    );
  }

  Map<String, List<SpeciesModel>> groupSpeciesBySection(
      List<SpeciesModel> species) {
    Map<String, List<SpeciesModel>> groupedSpecies = {};

    for (var specie in species) {
      String sectionTitle = specie.section.title;

      if (!groupedSpecies.containsKey(sectionTitle)) {
        groupedSpecies[sectionTitle] = [];
      }

      groupedSpecies[sectionTitle]!.add(specie);
    }

    return groupedSpecies;
  }
}

