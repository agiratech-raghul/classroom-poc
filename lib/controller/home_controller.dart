import 'package:classroom_poc/model/PicsArt_SuccessResponse.dart';
import 'package:classroom_poc/model/back_remove_field.dart';
import 'package:classroom_poc/service/edit_repostiry.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  PicsArtSuccessResponse? _removeBackgroundResponse;
  PicsArtSuccessResponse? get removeBg => _removeBackgroundResponse;
  final PicsEditRepository _picsEditRepository = PicsEditRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Future<PicsArtSuccessResponse?> bgRemove(
      String filePath, bool? filterType) async {
    var backgroundRemoveField = BackgroundRemoveField(
            scale: "fit", format: "jpg", bgBlur: "0", outputType: "cutout")
        .toJson();
    toggleLoading();
    _removeBackgroundResponse = await _picsEditRepository.editPics(
        field: backgroundRemoveField,
        data: filePath,
        data1: filterType == false ? filePath : null,
        filerType: filterType);
    toggleLoading();
    debugPrint(
        "final output image ${_removeBackgroundResponse?.data?.url.toString()}");
    notifyListeners();
    return _removeBackgroundResponse;
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
