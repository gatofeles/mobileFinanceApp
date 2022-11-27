import 'dart:math';

import 'package:finance/blocs/model/Expenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/card.dart';
import '../../utils/expensesRepo.dart';


class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  ExpenseCollection expenseCollection = ExpenseCollection();

  MonitorBloc() : super(LoadedMonitorState(expenseCollection: ExpenseCollection(), year: 'Selecione')) {
    FirestoreDatabase.helper.stream.listen((event) {
      expenseCollection = event;
      add(UpdateList());
    });

    on<AskNewList>((event, emit) async {
      expenseCollection = await FirestoreDatabase.helper.getExpenseList();
      emit(LoadedMonitorState(expenseCollection: expenseCollection, year: state.year));
    });

    on<UpdateList>((event, emit) {
      emit(LoadedMonitorState(expenseCollection: expenseCollection, year: state.year));
    });

    on<SelectYearEvent>(((event, emit) {
      emit(SelectYearState(expenseCollection: state.expenseCollection,year: event.year));
    }));

    on<ClearYearSelection>((event, emit) {
      emit(LoadedMonitorState(expenseCollection: state.expenseCollection, year: 'Selecione'));
    });

    on<ClearForLogout>((event, emit) {
      emit(LoadedMonitorState(expenseCollection: ExpenseCollection(), year: 'Selecione'));
    });

    add(AskNewList());
  }

  List<double> OrganizeByMonth() {
    List<double> total = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    List<int> years = [];

    if (this.state.year != 'Selecione') {
      this.state.expenseCollection!.cardList.forEach((element) {
        var month = int.parse(element.card!.date.split('/')[1]);
        var year = element.card!.date.split('/')[2];
        var cost = double.parse(element.card!.cost);
        if(this.state.year == year){
            total[month - 1] += cost;   
        }
        
      });
    }

    return total;
  }

  List<String> GetYears() {
    List<String> years = [];
    years.add("Selecione");
    this.state.expenseCollection!.cardList.forEach((element) {
      var year = element.card!.date.split('/')[2];
      if (!years.contains(year)) {
        years.add(year);
      }
    });

    return years;
  }
}

/*
Eventos
*/
abstract class MonitorEvent {}

class AskNewList extends MonitorEvent {}

class UpdateList extends MonitorEvent {}

class ClearYearSelection extends MonitorEvent {}

class ClearForLogout extends MonitorEvent {}

class SelectYearEvent extends MonitorEvent{
  String year;

  SelectYearEvent({
    required this.year,
  });
}

/*
Estados
*/

abstract class MonitorState{
  ExpenseCollection expenseCollection;
  String year;
  MonitorState({required this.expenseCollection, required this.year});
}
class LoadedMonitorState extends MonitorState {

  LoadedMonitorState({required ExpenseCollection expenseCollection, required String year}):super(expenseCollection: expenseCollection, year: year);
}

class SelectYearState extends MonitorState{
  SelectYearState({required ExpenseCollection expenseCollection, required String year}):super(expenseCollection: expenseCollection, year: year);
}
