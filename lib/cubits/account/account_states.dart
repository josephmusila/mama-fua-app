import 'package:equatable/equatable.dart';
import 'package:fua/services/currentUser.dart';



abstract class AccountState extends Equatable {}

class AccountInitialState extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountLoadingState extends AccountState {
  @override
  List<Object> get props => [];
}



class AccountLoadedState extends AccountState {
  final List<CurrentUserService> users;
  AccountLoadedState(
     this.users,
  );
  @override
  List<Object> get props => [users];
}

class AccountErrorState extends AccountState {
  @override
  List<Object> get props => [];
}
