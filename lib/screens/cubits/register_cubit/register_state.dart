part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterFailur extends RegisterState {
  final String  errorMessage;
  RegisterFailur({required this.errorMessage});
}
