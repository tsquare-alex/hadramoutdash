import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/common/models/section.dart';
import '../../../../../core/themes/colors.dart';
import '../../../cubit/dashboard_cubit.dart';
import '../custom_dialog_button.dart';
import '../custom_text.dart';
import '../custom_text_form_field.dart';

class UpdateSectionDialog extends StatefulWidget {
  final String sectionId;
  final SectionModel currentSection;
  final DashboardBloc dashboardBloc;

  UpdateSectionDialog({
    Key? key,
    required this.sectionId,
    required this.currentSection,
    required this.dashboardBloc,
  }) : super(key: key);

  @override
  _UpdateSectionDialogState createState() => _UpdateSectionDialogState();
}

class _UpdateSectionDialogState extends State<UpdateSectionDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController sectionController;


  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    sectionController = TextEditingController(text: widget.currentSection.title);
  }

  @override
  void dispose() {
    sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    if (screenHeight >= 600) {
      return AlertDialog(
        surfaceTintColor: AppColors.whiteOp100,
        content: Container(
          width: 600.0,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomText(title: "تعديل الطبق", isTitle: true),
                const Gap(24),
                CustomTextFormField(
                  controller:sectionController,
                  hintText: "ادخل اسم القسم",
                  validationText: "yes",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "من فضلك ادخل الاسم";
                    }else{
                      return null;
                    }
                  },


                ),
                const Gap(34),
                CustomDialogButton(
                  isLoading: isLoading,
                  label: "تعديل",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      if (widget.sectionId != null) {
                        SectionModel updateSection = SectionModel(id: widget.sectionId, title: sectionController.text);

                        await widget.dashboardBloc.updateSection(
                            widget.sectionId, updateSection);
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.of(context).pop();
                      } else {
                        print("Error: sectionId is null");
                        setState(() {
                          isLoading = false;
                        });
                      }
                    } else {
                      print("Validation failed");
                    }
                  },
                ),






              ],
            ),
          ),
        ),
      );
    } else {
      return const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "The Dialog Has Been Hidden. Please Keep the Screen Big",
              style: TextStyle(
                color: Colors.black, // Change to an appropriate color
              ),
            ),
          ),
        ),
      );
    }
  }
}

void updateSectionDialog(
    BuildContext context,
    String sectionId,
    SectionModel currentSection,
    ) async {
  final dashboardBloc = context.read<DashboardBloc>();

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return UpdateSectionDialog(
            sectionId: sectionId,
            currentSection: currentSection,
            dashboardBloc: dashboardBloc,
          );
        },
      );
    },
  );
}

