import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fua/cubits/notifications/notifications_cubit.dart';

import '../cubits/notifications/notifications_state.dart';

class NotifivationsList extends StatelessWidget {
  const NotifivationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Container(
        padding: EdgeInsets.all(10),
        // color: Colors.grey,
        child: BlocBuilder<NotificationsCubit, NotificationState>(
            builder: (context, state) {
          if (state is NotificationLoadedState) {
            var notifications = state.notifications;

            return ListView(
              children: List.generate(notifications.length, (index) {
                return Card(
                  shadowColor: Colors.blue,
                  elevation: 5,
                  child: ListTile(
                    leading: Text((index + 1).toString()),
                    title: Text(notifications[index].notification),
                    subtitle: Text(notifications[index].dateCreated.toString()),
                  ),
                );
              }),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
