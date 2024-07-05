part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}


class NotificationStateLoaded extends NotificationState {
  final List<NotificationModel> notificationList;
  final bool showNotification;
  NotificationStateLoaded(this.notificationList, this.showNotification);
}