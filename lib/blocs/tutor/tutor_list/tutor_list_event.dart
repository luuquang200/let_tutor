import 'package:equatable/equatable.dart';

abstract class TutorListEvent extends Equatable {}

class TutorListRequested extends TutorListEvent {
  @override
  List<Object> get props => [];
}

class FilterTutorsBySpeciality extends TutorListEvent {
  final String speciality;

  FilterTutorsBySpeciality(this.speciality);

  @override
  List<Object> get props => [speciality];
}

class FilterTutorsByName extends TutorListEvent {
  final String name;

  FilterTutorsByName(this.name);

  @override
  List<Object> get props => [name];
}
