import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hadramoutdash/core/common/models/order.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_dialog_button.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_text.dart';
import 'package:intl/intl.dart';

import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/styles.dart';
import '../../../cubit/dashboard_cubit.dart';
import '../order_custom_row.dart';
import '../order_custom_text.dart';

class UpdateOrderDialog extends StatefulWidget {
  final String orderId;
  final OrderModel currentOrder;
  final DashboardBloc dashboardBloc;

  const UpdateOrderDialog({
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
      contentPadding: const EdgeInsets.all(24),
      content: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: SingleChildScrollView(
          child: Container(
            // width: 600.0,
            child: Form(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomText(
                    title: "تعديل الاوردر",
                    isTitle: true,
                  ),
                  Gap(18),
                  OrderCustomRow(
                      title: "اسم العميل",
                      info: widget.currentOrder.client.name),
                  OrderCustomRow(
                      title: "رقم تليفون العميل",
                      info: "${widget.currentOrder.client.number}"),
                  if (widget.currentOrder.client.address.isNotEmpty)
                    OrderCustomRow(
                        title: "عنوان العميل",
                        info: widget.currentOrder.client.address),
                  if (widget.currentOrder.client.building.isNotEmpty)
                    OrderCustomRow(
                        title: "رقم المبنى",
                        info: widget.currentOrder.client.building),
                  if (widget.currentOrder.client.floor!.isNotEmpty)
                    OrderCustomRow(
                        title: "رقم الدور",
                        info: "${widget.currentOrder.client.floor}"),
                  if (widget.currentOrder.client.apartment!.isNotEmpty)
                    OrderCustomRow(
                        title: "رقم الشقة",
                        info: "${widget.currentOrder.client.apartment}"),

                  const Gap(10),

                  DataTable(
                    columns: const [
                      DataColumn(label: OrderCustomText(title: "الاسم")),
                      DataColumn(label: OrderCustomText(title: "الكمية")),
                      DataColumn(label: OrderCustomText(title: "السعر")),
                      DataColumn(label: OrderCustomText(title: "اجمالى السعر")),
                    ],
                    rows: widget.currentOrder.cartModel.map((item) {
                      return DataRow(
                        cells: [
                          DataCell(Text(item.title)),
                          DataCell(Center(child: Text("${item.quantity}"))),
                          DataCell(Center(child: Text("${item.price}"))),
                          DataCell(Center(child: Text("${item.totalPrice}"))),
                        ],
                      );
                    }).toList(),
                  ),
                  const Divider(color: AppColors.blackOp100),

                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("الأجمالى:",
                            style: AppTextStyles.font20YellowBold,
                            textAlign: TextAlign.end),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("${widget.currentOrder.subTotal}",
                            style: AppTextStyles.font20BlackSemiBold,
                            textAlign: TextAlign.end),
                      ],
                    ),
                  ),

                  const Divider(color: AppColors.blackOp100),
                  if (widget.currentOrder.orderMethod == "التوصيل الي البيت")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text("طريقة الاوردر: ${widget.currentOrder.orderMethod}"),
                        OrderCustomRow(
                            title: "طريقة الاستلام",
                            info: widget.currentOrder.orderMethod),
                        OrderCustomRow(
                            title: "منطقة التوصيل",
                            info:
                                "${widget.currentOrder.deliveryModel?.title}"),
                        OrderCustomRow(
                          title: "تاريخ التسليم",
                          info: DateFormat("dd MMMM yyyy", "ar")
                              .format(widget.currentOrder.orderDate),
                        ),
                        OrderCustomRow(
                            title: "وقت التسليم",
                            info: widget.currentOrder.orderTime),
                        OrderCustomRow(
                            title: "تكلفة التوصيل",
                            info: "${widget.currentOrder.deliveryModel?.fees}"),
                      ],
                    ),
                  if (widget.currentOrder.orderMethod == "حجز بالمطعم")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderCustomRow(
                            title: "طريقة الاستلام",
                            info: widget.currentOrder.orderMethod),
                        OrderCustomRow(
                          title: "تاريخ الحجز",
                          info: DateFormat("dd MMMM yyyy", "ar")
                              .format(widget.currentOrder.orderDate),
                        ),
                        OrderCustomRow(
                            title: "وقت الحجز",
                            info: widget.currentOrder.orderTime),
                      ],
                    ),

                  // Text("${widget.currentOrder.orderMethod}"),
                  // OrderCustomRow(title: "مكان التوصيل", info: "${widget.currentOrder.deliveryModel?.title}"),
                  // OrderCustomRow(title: "تكلفة التوصيل", info: "${widget.currentOrder.deliveryModel?.fees}"),

                  // OrderCustomRow(title: "اجمالى السعر", info: "${widget.currentOrder.price}"),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("اجمالى السعر: ",
                            style: AppTextStyles.font20YellowBold),
                        Text("${widget.currentOrder.total} جنيه",
                            style: AppTextStyles.font20BlackSemiBold),
                      ],
                    ),
                  ),

                  const Gap(20),
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
                  const Gap(20),
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
                        total: widget.currentOrder.total,
                        createdAt: widget.currentOrder.createdAt,
                        orderDate: widget.currentOrder.orderDate,
                        orderTime: widget.currentOrder.orderTime,
                        orderMethod: widget.currentOrder.orderMethod,
                        cartModel: widget.currentOrder.cartModel,
                        deliveryModel: widget.currentOrder.deliveryModel,
                        subTotal: widget.currentOrder.subTotal,
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
