import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fua/cubits/notifications/notifications_cubit.dart';
import 'package:fua/cubits/notifications/notifications_state.dart';
import 'package:fua/screens/notificationScreen.dart';

import '../../widgets/notificationsWidget.dart';

class NotificationLogicScreen extends StatefulWidget {
  String id;
   NotificationLogicScreen({
    
    required this.id,
  });

  @override
  State<NotificationLogicScreen> createState() => _NotificationLogicScreen();
}

class _NotificationLogicScreen extends State<NotificationLogicScreen> {
  @override
  void initState() {
    BlocProvider.of<NotificationsCubit>(context).getNotificatios(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<NotificationsCubit, NotificationState>(
          builder: (context, state) {
        if (state is NotificationLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is NotificationLoadedState) {
          return NotifivationsList();
        } else {
          return Container();
        }
      }),
    );
  }
}
