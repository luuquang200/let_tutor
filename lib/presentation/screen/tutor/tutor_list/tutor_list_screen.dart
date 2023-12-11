import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_event.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';
import 'package:let_tutor/presentation/screen/tutor/tutor_list/tutor_list_page.dart';

class TutorListScreen extends StatefulWidget {
  const TutorListScreen({Key? key}) : super(key: key);
  @override
  State<TutorListScreen> createState() => _TutorListScreenState();
}

class _TutorListScreenState extends State<TutorListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TutorListBloc(tutorRepository: TutorRepository())
        ..add(TutorListRequested()),
      child: const TutorListPage(),
    );
  }
}
