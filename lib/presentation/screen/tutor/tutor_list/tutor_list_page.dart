import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_state.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/presentation/screen/tutor/tutor_list/widgets/upcoming_lesson.dart';

import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/styles/theme.dart';
import 'package:let_tutor/presentation/widgets/tutor_information_card.dart';
import 'package:number_paginator/number_paginator.dart';

import 'package:let_tutor/data/models/tutors/tutor.dart';

class TutorListPage extends StatefulWidget {
  const TutorListPage({Key? key}) : super(key: key);

  @override
  TutorListPageState createState() => TutorListPageState();
}

class TutorListPageState extends State<TutorListPage> {
  final dateController = TextEditingController();
  int selectedSpecialityIndex = 0;
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  bool isShowFilter = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UpcomingLesson(),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderRow(context),
                    const SizedBox(
                      height: 8,
                    ),
                    Visibility(
                      visible: isShowFilter,
                      child: _inputFilter(context),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<TutorListBloc, TutorListState>(
                      builder: (context, state) {
                        if (state is TutorListLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is TutorListSuccess) {
                          if (state.tutors.isEmpty) {
                            return _noTutorsFoundMessage();
                          }
                          return _listTutorInformationCard(
                              state.tutors,
                              state.learnTopics,
                              state.testPreparations,
                              state.totalPage,
                              state.page);
                        } else if (state is TutorListFailure) {
                          return Text('error_message'.tr(args: [state.error]),
                              style: CustomTextStyle.bodyRegular
                                  .copyWith(color: Colors.redAccent));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center _noTutorsFoundMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_outlined, size: 64),
          Text('no_tutor_found'.tr(),
              style: CustomTextStyle.bodyRegular
                  .copyWith(color: Colors.grey[400])),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Row _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('recommended_tutors:'.tr(), style: CustomTextStyle.headlineLarge),
        IconButton(
            onPressed: () {
              setState(() {
                isShowFilter = !isShowFilter;
              });
            },
            icon: const Icon(
              Icons.filter_list_outlined,
              size: 28,
            )),
      ],
    );
  }

