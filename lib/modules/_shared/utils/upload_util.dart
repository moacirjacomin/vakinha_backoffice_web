import 'dart:html';
import 'dart:typed_data';

typedef UploadCallBack = void Function(Uint8List file, String fileName);

class UploadHtmlUtil {
  void startUpload(UploadCallBack callback) {
    final uploadInput = FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      handleFileUpload(uploadInput, callback);
    });
  }

  void handleFileUpload(FileUploadInputElement uploadInput, UploadCallBack callback) {
    final files = uploadInput.files;

    if (files != null && files.isNotEmpty) {
      final file = files.first;
      final reader = FileReader();

      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((event) {
        final bytes = Uint8List.fromList(reader.result as List<int>);
        callback(bytes, file.name);
      });
    }
  }
}
