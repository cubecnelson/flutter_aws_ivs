import 'dart:convert';

import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:flutter_aws_ivs/src/models/aws_ivs_stage_info.dart';
import '../models/aws_ivs_create_participant_token.dart';

class AwsIvsService {
  static late final AwsIvsService? _singleton;

  final String region;
  final String accessKeyId;
  final String secretAccessKey;
  final String host;

  static void init(
      {required String region,
      required String accessKeyId,
      required String secretAccessKey}) {
    _singleton = AwsIvsService._internal(
      region: region,
      accessKeyId: accessKeyId,
      secretAccessKey: secretAccessKey,
      host: 'ivsrealtime.$region.amazonaws.com',
    );
  }

  AwsIvsService._internal({
    required this.region,
    required this.accessKeyId,
    required this.secretAccessKey,
    required this.host,
  });

  factory AwsIvsService() {
    assert(_singleton != null);
    return _singleton!;
  }

  Future<Map<String, dynamic>> postIvsRealtimeWithAwsClient(
      {required String path, Map<String, dynamic>? requestBody}) async {
    final scope = AWSCredentialScope(
      region: region,
      service: AWSService.ivs,
    );

    final signer = AWSSigV4Signer(
      credentialsProvider: AWSCredentialsProvider(
        AWSCredentials(accessKeyId, secretAccessKey),
      ),
    );

    var awsIvsUri = Uri.https(host, path);
    final request = AWSHttpRequest.post(
      awsIvsUri,
      followRedirects: true,
      headers: const {
        AWSHeaders.contentType: 'application/json',
      },
      body: jsonEncode(requestBody).codeUnits,
    );
    final signedRequest = await signer.sign(
      request,
      credentialScope: scope,
    );

    final resp = await signedRequest.send(client: IvsAwsHttpClient()).response;
    final responseBody = await resp.decodeBody();

    final json = jsonDecode(responseBody);

    return json;
  }

  Future<AwsIvsCreateParticipantToken?> createParticipantToken(
      String stageArn) async {
    try {
      var json = await postIvsRealtimeWithAwsClient(
          path: '/CreateParticipantToken',
          requestBody: {
            "stageArn": stageArn,
          });

      return AwsIvsCreateParticipantToken.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  Future<AwsIvsStageInfo?> createStage(String name) async {
    try {
      var json = await postIvsRealtimeWithAwsClient(
          path: '/CreateStage',
          requestBody: {
            "name": name,
          });

      return AwsIvsStageInfo.fromJson(json);
    } catch (e) {
      return null;
    }
  }
}

class IvsAwsHttpClient extends AWSCustomHttpClient {
  @override
  // TODO: implement supportedProtocols
  SupportedProtocols get supportedProtocols => SupportedProtocols.http1;
}
