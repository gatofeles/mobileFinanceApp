import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/httpHelper.dart' as utils;
import '../utils/httpHelper.dart' show ICard;

enum AuthEvent { get, delete, getExpenses }

class AuthState {
  String token;
  String userId;
  bool looged;
  List<ICard>? expenses;
  AuthState(
      {this.token = '', this.userId = '', this.looged = false, this.expenses});
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(String email, String password)
      : super(AuthState(token: '', userId: '')) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case AuthEvent.get:
          var httpHelper = utils.HttpHelper();
          var auth = await httpHelper.GetCreds(email, password);
          emit(AuthState(token: auth.token, userId: auth.userId));
          break;
        case AuthEvent.delete:
          emit(AuthState(token: '', userId: ''));
          break;
      }
    });
  }

  Future<bool> GetTokenId(String password, String email) async {
    var httpHelper = utils.HttpHelper();

    try {
      var auth = await httpHelper.GetCreds(email, password);
      emit(AuthState(token: auth.token, userId: auth.userId));
      if (await GetExpenses()) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
      return false;
    }
  }

  Future<bool> GetExpenses() async {
    var httpHelper = utils.HttpHelper();

    try {
      var expenseList = await httpHelper.GetAllExpesenses(
          this.state.userId, this.state.token);
      emit(AuthState(expenses: expenseList));
      return true;
    } catch (e) {
      throw Exception(e.toString());
      return false;
    }
  }
}
