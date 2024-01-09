import 'package:hadramoutdash/core/common/models/order.dart';
import 'package:hadramoutdash/core/widgets/loading_circle.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_text.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/update_order_dialog/update_order_dialog.dart';
import 'package:hadramoutdash/src/app_export.dart';
import 'package:intl/intl.dart';

import '../../cubit/dashboard_cubit.dart';
import '../widgets/section_custom_button.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    DashboardBloc.get(context).getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: AppColors.whiteOp100,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 32, 32, 0),
          child: Column(
            children: [
              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is GetOrderDashboardLoading) {
                    return const Expanded(
                      child: Center(
                        child: SizedBox.square(
                          dimension: 50,
                          child: LoadingSpinningCircle(
                            color: AppColors.yellowOp100,
                          ),
                        ),
                      ),
                    );
                  } else if (state is GetOrderDashboardError) {
                    // return Text('Error: ${state.errorMessage}');
                    return const Center(
                        child: CustomText(
                      title: "لا توجد اوردرات",
                      isTitle: true,
                    ));
                  } else if (state is GetOrderDashboardSuccess) {
                    final List<OrderModel> orders =
                        context.read<DashboardBloc>().order;
                    if (orders.isEmpty) {
                      return const Center(
                          child: CustomText(
                        title: "لا توجد اوردرات",
                        isTitle: true,
                      ));
                    } else {
                      return Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(left: 32, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text("اسم العميل",
                                          style: AppTextStyles.font20BlackSemiBold.copyWith(fontWeight: FontWeight.bold))),
                                  Expanded(
                                      child: Text("اجمالي الطلب",
                                          style: AppTextStyles.font20BlackSemiBold.copyWith(fontWeight: FontWeight.bold))),
                                  Expanded(
                                      child: Text("تاريخ الطلب",
                                          style: AppTextStyles.font20BlackSemiBold.copyWith(fontWeight: FontWeight.bold))),
                                  Text("التعديل",
                                      style:  AppTextStyles.font20BlackSemiBold
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                  // Text("السعر", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  // Text("تعديل", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(
                                  height:
                                      8), // Add spacing between title and items
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: orders.length,
                                itemBuilder: (context, index) {
                                  var item = orders[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.client.name,
                                            style:
                                                AppTextStyles.font16BlackMedium,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            ' ${item.total} جنيه',
                                            style:
                                                AppTextStyles.font16BlackMedium,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${DateFormat("dd MMMM yyyy",'ar').format(item.orderDate)} - ${item.orderTime}',
                                            style:
                                                AppTextStyles.font16BlackMedium,
                                          ),
                                        ),
                                        SectionCustomActionButton(
                                          onElevatedButtonPressed: () {
                                            showUpdateOrderDialog(
                                                context, item.id, item);
                                          },
                                          onIconButtonPressed: () {
                                            context
                                                .read<DashboardBloc>()
                                                .deleteOrder(item.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else if (state is DeleteOrderDashboardSuccess ||
                      state is UpdateOrderDashboardSuccess ||
                      state is DeleteOrderDashboardError) {
                    context.read<DashboardBloc>().getOrder();
                    return const Center(child: CircularProgressIndicator());
                  } else {
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
}
