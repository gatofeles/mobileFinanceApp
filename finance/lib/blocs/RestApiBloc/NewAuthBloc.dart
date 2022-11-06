import 'package:bloc/bloc.dart';
import 'package:finance/blocs/RestApiBloc/authStates.dart';
import 'package:finance/components/card.dart';
import 'package:finance/utils/httpHelper.dart';
import 'authEvents.dart';

class NewAuthBloc extends Bloc<AuthEvents, AuthStates> {
  final httpHelper = HttpHelper();

  NewAuthBloc() : super(AuthInitialState()) {
    // _inputClientController.stream.listen(_mapEventToState);

    on<InitiateEvent>(
      (event, emit) => emit(AuthInitialState()),
    );

    on<AddExpenseEvent>(
      (event, emit) async {
        try{
            if(!await httpHelper.CreateExpense(event.expense, state.token)){
            emit(CreateStateFailed(state.token, state.userId, state.loged, state.expenses!, state.data!, state.dropDownSelection));
          }
          else{
            List<ECard> expensesIn = [];
            final data = await httpHelper.GetAllExpesenses(state.userId, state.token);
            data.forEach((expense) {
            expensesIn.add(ECard(card: expense));
            });
            emit(ExpensesLoadedState(state.token, state.userId, state.loged, expensesIn, data, state.dropDownSelection));
          }
        }
        catch(e){
          emit(CreateStateFailed(state.token, state.userId, state.loged, state.expenses!, state.data!, state.dropDownSelection));
        }
          
      } 
    );

    on<RemoveExpenseEvent>(
      (event, emit) async {
          if(!await httpHelper.DeleteExpense(event.expense, state.token)){
            emit(DeleteStateFailed(state.token, state.userId, state.loged, state.expenses!, state.data!, state.dropDownSelection));
          }
          else{
            List<ECard> expensesIn = [];
            final data = await httpHelper.GetAllExpesenses(state.userId, state.token);
            data.forEach((expense) {
            expensesIn.add(ECard(card: expense));
            });
            emit(ExpensesLoadedState(state.token, state.userId, state.loged, expensesIn, data, state.dropDownSelection));
          }
      } 
    );

    on<LoadExpenses>(
      (event, emit) async {
          
            List<ECard> expensesIn = [];
            if(state.loged){
                final data = await httpHelper.GetAllExpesenses(state.userId, state.token);
                data.forEach((expense) {
            expensesIn.add(ECard(card: expense));
            });
            emit(ExpensesLoadedState(state.token, state.userId, state.loged, expensesIn, data, state.dropDownSelection));
            }   
      } 
    );

    on<AuthenticationEvent>(
      (event, emit) async {

        if(event.userId != "" && event.token != ""){
          emit(AuthSuccessState(event.token, event.userId));
        }    
        else{
          emit(AuthenticationErrorState());
        } 
      }
    );

    on<SelectYearEvent>(
      (event, emit) async {
        emit(SelectYearState(state.token, state.userId, state.loged, state.expenses!, state.data!, event.year));
      }
    );
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
}
