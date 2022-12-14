import 'package:adminpanel/configs/const.dart';
import 'package:http/http.dart' as http;
import 'package:images_picker/images_picker.dart';

Future postOperation(
  String userId,
  String palace,
  String tenant,
  String operationType,
  String operation,
  String description,
  List<Media> images,
) async {
  var request = http.MultipartRequest('POST', Uri.parse(AppConst.operation));
  request.fields['user_id'] = userId;
  request.fields['palace'] = palace;
  request.fields['tenant'] = tenant;
  request.fields['operationType'] = operationType;
  request.fields['operation'] = operation;
  request.fields['description'] = description;

  for (var image in images) {
    var imagePath = await http.MultipartFile.fromPath("media", image.path);
    request.files.add(imagePath);
  }

  var response = await request.send();
  if (response.statusCode == 200) {
    print('Operation uploaded');
  } else {
    print('Operation not uploaded');
  }
}
