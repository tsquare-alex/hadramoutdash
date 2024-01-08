
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
import '../order_custom_text.dart';





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
                  OrderCustomRow(title: "اسم العميل", info: "${widget.currentOrder.client.name}"),
                  OrderCustomRow(title: "رقم العميل", info: "${widget.currentOrder.client.number}"),
                  // Row(
                  //   children: [
                  //     if (widget.currentOrder.client.address.isNotEmpty)
                  //       Expanded(
                  //         child: OrderCustomRow(title: "عنوان الاوردر", info: "${widget.currentOrder.client.address}"),
                  //       ),
                  //
                  //     if (widget.currentOrder.client.building.isNotEmpty)
                  //       OrderCustomRow(title: "رقم البناية", info: "${widget.currentOrder.client.building}"),
                  //
                  //
                  //     if (widget.currentOrder.client.floor!.isNotEmpty)
                  //       OrderCustomRow(title: "رقم الدور", info: "${widget.currentOrder.client.floor}"),
                  //
                  //     if (widget.currentOrder.client.apartment!.isNotEmpty)
                  //       OrderCustomRow(title: "رقم الشقة", info: "${widget.currentOrder.client.floor}"),
                  //   ],
                  // ),
                  if (widget.currentOrder.client.address.isNotEmpty)
                    OrderCustomRow(title: "عنوان الاوردر", info: "${widget.currentOrder.client.address}"),
                  if (widget.currentOrder.client.building.isNotEmpty)
                    OrderCustomRow(title: "رقم البناية", info: "${widget.currentOrder.client.building}"),
                  if (widget.currentOrder.client.floor!.isNotEmpty)
                    OrderCustomRow(title: "رقم الدور", info: "${widget.currentOrder.client.floor}"),
                  if (widget.currentOrder.client.apartment!.isNotEmpty)
                    OrderCustomRow(title: "رقم الشقة", info: "${widget.currentOrder.client.apartment}"),


                  Gap(10),

                  DataTable(
                    columns: [
                      DataColumn(label: OrderCustomText(title: "الاسم")),
                      DataColumn(label: OrderCustomText(title: "الكمية")),
                      DataColumn(label: OrderCustomText(title: "السعر")),
                      DataColumn(label: OrderCustomText(title: "اجمالى السعر")),
                    ],
                    rows: widget.currentOrder.cartModel.map((item) {
                      return DataRow(
                        cells: [
                          DataCell(Text(item.title)),
                          DataCell(Text("${item.quantity}")),
                          DataCell(Text("${item.price}")),
                          DataCell(Text("${item.totalPrice}")),
                        ],
                      );
                    }).toList(),
                  ),




                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: widget.currentOrder.cartModel.length,
                  //   itemBuilder: (context, index) {
                  //     var item = widget.currentOrder.cartModel[index];
                  //     return Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text("اسم الاوردر: ${item.title}"),
                  //         ),
                  //         SizedBox(width: 16),
                  //         Expanded(
                  //           child: Text("الكمية: ${item.quantity}"),
                  //         ),
                  //         SizedBox(width: 16),
                  //         Expanded(
                  //           child: Text("السعر: ${item.price}"),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // ),


                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.stretch,
                  //   // mainAxisAlignment: MainAxisAlignment.start,
                  //   children: widget.currentOrder.cartModel.map((item) {
                  //     return Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       // mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         OrderCustomRow(title: "اسم الاوردر", info: "${item.title}"),
                  //
                  //         OrderCustomRow(title: "الكمية", info: "${item.quantity}"),
                  //         OrderCustomRow(title: "السعر", info: "${item.price}"),
                  //
                  //         // You can add additional information here, like total price, description, etc.
                  //         const SizedBox(height: 16), // Add some spacing between items
                  //       ],
                  //     );
                  //   }).toList(),
                  // ),
                  if (widget.currentOrder.orderMethod == "التوصيل الي البيت")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text("طريقة الاوردر: ${widget.currentOrder.orderMethod}"),
                        OrderCustomRow(title: "طريقة الاستلام", info: "${widget.currentOrder.orderMethod}"),
                        OrderCustomRow(title: "مكان الاستلام", info: "${widget.currentOrder.deliveryModel?.title}"),
                        OrderCustomRow(title: "وقت الحجز", info: "${widget.currentOrder.orderTime}"),
                        OrderCustomRow(
                          title: "تاريخ الحجز",
                          info: DateFormat("dd MMMM yyyy", "ar").format(widget.currentOrder.orderDate),
                        ),
                        OrderCustomRow(title: "تكلفة التوصيل", info: "${widget.currentOrder.deliveryModel?.fees}"),

                      ],
                    ),
                  if (widget.currentOrder.orderMethod == "حجز بالمطعم")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderCustomRow(title: "طريقة الاستلام", info: "${widget.currentOrder.orderMethod}"),
                        OrderCustomRow(title: "وقت الحجز", info: "${widget.currentOrder.orderTime}"),
                        OrderCustomRow(
                          title: "تاريخ الحجز",
                          info: DateFormat("dd MMMM yyyy", "ar").format(widget.currentOrder.orderDate),
                        ),
                      ],
                    ),

                  // Text("${widget.currentOrder.orderMethod}"),
                  // OrderCustomRow(title: "مكان التوصيل", info: "${widget.currentOrder.deliveryModel?.title}"),
                  // OrderCustomRow(title: "تكلفة التوصيل", info: "${widget.currentOrder.deliveryModel?.fees}"),

                  OrderCustomRow(title: "اجمالى السعر", info: "${widget.currentOrder.price}"),

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

class OrderCustomRow extends StatelessWidget {
  const OrderCustomRow({
    super.key,
     required this.title, required this.info,
  });

  final String  title;
  final String  info;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         OrderCustomText(
          title:"$title:   ",

        ),
        Flexible(
          child: CustomText(
            title: info,
            isTitle: false,
          ),
        ),
      ],
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






