part of 'network_loading_cubit.dart';

@immutable
sealed class NetworkLoadingState {}

final class NetworkLoadingInitial extends NetworkLoadingState {}

final class NetworkSuccess extends NetworkLoadingState {
  final List<String> data;
  NetworkSuccess(this.data);
}

final class NetworkFailure extends NetworkLoadingState {
  final String error;
  NetworkFailure(this.error);
}


