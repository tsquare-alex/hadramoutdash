
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hadramoutdash/core/common/models/order.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_dialog_button.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_text.dart';


import '../../../../../core/themes/colors.dart';
import '../../../cubit/dashboard_cubit.dart';





class UpdateOrderDialog extends StatefulWidget {
  final String orderId;
  final OrderModel currentOrder;
  final DashboardBloc dashboardBloc;

  UpdateOrderDialog({
    Key? key,
    required this.orderId,
    required this.currentOrder,
    required this.dashboardBloc,
  }) : super(key: key);

  @override
  _UpdateOrderDialogState createState() => _UpdateOrderDialogState();
}

class _UpdateOrderDialogState extends State<UpdateOrderDialog> {
  bool _delivered = false;
  bool _cancelled = false;
  bool _confirmed = false;

  @override
  void initState() {
    super.initState();
    _delivered = widget.currentOrder.delivered;
    _cancelled = widget.currentOrder.cancelled;
    _confirmed = widget.currentOrder.confirmed;
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomText(
                    title: "تعديل الاوردر",
                    isTitle: true,
                  ),

                  CustomText(
                    title: "سعر الاوردر: ${widget.currentOrder.price}",
                    isTitle: false,
                  ),
                  CustomText(
                    title: "اسم الاوردر: ${widget.currentOrder.cartModel.map((e) => e.title).join(", ")}",
                    isTitle: false,
                  ),
                  // CustomText(
                  //   title: "اسم الاوردر: ${widget.currentOrder.cartModel.map((e) => e.description).join(", ")}",
                  //   isTitle: false,
                  // ),
                  Gap(20),
                  Row(
                    children: [
                      Checkbox(
                        value: _delivered,
                        onChanged: (value) {
                          setState(() {
                            _delivered = value ?? false;
                          });
                        },
                      ),
                      const CustomText(
                        title: "تم التوصيل",
                        isTitle: false,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _cancelled,
                        onChanged: (value) {
                          setState(() {
                            _cancelled = value ?? false;
                          });
                        },
                      ),
                      const CustomText(
                        title: "تم الالغاء",
                        isTitle: false,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _confirmed,
                        onChanged: (value) {
                          setState(() {
                            _confirmed = value ?? false;
                          });
                        },
                      ),
                      const CustomText(
                        title: "تم التأكيد",
                        isTitle: false,
                      ),
                    ],
                  ),
                  Gap(20),
                  CustomDialogButton(
                    isLoading: context.read<DashboardBloc>().isLoading,
                    label: "تعديل",
                    onPressed: () async {
                      OrderModel updatedOrder = OrderModel(
                        id: widget.currentOrder.id,
                        cancelled: _cancelled,
                        client: widget.currentOrder.client,
                        confirmed: _confirmed,
                        delivered: _delivered,
                        price: widget.currentOrder.price,
                        createdAt: widget.currentOrder.createdAt,
                        orderDate: widget.currentOrder.orderDate,
                        orderTime: widget.currentOrder.orderTime,
                        orderMethod: widget.currentOrder.orderMethod,
                        cartModel: widget.currentOrder.cartModel,
                        deliveryModel: widget.currentOrder.deliveryModel,
                      );

                      widget.dashboardBloc.updateOrder(
                        widget.orderId,
                        updatedOrder,
                      );

                      Navigator.pop(context);
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

void showUpdateOrderDialog(
    BuildContext context,
    String orderId,
    OrderModel currentOrder,
    ) async {
  final dashboardBloc = context.read<DashboardBloc>();

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return UpdateOrderDialog(
            orderId: orderId,
            currentOrder: currentOrder,
            dashboardBloc: dashboardBloc,
          );
        },
      );
    },
  );
}






