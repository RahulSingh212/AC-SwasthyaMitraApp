import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

void joinMeeting(String roomText,String subjectText, String userDisplayNameText,String userEmailText) async {

  String serverUrl = "https://meet.jit.si/";

  Map<FeatureFlag, Object> featureFlags = {};
  // Define meetings options here
  var options = JitsiMeetingOptions(
    roomNameOrUrl: roomText,
    serverUrl: serverUrl,
    subject: subjectText,
    userDisplayName: userDisplayNameText,
    userEmail: userEmailText,
    isAudioMuted: false,
    isVideoMuted: false,
    featureFlags: featureFlags,
  );

  debugPrint("JitsiMeetingOptions: $options");
  await JitsiMeetWrapper.joinMeeting(
    options: options,
    listener: JitsiMeetingListener(
      onOpened: () => debugPrint("onOpened"),
      onConferenceWillJoin: (url) {
        debugPrint("onConferenceWillJoin: url: $url");
      },
      onConferenceJoined: (url) {
        debugPrint("onConferenceJoined: url: $url");
      },
      onConferenceTerminated: (url, error) {
        debugPrint("onConferenceTerminated: url: $url, error: $error");
      },
      onAudioMutedChanged: (isMuted) {
        debugPrint("onAudioMutedChanged: isMuted: $isMuted");
      },
      onVideoMutedChanged: (isMuted) {
        debugPrint("onVideoMutedChanged: isMuted: $isMuted");
      },
      onScreenShareToggled: (participantId, isSharing) {
        debugPrint(
          "onScreenShareToggled: participantId: $participantId, "
              "isSharing: $isSharing",
        );
      },
      onParticipantJoined: (email, name, role, participantId) {
        debugPrint(
          "onParticipantJoined: email: $email, name: $name, role: $role, "
              "participantId: $participantId",
        );
      },
      onParticipantLeft: (participantId) {
        debugPrint("onParticipantLeft: participantId: $participantId");
      },
      onParticipantsInfoRetrieved: (participantsInfo, requestId) {
        debugPrint(
          "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
              "requestId: $requestId",
        );
      },
      onChatMessageReceived: (senderId, message, isPrivate) {
        debugPrint(
          "onChatMessageReceived: senderId: $senderId, message: $message, "
              "isPrivate: $isPrivate",
        );
      },
      onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
      onClosed: () => debugPrint("onClosed"),
    ),
  );
}