
abstract class LogInStates{}
class LogInInitialState extends LogInStates{}
class LogInSuccessState extends LogInStates{
  final String? uid;

  LogInSuccessState(this.uid);
}
class LogInLoadingState extends LogInStates{}
class LogInErrorState extends LogInStates{
  final String? error;
  LogInErrorState(this.error);
}
class ChangePasswordVisibilityState extends LogInStates{}
