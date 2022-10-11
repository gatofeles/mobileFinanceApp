import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/httpHelper.dart' show HttpHelper;
import '../utils/httpHelper.dart' show ICard;
import '../components/card.dart';

enum AuthEvent { get, delete, getExpenses, createExpense }

class AuthState {
  String token;
  String userId;
  bool looged;
  List<ECard>? expenses;
  AuthState(
      {this.token = '', this.userId = '', this.looged = false, this.expenses});
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  var httpHelper = HttpHelper();

  AuthBloc(String email, String password)
      : super(AuthState(token: '', userId: '', expenses: [])) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case AuthEvent.get:
          var auth = await httpHelper.GetCreds(email, password);
          emit(AuthState(token: auth.token, userId: auth.userId));
          break;
        case AuthEvent.delete:
          emit(AuthState(token: '', userId: ''));
          break;
        case AuthEvent.getExpenses:
          List<ECard> expensesIn = [];
          var cards = await httpHelper.GetAllExpesenses(this.state.userId, this.state.token);
          cards.forEach((expense) {
              expensesIn.add(ECard(card: expense));
          });
          emit(AuthState(expenses: expensesIn));
      }
    });
  }

  Future<bool> GetTokenId(String password, String email) async {
    var httpHelper = HttpHelper();

    try {
      var auth = await httpHelper.GetCreds(email, password);
      emit(AuthState(token: auth.token, userId: auth.userId));
      return true;
    }

    catch(e){
      return false;
    }
      // if (await GetExpenses()) {
      //   return true;
      // } else {
      //   return false;
      // }
    // } catch (e) {
    //   return false;
    // }
  }

  Future<bool> GetExpenses() async {
    List<ECard> expensesIn = [];
    try {
        var cards = await httpHelper.GetAllExpesenses(this.state.userId, this.state.token);
          cards.forEach((expense) {
              expensesIn.add(ECard(card: expense));
          });
          emit(AuthState(expenses: expensesIn, userId: this.state.userId, token: this.state.token));
          return true;
    } catch (e) {
      return false;
    }
          
  }

}
