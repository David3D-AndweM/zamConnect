import 'package:equatable/equatable.dart';

abstract class JobsEvent extends Equatable {
  const JobsEvent();

  @override
  List<Object> get props => [];
}

class LoadJobsEvent extends JobsEvent {}

class ApplyForJobEvent extends JobsEvent {
  final String jobId;
  final String userId;

  const ApplyForJobEvent({required this.jobId, required this.userId});

  @override
  List<Object> get props => [jobId, userId];
}
