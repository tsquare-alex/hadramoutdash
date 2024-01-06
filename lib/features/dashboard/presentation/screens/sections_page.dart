import 'package:hadramoutdash/core/common/models/section.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_action_button.dart';
import 'package:hadramoutdash/src/app_export.dart';
import '../../cubit/dashboard_cubit.dart';
import '../widgets/add_section_dialog/add_section_dialog.dart';
import '../widgets/dashboard_widgets/custom_action_table_cell.dart';
import '../widgets/dashboard_widgets/custom_elevated_button.dart';
import '../widgets/dashboard_widgets/custom_table_cell.dart';
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
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
                    label: "اضافة طبق",
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
                              const CustomTableCell(title: "اسم الطبق"),
                              CustomTableCell(
                                  title: "السعر",
                                  onIconTap: () async {

                                  }),
                            ],
                          ),
                          ],
                        );
                      } else {
                        return Table(
                          border: TableBorder.symmetric(inside: BorderSide.none),
                          children: [
                            const TableRow(
                              children: [
                                CustomTableCell(title: "اسم التصنيف",isTitle: true),
                                CustomTableCell(title: "",),
                                CustomTableCell(title: "التعديل",isTitle: true),
                              ],
                            ),
                            for (var item in sections)
                              TableRow(
                                children: [
                                  CustomTableCell(
                                    title: item.title,),
                                  const CustomTableCell(
                                    title: "",
                                  ),
                                  CustomActionButton(
                                    onElevatedButtonPressed: () {
                                      updateSectionDialog(context,item.id,item);
                                    },
                                    onIconButtonPressed: () {
                                      context.read<DashboardBloc>().deleteSection(item.id);
                                    },
                                  ),

                                ],
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
                      return Text('Error deleting section: ${state.errorMessage}');
                    } else {
                      print("Unexpected State: $state");
                      return const Text('Unexpected state');
                    }
                  },
                ),



              ],
            ),
          ),
        )
    );
  }
}





