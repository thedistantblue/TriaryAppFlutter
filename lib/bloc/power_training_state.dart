part of 'power_training_bloc.dart';

enum PowerTrainingStatus { initial, success, failure }

final class PowerTrainingState extends Equatable {
  final PowerTrainingStatus status;
  final List<PowerTraining> powerTrainings;

  const PowerTrainingState({
    this.status = PowerTrainingStatus.initial,
    this.powerTrainings = const <PowerTraining>[],
  });

  PowerTrainingState copyWith({
    PowerTrainingStatus? status,
    List<PowerTraining>? powerTrainings,
  }) {
    return PowerTrainingState(
      status: status ?? this.status,
      powerTrainings: powerTrainings ?? this.powerTrainings,
    );
  }

  @override
  List<Object> get props => [status, powerTrainings];
}
