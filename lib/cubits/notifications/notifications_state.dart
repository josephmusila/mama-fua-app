import 'package:equatable/equatable.dart';

import 'package:fua/services/notificationsService.dart';

abstract class NotificationState extends Equatable {}

class NotificationInitialState extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoadingState extends NotificationState {
  @override
  List<Object> get props => [];
}

class NoNotificationState extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoadedState extends NotificationState {
  final List<MyNotifications> notifications;
  NotificationLoadedState({
    required this.notifications,
  });
  @override
  List<Object> get props => [notifications];
}

class NotificationErrorState extends NotificationState {
  @override
  List<Object> get props => [];
}
