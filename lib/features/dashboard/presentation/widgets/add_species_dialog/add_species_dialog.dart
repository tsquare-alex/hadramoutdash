import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadramoutdash/features/dashboard/cubit/dashboard_cubit.dart';

import '../../../../../core/common/models/section.dart';
import '../../../../../core/themes/colors.dart';
import '../custom_dialog_button.dart';
import '../custom_text.dart';
import '../custom_text_form_field.dart';

class AddSpeciesDialog extends StatefulWidget {
  final DashboardBloc dashboardCubit;

  AddSpeciesDialog({Key? key, required this.dashboardCubit}) : super(key: key);

  @override
  _AddDishDialogState createState() => _AddDishDialogState();
}

class _AddDishDialogState extends State<AddSpeciesDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: AppColors.whiteOp100,
      content: SingleChildScrollView(
        child: Container(
          width: 600.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: widget.dashboardCubit.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomText(
                    title: "أضافة طبق", isTitle: true),
                const SizedBox(height: 20,),
                CustomTextFormField(
                  controller: widget.dashboardCubit.titleController,
                  hintText: "ادخل الاسم",
                  validationText: "yes",
                  validator: (value) {
                    if (value == null ||  value.trim().isEmpty) {
                      return "من فضلك ادخل الاسم";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20,),
                CustomTextFormField(
                  controller: widget.dashboardCubit.descController,
                  hintText: "ادخل التفاصيل",
                  validationText: "yes",
                  validator: (value) {
                    if (value == null ) {
                      return "من فضلك ادخل التفاصيل";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20,),
                CustomTextFormField(
                  hintText: "ادخل السعر",
                  controller: widget.dashboardCubit.priceController,
                  validationText: "من فضلك ادخل السعر",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "ادخل السعر";
                    }
                    try {
                      double.parse(value);
                      return null;
                    } catch (e) {
                      return "من فضلك ادخل ارقام فقط";
                    }
                  },
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () async {
                    await widget.dashboardCubit.pickImage();
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.yellowOp75
            ),
            child: const CustomText(
                title: "اختار صورة",
                isTitle: true
            ),
          )),
                widget.dashboardCubit.pickedImage != null
                    ? CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.memory(
                      Uint8List.fromList(
                        widget.dashboardCubit.pickedImage!.bytes!,
                      ),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ) : Container(),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.greyOp100,
                  ),
                  child: DropdownButton<String>(
                    hint: const CustomText(title: "أختر القسم"),
                    dropdownColor: AppColors.greyOp100,
                    underline: const SizedBox.shrink(),
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 15),
                    focusColor: AppColors.blackOp10,
                    value: widget.dashboardCubit.selectedSection.isNotEmpty
                        ? widget.dashboardCubit.selectedSection
                        : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.dashboardCubit.updateSelectedSection(
                          widget.dashboardCubit.sections.firstWhere(
                                (section) => section.title == newValue,
                            orElse: () =>
                                const SectionModel(id: "",
                                    title: ""),
                          ),
                        );
                      });
                    },
                    items: widget.dashboardCubit.sections.map((
                        SectionModel section) {
                      return DropdownMenuItem<String>(
                        value: section.title,
                        child: Text(section.title),
                      );
                    }).toList(),
                  ),
                ),


                const SizedBox(height: 20),
                CustomDialogButton(
                  isLoading: isLoading,
                  label: "أضافة",
                  onPressed: () async {
                    if (widget.dashboardCubit.formKey.currentState!
                        .validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      if (widget.dashboardCubit.selectedSection.isEmpty) {
                        showAlertDialog(context,);
                        setState(() {
                          isLoading = false;
                        });
                        return;
                      } else {
                        await widget.dashboardCubit.addSpecies();
                      }
                      widget.dashboardCubit.pickedImage = null;
                      setState(() {
                        isLoading = false;
                      });
                      widget.dashboardCubit.titleController.clear();
                      Navigator.of(context).pop();
                    } else {
                      print("Validation failed");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: AppColors.whiteOp100,
          title: const CustomText(title:"تحذير",isTitle: true),
          content: const CustomText(title: "من فضلك اختر القسم"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const CustomText(title: "حسنا"),
            ),
          ],
        );
      },
    );
  }
}

void showAddSpeciesDialog(BuildContext context) async {
  final dashboardCubit = context.read<DashboardBloc>();

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AddSpeciesDialog(dashboardCubit: dashboardCubit);
        },
      );
    },
  ).then((value) {
    dashboardCubit.pickedImage = null;
    dashboardCubit.titleController.clear();
    dashboardCubit.descController.clear();
    dashboardCubit.priceController.clear();
    // dashboardCubit.selectedSection.isEmpty;
    dashboardCubit.selectedSection = '';
  });
}