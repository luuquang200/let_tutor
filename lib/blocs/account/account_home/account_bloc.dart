import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/account/account_home/account_event.dart';
import 'package:let_tutor/blocs/account/account_home/account_state.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/repositories/user_repository.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository userRepository;

  AccountBloc({required this.userRepository}) : super(AccountInitial()) {
    on<GetAccountPage>(_onGetAccountPage);
    on<ChangeAvatar>(_onChangeAvatar);
  }

  Future<void> _onGetAccountPage(
      GetAccountPage event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      User user = await userRepository.getUserInformation();
      emit(AccountLoadSuccess(user));
    } catch (e) {
      emit(AccountLoadFailure(e.toString()));
    }
  }

  Future<void> _onChangeAvatar(
      ChangeAvatar event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      User user = await userRepository.changeAvatar(avatarUrl: event.avatarUrl);
      emit(AccountLoadSuccess(user));
    } catch (e) {
      emit(AccountLoadFailure(e.toString()));
    }
  }
}
