import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:finance/blocs/RestApiBloc/authStates.dart';
import 'package:finance/utils/expensesRepo.dart';
import '../../utils/authRepo.dart';
import 'authEvents.dart';

class NewAuthBloc extends Bloc<AuthEvents, AuthStates> {
  //final httpHelper = HttpHelper();
  FirebaseAuthenticationService auth = FirebaseAuthenticationService();

  NewAuthBloc() : super(AuthInitialState()) {
    // _inputClientController.stream.listen(_mapEventToState);
    on<AuthenticationEvent>((event, emit) async {
      try {
        var result = await auth.signInWithEmailAndPassword(event.email, event.password);

        if (result != null) {
          FirestoreDatabase.helper.uid = result.uid;
          emit(AuthSuccessState(result.uid));
        } else {
          emit(AuthenticationErrorState());
        }
      } catch (e) {
        emit(AuthenticationErrorState());
      }
    });

    on<RegisterEvent>((event, emit) => emit(RegisterState()));

    on<CreateUserEvent>(((event, emit) async {

        try {
         var user = await auth.createUserWithEmailAndPassword(event.email, event.password);
          emit(AuthInitialState());
        } catch (e) {
          emit(AuthenticationErrorState());
        }
    }));

    on<LogoutEvent>(((event, emit) async {
      auth.signOut();
      FirestoreDatabase.helper.uid = '';
      emit(AuthInitialState());
    }));

    on<Refresh>(((event, emit) async {
      emit(AuthInitialState());
    }));

    // on<AuthenticationEvent>((event, emit) async {
    //   try {
    //     var result = await httpHelper.GetCreds(event.email, event.password);
    //     if (result.token != "" && result.userId != "") {
    //       emit(AuthSuccessState(result.token, result.userId));
    //     } else {
    //       emit(AuthenticationErrorState());
    //     }
    //   } catch (e) {
    //     emit(AuthenticationErrorState());
    //   }
    // });
  }
}
