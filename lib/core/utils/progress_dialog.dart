import '../../src/app_export.dart';

class ProgressDialog {
  static bool isProgressVisible = false;

  ///common method for showing progress dialog
  static void showProgressDialog(
      {BuildContext? context, isCancellable = false}) async {
    if (!isProgressVisible) {
      showDialog(
        barrierDismissible: isCancellable,
        context: context!,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          );
        },
      );
      isProgressVisible = true;
    }
  }

  ///common method for hiding progress dialog
  static void hideProgressDialog(BuildContext context) {
    if (isProgressVisible) {
      Navigator.pop(context);
    }
    isProgressVisible = false;
  }
}
