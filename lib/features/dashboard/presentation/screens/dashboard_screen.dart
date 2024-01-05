import '../../../login/cubit/login_cubit.dart';
import '../widgets/app_bar_button.dart';
import '/features/dashboard/cubit/dashboard_cubit.dart';
import '/features/dashboard/presentation/widgets/drawer_tile.dart';
import '/src/app_export.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: ResponsiveValue<double>(
              context,
              conditionalValues: [
                Condition.smallerThan(value: 180, name: DESKTOP),
                Condition.smallerThan(value: 120, name: TABLET),
              ],
              defaultValue: 268,
            ).value,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 93,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstants.dashboardLogo,
                            height: 50,
                            width: 50,
                          ),
                          ResponsiveVisibility(
                            hiddenConditions: [
                              Condition.smallerThan(
                                  value: false, breakpoint: 1160),
                            ],
                            child: const SizedBox(
                              width: 12,
                            ),
                          ),
                          ResponsiveVisibility(
                            hiddenConditions: [
                              Condition.smallerThan(
                                  value: false, breakpoint: 1160),
                            ],
                            child: const Text(
                              'حضرموت حمزة',
                              style: AppTextStyles.font20BrownBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: DashboardBloc.get(context)
                            .drawerLabels
                            .toList()
                            .length,
                        itemBuilder: (context, index) {
                          final label =
                              DashboardBloc.get(context).drawerLabels[index];
                          return DrawerTile(
                            isSelected: DashboardBloc.get(context)
                                .isSelectedTile(index, label),
                            label: label,
                            selectedIcon: DashboardBloc.get(context)
                                .drawerSelectedIcons[index],
                            unSelectedIcon: DashboardBloc.get(context)
                                .drawerUnselectedIcons[index],
                            onTap: () =>
                                DashboardBloc.get(context).changeIndex(index),
                            toolTip: label,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  toolbarHeight: 93,
                  backgroundColor: AppColors.greyOp100,
                  pinned: true,
                  surfaceTintColor: Colors.transparent,
                  leadingWidth: ResponsiveValue<double>(
                    context,
                    conditionalValues: [
                      Condition.smallerThan(value: 80, name: TABLET),
                    ],
                    defaultValue: 235,
                  ).value,
                  title: Text(
                    DashboardBloc.get(context)
                        .drawerLabels[DashboardBloc.get(context).selectedIndex],
                    style: AppTextStyles.font20BlackSemiBold.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  actions: [
                    AppBarButton(
                      onTap: () {},
                      icon: ImageConstants.searchIcon,
                      toolTip: 'البحث',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    AppBarButton(
                      onTap: () {},
                      icon: ImageConstants.notificationsIcon,
                      toolTip: 'التنبيهات',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LogoutCompleted) {
                          context.go(AppRoutes.loginScreen);
                        }
                      },
                      child: AppBarButton(
                        onTap: () {
                          LoginBloc.get(context).logout();
                        },
                        icon: ImageConstants.logoutIcon,
                        toolTip: 'تسجيل الخروج',
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.darkGrey,
                      child: Text(
                        'A',
                        style: AppTextStyles.font20WhiteSemiBold,
                      ),
                    ),
                    ResponsiveVisibility(
                      hiddenConditions: [
                        Condition.smallerThan(value: false, name: DESKTOP),
                      ],
                      child: const SizedBox(
                        width: 20,
                      ),
                    ),
                    ResponsiveVisibility(
                      hiddenConditions: [
                        Condition.smallerThan(value: false, name: DESKTOP),
                      ],
                      child: const Text(
                        'Admin',
                        style: AppTextStyles.font16BlackSemiBold,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                SliverFillRemaining(
                  child: DashboardBloc.get(context)
                      .screens[context.watch<DashboardBloc>().selectedIndex],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
