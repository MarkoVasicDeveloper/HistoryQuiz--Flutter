import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/global/audio_player.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';

class VolumeSlider extends StatefulWidget {
  final UserProvider userProvider;

  const VolumeSlider({super.key, required this.userProvider});
  @override
  VolumeSliderState createState() => VolumeSliderState();
}

class VolumeSliderState extends State<VolumeSlider> {
  final TextEditingController _sliderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _sliderController.text =
        widget.userProvider.userModel.settings.volume.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Slider(
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Theme.of(context).canvasColor,
        value: double.parse(_sliderController.text),
        min: 0,
        max: 100,
        onChanged: (value) {
          setState(() {
            _sliderController.text = value.toString();
          });
          widget.userProvider.setSetings(null, value ~/ 1);
          AudioPlayerSingleton().setVolumeFromUserProvider(value / 100.0);
        },
      ),
    );
  }
}
