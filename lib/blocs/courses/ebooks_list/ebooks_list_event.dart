import 'package:equatable/equatable.dart';

abstract class EbooksListEvent extends Equatable {
  const EbooksListEvent();

  @override
  List<Object> get props => [];
}

class GetEbooksList extends EbooksListEvent {
  const GetEbooksList();

  @override
  List<Object> get props => [];
}

class GetDetailCourse extends EbooksListEvent {
  final String id;

  const GetDetailCourse(this.id);

  @override
  List<Object> get props => [id];
}

class GetEbooksListByCategory extends EbooksListEvent {
  final String category;

  const GetEbooksListByCategory(this.category);

  @override
  List<Object> get props => [category];
}

class GetEbooksListByLevel extends EbooksListEvent {
  final String level;

  const GetEbooksListByLevel(this.level);

  @override
  List<Object> get props => [level];
}

class GetEbooksListBySortLevel extends EbooksListEvent {
  final String sortLevel;

  const GetEbooksListBySortLevel(this.sortLevel);

  @override
  List<Object> get props => [sortLevel];
}

class GetEbooksListBySearch extends EbooksListEvent {
  final String search;

  const GetEbooksListBySearch(this.search);

  @override
  List<Object> get props => [search];
}
