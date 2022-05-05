part of 'workers_bloc.dart';

abstract class WorkersState extends Equatable {
  const WorkersState();
  
  @override
  List<Object> get props => [];
}

class WorkersInitial extends WorkersState {}
