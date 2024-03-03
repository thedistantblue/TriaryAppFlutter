part of 'power_training_bloc.dart';

sealed class PowerTrainingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PowerTrainingFetched extends PowerTrainingEvent {}

final class PowerTrainingCreated extends PowerTrainingEvent {
  final PowerTraining training;
  PowerTrainingCreated(this.training);

  @override
  List<Object> get props => [training];
}

final class PowerTrainingDeleted extends PowerTrainingEvent {
  final PowerTraining training;
  PowerTrainingDeleted(this.training);

  @override
  List<Object> get props => [training];
}

final class PowerTrainingChanged extends PowerTrainingEvent {}
