import 'package:flutter/material.dart';

import '../../../../data/repository/configuration_repo.dart';
import '../../../../data/repository/setup_repo.dart';
import '../../../../res/colors/color.dart';
import '../../../model/config.dart';
import '../../change_config/change_config_screen.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_container.dart';

class HomeSetting extends StatefulWidget {
  const HomeSetting({
    super.key,
  });

  @override
  State<HomeSetting> createState() => _HomeSettingState();
}

class _HomeSettingState extends State<HomeSetting> {
  Stream<Config>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = ConfigurationRepo().getConfigQuery();
  }

  @override
  void dispose() {
    _stream?.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SetupRepo().getUpdateDetail(context);

    return StreamBuilder<Config>(
      stream: _stream,
      builder: (context, snapshot) {
        String? farthestDistance = "0";
        String? nearestDistance = "0";
        String? servoPauseTime = "0";
        bool? servoEnabled = false;

        if (snapshot.hasData) {
          final data = snapshot.data;

          farthestDistance = "${data?.farthestDistance}";
          nearestDistance = "${data?.nearestDistance}";
          servoPauseTime = "${data?.servoPauseTime}";
          servoEnabled = data?.servoEnabled;
        }

        return MyContainer(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Pengaturan",
                  style: TextStyle(
                      color: kTitleColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Jarak Terdekat",
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8.0),
                        Text("$nearestDistance cm",
                            style: const TextStyle(
                                color: kTitleColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Jarak Terjauh",
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8.0),
                        Text("$farthestDistance cm",
                            style: const TextStyle(
                                color: kTitleColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Container(height: 1.0, color: kSecondaryColor),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Waktu Jeda Servo",
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8.0),
                        Text("$servoPauseTime sec",
                            style: const TextStyle(
                                color: kTitleColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Status Servo",
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: servoEnabled! ? kGreenColor : kRedColor,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            servoEnabled ? "Aktif" : "Nonaktif",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 40.0,
                child: MyButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ChangeConfigScreen.routeName);
                  },
                  foregroundColor: kPrimaryColor,
                  backgroundColor: kPrimaryColor.withOpacity(0.1),
                  child: const Text(
                    "Perbarui",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
