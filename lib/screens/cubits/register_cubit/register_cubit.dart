import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser({required String email , required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(RegisterFailur(errorMessage: 'this email is already exist'));
      } else if (e.code == 'weak-password') {
        emit(RegisterFailur(errorMessage: 'weak password'));
      }
    }
    catch (e){
      emit(RegisterFailur(errorMessage: 'something went wrong'));
    }
  }
}
