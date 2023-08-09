class AwsIvsCreateParticipantToken {
  ParticipantToken? participantToken;

  AwsIvsCreateParticipantToken({this.participantToken});

  AwsIvsCreateParticipantToken.fromJson(Map<String, dynamic> json) {
    participantToken = json['participantToken'] != null
        ? ParticipantToken.fromJson(json['participantToken'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (participantToken != null) {
      data['participantToken'] = participantToken!.toJson();
    }
    return data;
  }
}

class ParticipantToken {
  String? expirationTime;
  String? participantId;
  String? token;

  ParticipantToken({this.expirationTime, this.participantId, this.token});

  ParticipantToken.fromJson(Map<String, dynamic> json) {
    expirationTime = json['expirationTime'];
    participantId = json['participantId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expirationTime'] = expirationTime;
    data['participantId'] = participantId;
    data['token'] = token;
    return data;
  }
}
