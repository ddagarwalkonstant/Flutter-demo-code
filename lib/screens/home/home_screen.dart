import 'package:base_arch_proj/bloc/member/member_cubit.dart';
import 'package:base_arch_proj/bloc/notification/notification_cubit.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/RouterNavigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/AppColor.dart';
import '../../constant/AppSizer.dart';
import '../../constant/AppStrings.dart';
import 'assigned_member.dart';
import 'my_member.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  MymemberScreen myMemberScreen = MymemberScreen();
  AssignMemberScreen assignMemberScreen = AssignMemberScreen();
  final NotificationCubit _notificationCubit = NotificationCubit();
  final MemberCubit _memberCubit = MemberCubit();
  String? fullName;
  String? profileImage;
  bool? showNotificationBadge;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((_) => init());
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  // Initialize method to fetch user details and initial notifications
  init() async {
    await AppCommonFeatures.instance.sharedPreferenceHelper.getLoginUserDetails();
    fullName = AppCommonFeatures.instance.sharedPreferenceHelper.loginModel?.data?.user?.fullName ?? '';
    profileImage = AppCommonFeatures.instance.sharedPreferenceHelper.loginModel?.data?.user?.avatar ?? '';
    _memberCubit.emit(MemberInitial());
    await _notificationCubit.notificationFetchCubit('', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        // Flexible space with header image
        flexibleSpace: Image.asset(
          AppCommonFeatures.instance.imagesFactory.home_header,
          fit: BoxFit.fill,
        ),
        // Bottom app bar with user info and notification icon
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSizer.ninetyEight),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: AppSizer.twenteey, right: AppSizer.twenteey),
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => _memberCubit),
                    BlocProvider(create: (context) => _notificationCubit),
                  ],
                  child: MultiBlocListener(
                    listeners: [
                      // Listener for notification state changes
                      BlocListener<NotificationCubit, NotificationState>(
                        listener: (context, state) {
                          if (state is NotificationStateLoaded) {
                            showNotificationBadge = state.showNotification;
                          }
                        },
                      ),
                    ],
                    child: BlocBuilder<MemberCubit, MemberState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            // User profile avatar
                            CircleAvatar(
                              backgroundColor: AppColor.textFieldBackground,
                              radius: 25,
                              child: Transform.scale(
                                scale: 1,
                                child: CachedNetworkImage(
                                  imageUrl: profileImage == null
                                      ? ''
                                      : '${AppCommonFeatures.instance.imageBaseUrl}$profileImage',
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const CircularProgressIndicator(color: AppColor.grey1),
                                  errorWidget: (context, url, error) => Image.asset(
                                    AppCommonFeatures.instance.imagesFactory.user ?? '',
                                    fit: BoxFit.cover,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSizer.twenteey),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Hello, Welcome 🎉",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: AppSizer.five),
                                  Text(
                                    fullName ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: AppSizer.sixteen,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Notification icon
                            BlocBuilder<NotificationCubit, NotificationState>(
                              builder: (context, state) {
                                return Align(
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(RouterNavigator.notificationScreen)
                                          .then((value) async => await _notificationCubit.notificationFetchCubit('', false));
                                    },
                                    child: Image.asset(
                                      (showNotificationBadge ?? false)
                                          ? AppCommonFeatures.instance.imagesFactory.notification_unread
                                          : AppCommonFeatures.instance.imagesFactory.notification_read,
                                      width: AppSizer.fifty,
                                      height: AppSizer.fifty,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizer.fifteen),
              // Tab bar for switching between member screens
              TabBar(
                onTap: (index) {
                  // Handle tab switch actions if needed
                },
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: false,
                controller: tabController!,
                unselectedLabelColor: Colors.white54,
                labelColor: Colors.white,
                indicatorColor: AppColor.yellow,
                tabs: const [
                  Tab(
                    child: Text(
                      AppStrings.my_members,
                      style: TextStyle(fontSize: AppSizer.fourteen),
                    ),
                  ),
                  Tab(
                    child: Text(
                      AppStrings.assigned_members,
                      style: TextStyle(fontSize: AppSizer.fourteen),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Body with tab views
      body: TabBarView(
        controller: tabController,
        children: [
          myMemberScreen,
          assignMemberScreen,
        ],
      ),
    );
  }
}
