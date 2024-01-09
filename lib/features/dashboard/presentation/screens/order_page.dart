import 'package:hadramoutdash/core/common/models/order.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/custom_text.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/update_order_dialog/update_order_dialog.dart';
import 'package:hadramoutdash/src/app_export.dart';
import '../../cubit/dashboard_cubit.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/dashboard_widgets/custom_table_cell.dart';
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: AppColors.greyOp50,
          child:    BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is GetOrderDashboardLoading) {
                return   const Center(child: CircularProgressIndicator());
              } else if (state is GetOrderDashboardError) {
                // return Text('Error: ${state.errorMessage}');
                return const Center(child: CustomText(title: "لا توجد اوردرات",isTitle: true,));
              } else if (state is GetOrderDashboardSuccess) {
                final List<OrderModel> orders =
                    context.read<DashboardBloc>().order;
                if (orders.isEmpty) {
                  return const Center(child: CustomText(title: "لا توجد اوردرات",isTitle: true,));
                } else {

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("اسم العميل", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                          Expanded(child: Text("السعر", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                          Text("التعديل", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          // Text("السعر", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          // Text("تعديل", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8), // Add spacing between title and items
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          var item = orders[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text( item.client.name, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                                ),
                                Expanded(
                                  child: Text( item.total.toString(), style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                                ),
                            SectionCustomActionButton(
                              onElevatedButtonPressed: () {
                                showUpdateOrderDialog(context, item.id, item);
                              },
                              onIconButtonPressed: () {
                                context.read<DashboardBloc>().deleteOrder(item.id);
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
              } else if (state is DeleteOrderDashboardSuccess ||
                  state is UpdateOrderDashboardSuccess ||
                  state is DeleteOrderDashboardError) {
                context.read<DashboardBloc>().getOrder();
                return const Center(child: CircularProgressIndicator());
              } else {
                print("Unexpected State: $state");
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
