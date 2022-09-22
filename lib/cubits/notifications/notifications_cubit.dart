import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fua/cubits/notifications/notifications_state.dart';
import 'package:fua/cubits/slider/slider_state.dart';
import 'package:fua/services/notificationsService.dart';

class NotificationsCubit extends Cubit<NotificationState> {
  NotificationsCubit({
    required this.notificationService,
    required this.id,
  }) : super(NotificationInitialState()) {
    emit(NotificationLoadingState());
  }

  final NotificationService notificationService;
  String id;
  late final notifications;

  void getNotificatios(String id) async {
    try {
      emit(NotificationLoadingState());
      notifications = await notificationService.getotifications(id);
      print(notifications);
      if (notifications == null) {
        emit(NoNotificationState());
      }
      emit(NotificationLoadedState(notifications: notifications));
    } catch (e) {}
  }
}
