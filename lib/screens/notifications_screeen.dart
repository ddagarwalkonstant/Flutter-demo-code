import 'package:base_arch_proj/bloc/notification/notification_cubit.dart';
import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/models/NotificationModel.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant/AppSizer.dart';
import '../res/fonts/font_family.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _controller = ScrollController();
  final NotificationCubit _notificationCubit = NotificationCubit();
  List<NotificationModel> arrNotification = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(_scrollListener);
    init();
  }

  init() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getNotificationData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _getNotificationData() async {
    AppCommonFeatures().contextInit(context);
    _notificationCubit.arrNotification = [];
    await _notificationCubit.notificationFetchCubit('', true);
    await _notificationCubit.notificationMarkReadFetchCubit();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      AppCommonFeatures().contextInit(context);
      _notificationCubit.loadNotificationList(arrNotification, '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: getAppBar(),
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizer.twenteey),
            child: BlocProvider(
              create: (context) => _notificationCubit,
              child: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationStateLoaded) {
                    return (state.notificationList.isEmpty) ? const Center(
                        child: Text(AppStrings.noDataFound,
                            style: TextStyle(
                                fontFamily: FontFamily.archivo,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black)
                        )
                    )
                        : ListView.separated(
                        controller: _controller,
                        shrinkWrap: false,
                        primary: false,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              /// notification tap
                            },
                            child: ListTile(
                              leading: SizedBox(
                                height: 50,
                                width: 50,
                                child: CachedNetworkImage(
                                  imageUrl: (state.notificationList[index].image == '' || state.notificationList[index].image == null) ? '' : '${AppCommonFeatures.instance.imageBaseUrl}${state.notificationList[index].image}',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                  placeholder: (context, url) => const CircularProgressIndicator(color: AppColor.grey1),
                                  errorWidget: (context, url, error) => Image.asset(AppCommonFeatures.instance.imagesFactory.appLogoIcons ?? '', fit: BoxFit.cover),
                                ),
                              ),
                              title: Text(state.notificationList[index].title ?? '',
                                  style: const TextStyle(
                                      fontFamily: FontFamily.archivo,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black)),
                              subtitle:  Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(state.notificationList[index].description ?? '',
                                    style: const TextStyle(
                                        fontFamily: FontFamily.archivo,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColor.text_grey_)),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(
                                left: AppSizer.twenteey,
                                right: AppSizer.twenteey,
                                bottom: AppSizer.ten,
                                top: AppSizer.ten),
                            child: Divider(
                              thickness: 1,
                              color: AppColor.grey_4,
                            ),
                          );
                        },
                        itemCount: state.notificationList.length);
                  }else {
                    return Container();
                  }
                  },
              ),
            )),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      title: Transform(
        transform: Matrix4.translationValues(0, 0, 0),
        child: const Text(AppStrings.notification,
            style: TextStyle(
                fontFamily: FontFamily.archivo,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white)),
      ),
      backgroundColor: AppColor.theme_primary_blue,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      titleSpacing: 10.0,
      centerTitle: true,
      leading: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getDivider() {
    return const Divider(
      indent: AppSizer.twenteey,
      endIndent: AppSizer.twenteey,
      thickness: 2,
      color: AppColor.text_grey_,
    );
  }
}
