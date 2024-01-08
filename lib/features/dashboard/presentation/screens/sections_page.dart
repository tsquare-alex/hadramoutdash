import 'package:hadramoutdash/core/common/models/section.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_action_button.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_text.dart';
import 'package:hadramoutdash/src/app_export.dart';
import '../../cubit/dashboard_cubit.dart';
import '../widgets/add_section_dialog/add_section_dialog.dart';
import '../widgets/dashboard_widgets/custom_action_table_cell.dart';
import '../widgets/dashboard_widgets/custom_elevated_button.dart';
import '../widgets/dashboard_widgets/custom_table_cell.dart';
import '../widgets/section_custom_button.dart';
import '../widgets/update_section_dialog/update_section_dialog.dart';


class SectionsPage extends StatefulWidget {
  const SectionsPage({super.key});

  @override
  State<SectionsPage> createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {

  @override
  void initState() {
    super.initState();
    DashboardBloc.get(context).getSections();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(32),
              color: AppColors.whiteOp100,
              width: double.infinity,
              child: Column(
                children: [
                  ResponsiveVisibility(
                    hiddenConditions: [
                      Condition.smallerThan(value: false, name: DESKTOP),
                    ],
                    child: CustomElevatedButton(
                      icon: Icons.add,
                      label: "اضافة تصنيف",
                      onPressed: () async{
                        addSectionDialog(context);
                      },
                    ),
                  ),
                  BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      print("Current State: $state");
                      if (state is GetSectionDashboardLoading) {
                        // Loading state
                        return const CircularProgressIndicator();
                      } else if (state is GetSectionDashboardError) {
                        // Error state
                        return Text('Error: ${state.errorMessage}');
                      } else if (state is GetSectionDashboardSuccess) {
                        final List<SectionModel> sections =
                            context.read<DashboardBloc>().sections;
                        if (sections.isEmpty) {
                          return Table(
                            children: [
                              TableRow(
                              children: [
                                const CustomTableCell(title: "اسم التصنيف"),
                                CustomTableCell(
                                    title: "التعديل",
                                    onIconTap: () async {

                                    }),
                              ],
                            ),
                            ],
                          );
                        } else {



                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("اسم التصنيف", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text("تعديل", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(height: 8), // Add spacing between title and items
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: sections.length,
                                itemBuilder: (context, index) {
                                  var item = sections[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(item.title, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                                        ),
                                        SectionCustomActionButton(
                                          onElevatedButtonPressed: () {
                                            updateSectionDialog(context, item.id, item);
                                          },
                                          onIconButtonPressed: () {
                                            context.read<DashboardBloc>().deleteSection(item.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          );







                        }
                      }
                      else if (state is AddSectionDashboardSuccess) {
                        context.read<DashboardBloc>().getSections();
                        return const CircularProgressIndicator();
                      }
                      else if (state is AddSectionDashboardLoading) {
                        context.read<DashboardBloc>().getSections();
                        return const CircularProgressIndicator();
                      }
                      else if (state is DeleteSectionDashboardSuccess) {
                          context.read<DashboardBloc>().getSections();
                        return const CircularProgressIndicator();
                      } else if (state is UpdateSectionDashboardSuccess) {
                          context.read<DashboardBloc>().getSections();
                        return const CircularProgressIndicator();
                      }
                      else if (state is DeleteSectionDashboardError) {
                        context.read<DashboardBloc>().getSections();
                        return Text('حاول مرة اخرى: ${state.errorMessage}');
                      } else {
                        print("Unexpected State: $state");
                        return const Text('حاول مرة اخرى');
                      }
                    },
                  ),



                ],
              ),
            ),
          ),
        )
    );
  }
}





