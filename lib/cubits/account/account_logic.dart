import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fua/cubits/account/account_cubits.dart';
import 'package:fua/cubits/account/account_states.dart';
import 'package:fua/screens/account.dart';

class AccountLogicScreen extends StatefulWidget {
  String? email;
  AccountLogicScreen({
    required this.email,
  });
  @override
  State<AccountLogicScreen> createState() => _AccountLogicScreen();
}

class _AccountLogicScreen extends State<AccountLogicScreen> {
  @override
  void initState() {
    BlocProvider.of<AccountCubit>(context).getCurrentUsers(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: BlocBuilder<AccountCubit, AccountState>(builder: (context, state) {
          if (state is AccountLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AccountLoadedState) {
            return AccountScreen();
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
