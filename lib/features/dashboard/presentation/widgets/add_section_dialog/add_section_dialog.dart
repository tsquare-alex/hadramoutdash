import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hadramoutdash/core/injection/injector.dart';

import '../../../../../core/themes/colors.dart';
import '../../../cubit/dashboard_cubit.dart';
import '../custom_dialog_button.dart';
import '../custom_text.dart';
import '../custom_text_form_field.dart';

class AddSectionDialog extends StatefulWidget {
  final DashboardBloc dashboardBloc;

  AddSectionDialog({Key? key, required this.dashboardBloc}) : super(key: key);

  @override
  _AddDishDialogState createState() => _AddDishDialogState();
}

class _AddDishDialogState extends State<AddSectionDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardBloc>(),
      child: AlertDialog(
        surfaceTintColor: AppColors.whiteOp100,
        content: SingleChildScrollView(
          child: Container(
            width: 600.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: widget.dashboardBloc.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomText(title: "أضافة تصنيف",  isTitle: true),
                  Gap(24),
                  CustomTextFormField(
                    controller: widget.dashboardBloc.sectionTitleController,
                    hintText: "ادخل اسم تصنيف",
                    validationText: "yes",
                    validator: (value) {
                      if (value == null ||  value.trim().isEmpty) {
                        return "من فضلك ادخل الاسم";
                      }else{
                        return null;
                      }
                    },


                  ),
                  Gap(34),
                  CustomDialogButton(
                    isLoading: isLoading,
                    label: "أضافة",
                    onPressed: () async {
                      if (widget.dashboardBloc.formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await widget.dashboardBloc.addSection();
                        setState(() {
                          isLoading = false;
                        });
                        widget.dashboardBloc.sectionTitleController.clear();
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
      ),
    );
  }
}


void addSectionDialog(BuildContext context) async {
  final dashboardBloc = context.read<DashboardBloc>();

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AddSectionDialog(dashboardBloc: dashboardBloc);
        },
      );
    },
  ).then((value) {
    dashboardBloc.sectionTitleController.clear();
  });
}
