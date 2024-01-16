import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetAccountPage extends AccountEvent {
  const GetAccountPage();

  @override
  List<Object> get props => [];
}

class ChangeAvatar extends AccountEvent {
  const ChangeAvatar({required this.avatarUrl});

  final String avatarUrl;

  @override
  List<Object> get props => [avatarUrl];
}

class Logout extends AccountEvent {
  const Logout();

  @override
  List<Object> get props => [];
}
