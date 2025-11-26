import 'dart:async';
import 'package:bloc/bloc.dart';
import '../services/job_service.dart';
import '../models/job_model.dart';
import 'jobs_event.dart';
import 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  final JobService _jobService = JobService();
  StreamSubscription? _jobsSubscription;

  JobsBloc() : super(JobsInitial()) {
    on<LoadJobsEvent>(_onLoadJobs);
    on<ApplyForJobEvent>(_onApplyForJob);
    on<_JobsUpdated>(_onJobsUpdated);
    on<_JobsError>(_onJobsError);
  }

  Future<void> _onLoadJobs(LoadJobsEvent event, Emitter<JobsState> emit) async {
    emit(JobsLoading());
    try {
      await _jobsSubscription?.cancel();
      _jobsSubscription = _jobService.getJobs().listen(
        (jobs) => add(_JobsUpdated(jobs)),
        onError: (error) => add(_JobsError(error.toString())),
      );
    } catch (e) {
      emit(JobsError(e.toString()));
    }
  }

  Future<void> _onApplyForJob(ApplyForJobEvent event, Emitter<JobsState> emit) async {
    try {
      await _jobService.applyForJob(event.jobId, event.userId);
      // Success handled by UI side-effect or optimistic update
    } catch (e) {
      emit(JobsError(e.toString()));
    }
  }
  
  Future<void> _onJobsUpdated(_JobsUpdated event, Emitter<JobsState> emit) async {
    emit(JobsLoaded(event.jobs));
  }
  
  Future<void> _onJobsError(_JobsError event, Emitter<JobsState> emit) async {
    emit(JobsError(event.message));
  }

  @override
  Future<void> close() {
    _jobsSubscription?.cancel();
    return super.close();
  }
}

class _JobsUpdated extends JobsEvent {
  final List<JobModel> jobs;
  const _JobsUpdated(this.jobs);
  
  @override
  List<Object> get props => [jobs];
}

class _JobsError extends JobsEvent {
  final String message;
  const _JobsError(this.message);
  
  @override
  List<Object> get props => [message];
}
