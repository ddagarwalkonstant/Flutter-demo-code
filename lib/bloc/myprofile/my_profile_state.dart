part of 'my_profile_cubit.dart';

@immutable
abstract class MyProfileState {}

class MyProfileInitial extends MyProfileState {}

class ImageUpdateState extends MyProfileState {}

class LogoutStateLoaded extends MyProfileState {
  final LogoutStateLoaded normalModel;

  LogoutStateLoaded(this.normalModel);
}

class MyPrfoileDetailsState extends MyProfileState {
  final MyProfileModel myProfileModel;

  MyPrfoileDetailsState(this.myProfileModel);
}


class MyPrfoileUpdateState extends MyProfileState {
  final MyProfileModel myProfileModel;

  MyPrfoileUpdateState(this.myProfileModel);
}


class NotificationAllowState extends MyProfileState {
  final LoginModel model;

  NotificationAllowState(this.model);
}