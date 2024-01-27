import 'package:flutter/material.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';

class NotificationSlider extends StatefulWidget {
  final UserProvider userProvider;

  const NotificationSlider({Key? key, required this.userProvider})
      : super(key: key);

  @override
  NotificationSliderState createState() => NotificationSliderState();
}

class NotificationSliderState extends State<NotificationSlider> {
  @override
  Widget build(BuildContext context) {
    bool isNotificationEnabled =
        widget.userProvider.userModel.settings.notification;

    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Off',
              style: TextStyle(
                  color: isNotificationEnabled
                      ? Colors.grey
                      : Theme.of(context).primaryColor)),
          Switch(
            value: isNotificationEnabled,
            onChanged: (value) {
              setState(() {
                widget.userProvider.setSetings(value, null);
              });
            },
            activeTrackColor: Theme.of(context).primaryColor,
            activeColor: Colors.white,
          ),
          Text('On',
              style: TextStyle(
                  color: isNotificationEnabled
                      ? Theme.of(context).primaryColor
                      : Colors.grey)),
        ],
      ),
    );
  }
}
