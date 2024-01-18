import 'package:equatable/equatable.dart';

abstract class TutorListEvent extends Equatable {}

class TutorListRequested extends TutorListEvent {
  final int page;

  TutorListRequested({required this.page});

  @override
  List<Object> get props => [page];
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

// Nationality filter
class FilterTutorsByNationality extends TutorListEvent {
  final Map<String, bool> nationality;
  final String selectedNationality;

  FilterTutorsByNationality(
      {required this.nationality, required this.selectedNationality});

  @override
  List<Object> get props => [nationality, selectedNationality];
}

// reset filters
class ResetFilters extends TutorListEvent {
  @override
  List<Object> get props => [];
}
