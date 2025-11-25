import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  final int currentTab;

  const HomeInitial({this.currentTab = 0});

  @override
  List<Object> get props => [currentTab];
}

class HomeLoaded extends HomeState {
  final int currentTab;

  const HomeLoaded({required this.currentTab});

  @override
  List<Object> get props => [currentTab];
}