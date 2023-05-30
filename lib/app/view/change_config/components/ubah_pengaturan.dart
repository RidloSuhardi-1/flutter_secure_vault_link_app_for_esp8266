import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../data/repository/configuration_repo.dart';
import '../../../../res/colors/color.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_container.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class UbahPengaturan extends StatefulWidget {
  const UbahPengaturan({super.key});
  @override
  State<UbahPengaturan> createState() => _UbahPengaturanState();
}

class _UbahPengaturanState extends State<UbahPengaturan> {
  final _key = GlobalKey<FormState>();

  final _nearestDistanceEditor = TextEditingController();
  final _servoPauseTimeEditor = TextEditingController();

  @override
  void initState() {
    super.initState();
    ConfigurationRepo().getConfigOnce().then((config) {
      setState(() {
        _nearestDistanceEditor.text = config!.nearestDistance!.toString();
        _servoPauseTimeEditor.text = config.servoPauseTime!.toString();
      });
    });
  }

  @override
  void dispose() {
    _nearestDistanceEditor.dispose();
    _servoPauseTimeEditor.dispose();
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
            "Ubah Pengaturan",
            style: TextStyle(
              color: kTitleColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16.0),
          Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Jarak Terdekat",
                  style: TextStyle(
                      color: kTextColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8.0),
                buildInputNearestDistance(),
                const SizedBox(height: 16.0),
                const Text(
                  "Waktu Jeda Servo",
                  style: TextStyle(
                      color: kTextColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8.0),
                buildInputServoPauseTime(),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: MyButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  ConfigurationRepo().updateConfigQuery(
                    int.parse(_nearestDistanceEditor.text),
                    int.parse(_servoPauseTimeEditor.text),
                  );

                  FocusScope.of(context).unfocus();
                }
              },
              foregroundColor: kPrimaryColor,
              backgroundColor: kPrimaryColor.withOpacity(0.1),
              child: const Text("Simpan",
                  style:
                      TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildInputNearestDistance() {
    return TextFormField(
      controller: _nearestDistanceEditor,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Minimal nilai adalah 0";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      cursorColor: kTextColor,
      style: const TextStyle(
          color: kTextColor, fontSize: 12.0, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 11.0),
        prefix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("CM"),
            const SizedBox(width: 8.0),
            Container(
              width: 1.0,
              margin: const EdgeInsets.symmetric(vertical: 11.0),
              color: kSecondaryColor,
            ),
            const SizedBox(width: 8.0),
          ],
        ),
        hintText: "0",
      ),
    );
  }

  TextFormField buildInputServoPauseTime() {
    return TextFormField(
      controller: _servoPauseTimeEditor,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Minimal nilai adalah 0";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      cursorColor: kTextColor,
      style: const TextStyle(
          color: kTextColor, fontSize: 12.0, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 11.0),
        prefix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("SEC"),
            const SizedBox(width: 8.0),
            Container(
              width: 1.0,
              margin: const EdgeInsets.symmetric(vertical: 11.0),
              color: kSecondaryColor,
            ),
            const SizedBox(width: 8.0),
          ],
        ),
        hintText: "0",
      ),
    );
  }
}
