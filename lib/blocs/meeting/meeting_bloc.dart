import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  MeetingBloc() : super(MeetingInitial()) {
    on<CreateMeetingEvent>(_onCreateMeeting);
  }

  final jitsiMeet = JitsiMeet();

  Future<void> _onCreateMeeting(
      CreateMeetingEvent event, Emitter<MeetingState> emit) async {
    emit(const MeetingCreating());
    final meetingToken = event.url.split("token=").last;

    try {
      Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
      final String room = jwtDecoded['room'];
      var listener = JitsiMeetEventListener(
        conferenceTerminated: (url, error) {
          debugPrint("conferenceTerminated: url: $url, error: $error");
        },
      );

      var options = JitsiMeetConferenceOptions(
        token: meetingToken,
        room: room,
        serverURL: 'https://meet.lettutor.com',
      );
      emit(const MeetingJoined());
      await jitsiMeet.join(options, listener);
      emit(MeetingLeft());
      // _joinMeeting(payloadMap);
    } catch (e) {
      emit(MeetingError(e.toString()));
    }
  }

  // void _joinMeeting(Map<String, dynamic> payload) async {
  //   Map<FeatureFlagEnum, bool> featureFlags = {
  //     FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
  //     FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
  //   };

  //   if (!kIsWeb) {
  //     if (Platform.isAndroid) {
  //       featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
  //     } else if (Platform.isIOS) {
  //       featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
  //     }
  //   }

  //   var options = JitsiMeetingOptions(room: payload['room'])
  //     ..serverURL = 'https://meet.lettutor.com'
  //     ..subject =
  //         'Meeting room of ${payload['userCall']['name']} and ${payload['userBeCalled']['name']}'
  //     ..userDisplayName = '${payload['userCall']['name']}'
  //     ..userAvatarURL = '${payload['userCall']['avatar']}'
  //     ..audioMuted = true
  //     ..videoMuted = true
  //     ..featureFlags = featureFlags;

  //   await JitsiMeet.joinMeeting(options, listener: JitsiMeetingListener(
  //     onConferenceTerminated: (message) {
  //       add(LeaveMeetingEvent());
  //     },
  //   ));
  // }
}
