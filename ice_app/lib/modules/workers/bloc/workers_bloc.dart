import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workers_event.dart';
part 'workers_state.dart';

class WorkersBloc extends Bloc<WorkersEvent, WorkersState> {
  WorkersBloc() : super(WorkersInitial()) {
    on<WorkersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
