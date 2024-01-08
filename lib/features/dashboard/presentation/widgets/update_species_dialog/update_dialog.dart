import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadramoutdash/core/common/models/dishes.dart';
import 'package:hadramoutdash/core/common/models/section.dart';
import 'package:hadramoutdash/core/common/models/species.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_dialog_button.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_text.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';

import '../../../../../core/themes/colors.dart';
import '../../../cubit/dashboard_cubit.dart';

class UpdateDishDialog extends StatefulWidget {
  final String dishId;
  final SpeciesModel currentSpecies;
  final DashboardBloc dashboardBloc;

  UpdateDishDialog({
    Key? key,
    required this.dishId,
    required this.currentSpecies,
    required this.dashboardBloc,
  }) : super(key: key);

  @override
  _UpdateDishDialogState createState() => _UpdateDishDialogState();
}

class _UpdateDishDialogState extends State<UpdateDishDialog> {
  late SectionModel selectedSection;

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().updateDishTitleController =
        TextEditingController(text: widget.currentSpecies.title);
    context.read<DashboardBloc>().updateDishDescriptionController =
        TextEditingController(text: widget.currentSpecies.description);
    context.read<DashboardBloc>().updateDishPriceController =
        TextEditingController(text: widget.currentSpecies.price.toString());
    context.read<DashboardBloc>().updateDishSectionController =
        TextEditingController(text: widget.currentSpecies.section.title);
    context.read<DashboardBloc>().updateDishOfferValueController =
        TextEditingController(text: widget.currentSpecies.offerValue.toString());
    widget.dashboardBloc.pickedImage = null;
    selectedSection = widget.dashboardBloc.sections.firstWhere(
      (section) => section.title == widget.currentSpecies.section.title,
      orElse: () => widget.dashboardBloc.sections.isNotEmpty
          ? widget.dashboardBloc.sections.first
          : SectionModel(id: "", title: ""),
    ) ;
    print("Initial selectedSection: ${context.read<DashboardBloc>().selectedSection}");
  }


  @override
  Widget build(BuildContext context) {
      return AlertDialog(
        surfaceTintColor: AppColors.whiteOp100,
        content: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false,
          ),
          child: SingleChildScrollView(
            child: Container(
              width: 600.0,
              child: Form(
                key: context.read<DashboardBloc>().updateDishFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomText(
                        title: "تعديل طبق",  isTitle: true),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: context.read<DashboardBloc>().updateDishTitleController,
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
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: context.read<DashboardBloc>().updateDishDescriptionController,
                      hintText: "ادخل التفاصيل",
                      validationText: "yes",
                      validator: (value) {
                        if (value == null ||  value.isEmpty) {
                          return "من فضلك ادخل التفاصيل";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () async {
                          await widget.dashboardBloc.pickImage();
                          setState(() {});
                        },
                        child: const CustomText(
                            title: "اختار صورة",
                            isTitle: true
                        )),
                    widget.dashboardBloc.pickedImage != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.memory(
                                Uint8List.fromList(
                                  widget.dashboardBloc.pickedImage!.bytes!,
                                ),
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: "ادخل السعر",
                      controller: context.read<DashboardBloc>().updateDishPriceController,
                      validationText: "من فضلك ادخل السعر",
                      validator: (value) {
                        if (value == null ||  value.trim().isEmpty) {
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



                    DropdownButtonFormField<SectionModel>(
                      value: selectedSection,
                      onChanged: (SectionModel? newValue) {
                        setState(() {
                          selectedSection =
                              newValue ?? SectionModel(id: "", title: "");
                        });
                      },
                      items: [
                        ...widget.dashboardBloc.sections
                            .map((SectionModel section) {
                          return DropdownMenuItem<SectionModel>(
                            value: section,
                            child: Text(section.title),
                          );
                        }).toList(),
                      ],
                    ),

                    const SizedBox(height: 20),
                    CustomDialogButton(
                      isLoading: context.read<DashboardBloc>().isLoading,
                      label: "تعديل",
                      onPressed: () async {
                        if (context.read<DashboardBloc>().updateDishFormKey.currentState!.validate()) {
                          setState(() {
                            context.read<DashboardBloc>().isLoading = true;
                          });

                          if (widget.dishId != null) {
                            String? imageUrl;
                            if (widget.dashboardBloc.pickedImage != null) {
                              imageUrl = await widget.dashboardBloc.uploadSpeciesImage();
                              imageUrl ??= "";
                            } else {
                              imageUrl = widget.currentSpecies.image;
                            }

                            SpeciesModel updatedSpecies = SpeciesModel(
                              id: widget.dishId,
                              title: context.read<DashboardBloc>().updateDishTitleController.text,
                              description: context.read<DashboardBloc>().updateDishDescriptionController.text,
                              image: imageUrl,
                              price: double.parse(context.read<DashboardBloc>().updateDishPriceController.text),
                              createdAt: DateFormat('dMMMMy hh:mm a').format(DateTime.now()),
                              section:selectedSection,
                              offer: true,
                              offerValue: int.parse(context.read<DashboardBloc>().updateDishOfferValueController.text),
                            );


                            await widget.dashboardBloc.updateSpecies(
                                widget.dishId, updatedSpecies);
                            setState(() {
                              context.read<DashboardBloc>().isLoading = false;
                            });
                            Navigator.of(context).pop();
                          } else {
                            print("Error: speciesId is null");
                            setState(() {
                              context.read<DashboardBloc>().isLoading = false;
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
          ),
        ),
      );
    }


}

void showUpdateDishDialog(
  BuildContext context,
  String dishId,
  SpeciesModel currentSpecies,
) async {
  final dashboardBloc = context.read<DashboardBloc>();

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return UpdateDishDialog(
            dishId: dishId,
            currentSpecies: currentSpecies,
            dashboardBloc: dashboardBloc,
          );
        },
      );
    },
  ).then((value) {
    dashboardBloc.pickedImage = null;
    dashboardBloc.titleController.clear();
    dashboardBloc.descController.clear();
    dashboardBloc.priceController.clear();
    // dashboardCubit.selectedSection.isEmpty;
    dashboardBloc.selectedSection = '';
  });
}
