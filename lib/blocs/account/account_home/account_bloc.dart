import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/account/account_home/account_event.dart';
import 'package:let_tutor/blocs/account/account_home/account_state.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/repositories/user_repository.dart';
import 'package:let_tutor/data/sharedpref/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository userRepository;
  late SharedPreferenceHelper sharedPrefsHelper;

  AccountBloc({required this.userRepository}) : super(AccountInitial()) {
    _getPres();
    on<GetAccountPage>(_onGetAccountPage);
    on<ChangeAvatar>(_onChangeAvatar);
    on<Logout>(_onLogout);
  }

  void _getPres() async {
    sharedPrefsHelper =
        SharedPreferenceHelper(await SharedPreferences.getInstance());
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

  Future<void> _onLogout(Logout event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      await sharedPrefsHelper.removeAcessToke();
      emit(const AccountLogoutSuccess());
    } catch (e) {
      emit(AccountLoadFailure(e.toString()));
    }
  }
}
