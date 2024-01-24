import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/courses/ebooks_list/ebooks_list_bloc.dart';
import 'package:let_tutor/blocs/courses/ebooks_list/ebooks_list_state.dart';
import 'package:let_tutor/data/models/course/course_category.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/categories_filter.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/course_card.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/filter_bar.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/level_filter.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/loading_indicator.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/sort_selection.dart';

class EbooksTab extends StatefulWidget {
  const EbooksTab({super.key});

  @override
  State<EbooksTab> createState() => _EbooksTabState();
}

class _EbooksTabState extends State<EbooksTab> {
  bool visibilityFilter = false;
  List<CourseCategory> categories = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          FilterBar(
            onFilterPressed: () {
              setState(() {
                visibilityFilter = !visibilityFilter;
              });
            },
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: visibilityFilter,
            child: const Column(
              children: [
                LevelFilter(),
                SizedBox(
                  height: 8,
                ),
                CategoriesFilter(),
                SizedBox(
                  height: 8,
                ),
                SortSelection(),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<EbooksListBloc, EbooksState>(
              builder: (context, state) {
                if (state is EbooksListInitial) {
                  return const LoadingIndicator();
                } else if (state is EbooksListLoading) {
                  return const LoadingIndicator();
                } else if (state is EbooksListLoadFailure) {
                  return const Center(
                    child: Text('Error loading Ebooks'),
                  );
                } else if (state is EbooksListLoadSuccess) {
                  return state.ebooks.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: state.ebooks.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: CourseCard(
                                course: state.ebooks[index],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off_outlined, size: 64),
                              Text('No Ebooks found'),
                            ],
                          ),
                        );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
