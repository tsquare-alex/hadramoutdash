import 'package:hadramoutdash/core/common/models/order.dart';
import 'package:hadramoutdash/features/dashboard/presentation/widgets/update_order_dialog/update_order_dialog.dart';
import 'package:hadramoutdash/src/app_export.dart';
import '../../cubit/dashboard_cubit.dart';
import '../widgets/dashboard_widgets/custom_action_table_cell.dart';
import '../widgets/dashboard_widgets/custom_table_cell.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
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
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetOrderDashboardError) {
                return Text('Error: ${state.errorMessage}');
              } else if (state is GetOrderDashboardSuccess) {
                final List<OrderModel> orders =
                    context.read<DashboardBloc>().order;
                if (orders.isEmpty) {
                  return Text("There is No Order");
                } else {
                  return Table(
                    border: TableBorder.symmetric(inside: BorderSide.none),
                    children: [
                      for (var item in orders)
                        TableRow(
                          children: [
                            CustomTableCell(
                              title: "${item.cartModel.map((cart) => cart.title).join(", ")}",
                              // image: item.image ?? '',
                            ),
                            CustomTableCell(
                                title: "${item.price.toString()}EGP"),
                            // CustomTableCell(
                            //     title: "%${item.offerValue.toString()}"),
                            // CustomTableCell(title: item.createdAt),
                            // const CustomTableCell(
                            //   title: "",
                            // ),
                            CustomActionTableCell(
                              onElevatedButtonPressed: () {
                                showUpdateOrderDialog(context, item.id, item);
                              },
                              onIconButtonPressed: () {
                                context
                                    .read<DashboardBloc>()
                                    .deleteOrder(item.id);
                              },
                            ),
                          ],
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
