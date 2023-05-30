import 'package:flutter/material.dart';

import '../../../../data/repository/configuration_repo.dart';
import '../../../../res/colors/color.dart';
import '../../widgets/my_container.dart';

class StatusServo extends StatefulWidget {
  const StatusServo({
    super.key,
  });

  @override
  State<StatusServo> createState() => _StatusServoState();
}

class _StatusServoState extends State<StatusServo> {
  bool isEnabled = false;

  getConfiguration() async {
    final config = await ConfigurationRepo().getConfigOnce();
    setState(() {
      isEnabled = config!.servoEnabled!;
    });
  }

  @override
  void initState() {
    super.initState();
    getConfiguration();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pengaturan Servo",
            style: TextStyle(
              color: kTitleColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Text(
                "Status Servo",
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 25.0),
                child: Switch(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeTrackColor: kPrimaryColor.withOpacity(0.1),
                  activeColor: kPrimaryColor,
                  value: isEnabled,
                  onChanged: (bool value) {
                    ConfigurationRepo().updateServoQuery(value);
                    getConfiguration();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