  Widget _selectNationality() {
    final Map<String, Map<String, bool>> listNationalities = {
      'select_nationality'.tr(): {},
      'vietnamese_tutor'.tr(): {'isVietNamese': true},
      'native_english_tutor'.tr(): {'isNative': true},
      'foreign_tutor'.tr(): {'isVietNamese': false, 'isNative': false},
    };
    String selectedNationality = listNationalities.keys.first;
    return BlocBuilder<TutorListBloc, TutorListState>(
      builder: (context, state) {
        if (state is TutorListSuccess && !state.isReset) {
          if (listNationalities.keys.contains(state.selectedNationality)) {
            selectedNationality = state.selectedNationality;
          }
        } else {
          selectedNationality = listNationalities.keys.first;
        }
        return DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16.0),
          ),
          isExpanded: true,
          value: selectedNationality,
          items: listNationalities.keys
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 8),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            selectedNationality = value!;
            context.read<TutorListBloc>().add(FilterTutorsByNationality(
                nationality: listNationalities[value]!,
                selectedNationality: selectedNationality));
          },
          style: const TextStyle(
            color: Colors.black,
          ),
        );
      },
    );
  }

  Widget _searchByName() {
    TextEditingController controller = TextEditingController();
    return BlocListener<TutorListBloc, TutorListState>(
      listener: (context, state) {
        if (state is TutorListSuccess) {
          log('isReset: ${state.isReset}');
          if (state.isReset == true) {
            log('reset search by name');
            controller.clear();
          }
        }
      },
      child: TextField(
        controller: controller,
        onChanged: (value) =>
            context.read<TutorListBloc>().add(FilterTutorsByName(value)),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.type_specimen_outlined),
          hintText: 'enter_tutor_name'.tr(),
          hintStyle: const TextStyle(
            color: Color(0xFFB0B0B0),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
    );
  }

  _listTutorInformationCard(
      List<Tutor> tutors,
      List<LearnTopic> listLearnTopics,
      List<TestPreparation> listTestPreparations,
      int totalPage,
      int page) {
    // Sort tutors by favorite status, favorite tutor status and rating
    tutors.sort((a, b) {
      if (b.isFavorite != a.isFavorite) {
        return (b.isFavorite ?? false) ? 1 : -1;
      }
      if (b.isFavoriteTutor != a.isFavoriteTutor) {
        return (b.isFavoriteTutor ?? false) ? 1 : -1;
      }
      return (b.rating ?? 0).compareTo(a.rating ?? 0);
    });

    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tutors.length + 1, // Increase itemCount by 1
        itemBuilder: (context, index) {
          if (index < tutors.length) {
            return Column(
              children: [
                TutorInformationCard(
                    tutor: tutors[index],
                    listLearnTopics: listLearnTopics,
                    listTestPreparations: listTestPreparations),
                const SizedBox(height: 16),
              ],
            );
          } else {
            return NumberPaginator(
              numberPages: totalPage,
              initialPage: page - 1,
              onPageChange: (index) {
                log('index, $index');
                context
                    .read<TutorListBloc>()
                    .add(TutorListRequested(page: index + 1));
              },
            ); // Display _paginator at the end
          }
        },
      ),
    );
  }

  _inputFilter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'find_a_tutor'.tr(),
              style: CustomTextStyle.headlineMedium,
            )),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: _searchByName(),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: _selectNationality(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('select_speciality'.tr(), style: CustomTextStyle.headlineMedium),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: _specialitiesChips(),
        ),
      ],
    );
  }

  Widget _specialitiesChips() {
    return BlocBuilder<TutorListBloc, TutorListState>(
      buildWhen: (previousState, currentState) {
        if (currentState is TutorListSuccess) {
          if (previousState is TutorListSuccess) {
            return listEquals(
                    previousState.learnTopics, currentState.learnTopics) &&
                listEquals(previousState.testPreparations,
                    currentState.testPreparations);
          }
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is TutorListSuccess) {
          var combinedList =
              getTopicsMap(state.learnTopics, state.testPreparations)
                  .entries
                  .map((e) => LearnTopic(key: e.key, name: e.value))
                  .toList();

          log('filters specialties: ${state.filters['specialties']}');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 2,
                children: List<Widget>.generate(
                  combinedList.length,
                  (index) => _buildChip(combinedList[index], state),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  context.read<TutorListBloc>().add(ResetFilters());
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.primaryColor, width: 1),
                ),
                child: Text('reset_filters'.tr(),
                    style: TextStyle(color: AppTheme.primaryColor)),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildChip(LearnTopic topic, TutorListSuccess state) {
    return ChoiceChip(
      label: Text(
        topic.name ?? '',
        style: TextStyle(
          color: (state.filters['specialties'] as List<String>?)
                      ?.contains(topic.key) ??
                  false
              ? Theme.of(context).primaryColor
              : Colors.black54,
        ),
      ),
      checkmarkColor: Theme.of(context).primaryColor,
      backgroundColor: const Color(0xFFE4E6EB),
      selectedColor: const Color(0xFFDDEAFF),
      selected: (state.filters['specialties'] as List<String>?)
              ?.contains(topic.key) ??
          false,
      onSelected: (bool selected) {
        context.read<TutorListBloc>().add(
              FilterTutorsBySpeciality(topic.key ?? ''),
            );
      },
      side: BorderSide.none,
    );
  }
}

Map<String, String> getTopicsMap(
    List<LearnTopic> learnTopics, List<TestPreparation> testPreparations) {
  Map<String, String> topicsMap = {};

  for (LearnTopic topic in learnTopics) {
    if (topic.key != null && topic.name != null) {
      topicsMap[topic.key!] = topic.name!;
    }
  }

  for (TestPreparation test in testPreparations) {
    if (test.key != null && test.name != null) {
      topicsMap[test.key!] = test.name!;
    }
  }

  return topicsMap;
}
