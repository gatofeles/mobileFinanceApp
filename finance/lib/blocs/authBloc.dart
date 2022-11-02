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
  List<ICard>? data;
  String dropDownSelection;
  AuthState(
      {this.token = '',
      this.userId = '',
      this.looged = false,
      this.expenses,
      this.data,
      this.dropDownSelection = 'Selecione'});
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
          var cards = await httpHelper.GetAllExpesenses(
              this.state.userId, this.state.token);
          cards.forEach((expense) {
            expensesIn.add(ECard(card: expense));
          });
          emit(AuthState(expenses: expensesIn));
      }
    });
  }

  void LogOut() {
    emit(AuthState(userId: '', token: '', data: this.state.data, expenses: [], dropDownSelection: this.state.dropDownSelection));
  }

  Future<bool> GetTokenId(String password, String email) async {
    var httpHelper = HttpHelper();

    try {
      var auth = await httpHelper.GetCreds(email, password);
      emit(AuthState(
          token: auth.token, userId: auth.userId, data: [], expenses: []));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> GetExpenses() async {
    List<ECard> expensesIn = [];
    try {
      var cards = await httpHelper.GetAllExpesenses(
          this.state.userId, this.state.token);
      cards.forEach((expense) {
        expensesIn.add(ECard(card: expense));
      });

      emit(AuthState(
          expenses: expensesIn,
          userId: this.state.userId,
          token: this.state.token,
          data: cards));
      return true;
    } catch (e) {
      return false;
    }
  }

  List<double> OrganizeByMonth() {
    List<double> total = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    List<int> years = [];

    if (this.state.dropDownSelection != 'Selecione') {
      this.state.data!.forEach((element) {
        var month = int.parse(element.date.split('/')[1]);
        var year = element.date.split('/')[2];
        var cost = double.parse(element.cost);
        if(this.state.dropDownSelection == year){
            total[month - 1] += cost;   
        }
        
      });
    }

    return total;
  }

  List<String> GetYears() {
    List<String> years = [];
    years.add("Selecione");
    this.state.data!.forEach((element) {
      var year = element.date.split('/')[2];
      if (!years.contains(year)) {
        years.add(year);
      }
    });

    return years;
  }

    void SetSelection(String year){
    emit(AuthState(dropDownSelection: year, expenses: this.state.expenses,
          userId: this.state.userId,
          token: this.state.token,
          data: this.state.data));
  }


}
