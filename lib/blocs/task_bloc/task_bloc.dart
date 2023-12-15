import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/task.dart';
import '../bloc_exports.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<EditTask>(_onEditTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTasks);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> state) {
    final state = this.state;

    // ignore: invalid_use_of_visible_for_testing_member
    emit(TaskState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        completedTasks: state.completedTasks,
        removedTasks: state.removedTasks));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;

    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true))
          }
        : {
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false)),
            completedTasks = List.from(completedTasks)..remove(task),
          };

    emit(TaskState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> removedTasks = List.from(state.removedTasks)..remove(task);

    emit(TaskState(
      pendingTasks: state.pendingTasks,
      removedTasks: removedTasks,
      completedTasks: state.completedTasks,
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(
            event.task.copyWith(isDeleted: true),
          )));
  }

  void _onEditTask(EditTask event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(TaskState(
      pendingTasks: List.from(state.pendingTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask),
      completedTasks: state.completedTasks..remove(event.oldTask),
      removedTasks: state.removedTasks,
    ));
  }

  void _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TaskState> emit) {
    final state = this.state;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;

    if (event.task.isDone == false) {
      var taskIndex = pendingTasks.indexOf(event.task);
      if (event.task.isFavorite == false) {
        pendingTasks = List.from(state.pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
      } else {
        pendingTasks = List.from(state.pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
      }
    } else {
      var taskIndex = completedTasks.indexOf(event.task);
      if (event.task.isFavorite == false) {
        completedTasks = List.from(state.completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
      } else {
        completedTasks = List.from(state.completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
      }
    }
    emit(TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        removedTasks: state.removedTasks));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      removedTasks: List.from(state.removedTasks)..remove(event.task),
      pendingTasks: List.from(state.pendingTasks)
        ..insert(
            0,
            event.task
                .copyWith(isDeleted: false, isFavorite: false, isDone: false)),
      completedTasks: state.completedTasks,
    ));
  }

  void _onDeleteAllTasks(DeleteAllTasks event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
        removedTasks: List.from(state.removedTasks)..clear(),
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
