import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fua/cubits/account/account_states.dart';
import 'package:fua/services/currentUser.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit({
    required this.currentUserService,
    required this.email,
  }) : super(AccountInitialState()) {
    emit(AccountLoadingState());
  }

  final CurrentUserService currentUserService;
  String? email;
  late final users;

  void getCurrentUsers(String? email) async {
    try {
      emit(AccountLoadingState());
      users = await currentUserService.getUser(email);
      print(users);
     
      emit(AccountLoadedState(users));
    } catch (e) {}
  }
}
