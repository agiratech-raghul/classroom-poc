import 'package:classroom_poc/Utils/utils.dart';
import 'package:classroom_poc/model/PicsArt_SuccessResponse.dart';
import 'package:classroom_poc/service/api_service.dart';
import 'package:classroom_poc/service/webservice.dart';
import 'package:flutter/material.dart';

class PicsEditRepository {
  final ApiService _apiService = ApiService();

  Future<PicsArtSuccessResponse?> editPics(
      {required String data,
      bool? filerType,
      Map<String, String>? field,
      String? data1}) async {
    return await _apiService.mulitPart<PicsArtSuccessResponse?>(
        endpoint: Utils.picsArt(filerType!
            ? PicsArtEndpoint.BG_REMOVE
            : PicsArtEndpoint.TEXTURE),
        data: data,
        field: field,
        data1: data1,
        converter: (response) {
          final code = response[WebserviceConstants.statusCode];
          debugPrint("response mad${response[WebserviceConstants.statusCode]}");
          if (code == 200) {
            return PicsArtSuccessResponse.fromJson(response);
          }
          return null;
        });
  }
}
