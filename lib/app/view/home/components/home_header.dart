import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../res/colors/color.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: SvgPicture.asset("assets/images/svg/menu.svg"),
          onTap: () {
            debugPrint("Go to menu");
          },
        ),
        Row(
          children: [
            const Text("SecureVault",
                style: TextStyle(
                    color: kTitleSecondaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700)),
            const SizedBox(width: 5.0),
            SizedBox(
                width: 41.0, child: Image.asset("assets/images/link-img.png")),
          ],
        ),
        GestureDetector(
          child: SvgPicture.asset("assets/images/svg/help.svg"),
          onTap: () {
            debugPrint("Go to options");
          },
        ),
      ],
    );
  }
}
