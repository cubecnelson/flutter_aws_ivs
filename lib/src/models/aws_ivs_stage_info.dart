class AwsIvsStageInfo {
  List<ParticipantTokens>? participantTokens;
  Stage? stage;

  AwsIvsStageInfo({this.participantTokens, this.stage});

  AwsIvsStageInfo.fromJson(Map<String, dynamic> json) {
    if (json['participantTokens'] != null) {
      participantTokens = <ParticipantTokens>[];
      json['participantTokens'].forEach((v) {
        participantTokens!.add(new ParticipantTokens.fromJson(v));
      });
    }
    stage = json['stage'] != null ? new Stage.fromJson(json['stage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.participantTokens != null) {
      data['participantTokens'] =
          this.participantTokens!.map((v) => v.toJson()).toList();
    }
    if (this.stage != null) {
      data['stage'] = this.stage!.toJson();
    }
    return data;
  }
}

class ParticipantTokens {
  String? participantId;
  String? token;
  String? userId;

  ParticipantTokens({this.participantId, this.token, this.userId});

  ParticipantTokens.fromJson(Map<String, dynamic> json) {
    participantId = json['participantId'];
    token = json['token'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['participantId'] = this.participantId;
    data['token'] = this.token;
    data['userId'] = this.userId;
    return data;
  }
}

class Stage {
  String? arn;
  String? name;
  Tags? tags;

  Stage({this.arn, this.name, this.tags});

  Stage.fromJson(Map<String, dynamic> json) {
    arn = json['arn'];
    name = json['name'];
    tags = json['tags'] != null ? new Tags.fromJson(json['tags']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arn'] = this.arn;
    data['name'] = this.name;
    if (this.tags != null) {
      data['tags'] = this.tags!.toJson();
    }
    return data;
  }
}

class Tags {
  Tags();

  Tags.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
