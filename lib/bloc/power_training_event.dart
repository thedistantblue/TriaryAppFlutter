part of 'power_training_bloc.dart';

sealed class PowerTrainingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PowerTrainingFetched extends PowerTrainingEvent {}
final class PowerTrainingCreated extends PowerTrainingEvent {}
final class PowerTrainingDeleted extends PowerTrainingEvent {}
final class PowerTrainingChanged extends PowerTrainingEvent {}
