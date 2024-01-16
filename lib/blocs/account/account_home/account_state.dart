import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/user/user.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoadSuccess extends AccountState {
  final User user;
  const AccountLoadSuccess(this.user);

  @override
  List<Object> get props => [user];

  AccountLoadSuccess copyWith({User? user}) {
    return AccountLoadSuccess(user ?? this.user);
  }
}

class AccountLoadFailure extends AccountState {
  final String message;

  const AccountLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AccountLogoutSuccess extends AccountState {
  const AccountLogoutSuccess();

  @override
  List<Object> get props => [];
}
