import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/blocs/bloc_exports.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchInitial(swithchValue: false)) {
    on<SwitchOnEvent>((event, emit) {
      emit(const SwitchState(swithchValue: true));
    });

    on<SwitchOffEvent>((event, emit) {
      emit(const SwitchState(swithchValue: false));
    });
  }

  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    return SwitchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    return state.toMap();
  }
}
