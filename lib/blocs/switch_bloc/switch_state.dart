part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  final bool swithchValue;
  const SwitchState({required this.swithchValue});

  @override
  List<Object> get props => [swithchValue];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'swithchValue': swithchValue,
    };
  }

  factory SwitchState.fromMap(Map<String, dynamic> map) {
    return SwitchState(
      swithchValue: map['swithchValue'],
    );
  }
}

class SwitchInitial extends SwitchState {
  const SwitchInitial({required bool swithchValue})
      : super(swithchValue: swithchValue);
}
