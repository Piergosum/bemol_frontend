import 'package:flutter/material.dart';

class ResponsePopup {
  Future<void> showPopup(
    BuildContext context,
    String message,
    String status,
  ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
          titlePadding: const EdgeInsets.only(top: 5, right: 5),
          contentPadding:
              const EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 60),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 80,
                child: Image.asset(
                  status == 'success' ? 'images/check.png' : 'images/alert.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                message,
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        );
      },
    );
  }
}
