import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fua/cubits/account/account_cubits.dart';
import 'package:fua/cubits/account/account_states.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AccountCubit, AccountState>(builder: (context, state) {
        if (state is AccountLoadedState) {
          var users = state.users;

          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: ListView(
              children: List.generate(users.length, (index) {
                return Text("heelo");
              }),
            ),
          );
        } else {
          return Text("loading");
        }
      }),
    );
  }
}
