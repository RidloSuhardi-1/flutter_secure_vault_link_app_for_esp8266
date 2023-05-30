import 'package:flutter/material.dart';

import '../../../data/repository/history_repo.dart';
import '../../../res/colors/color.dart';
import '../widgets/custom_alertdialog.dart';
import 'components/riwayat_hari_ini.dart';
import 'components/semua_riwayat.dart';

class HistoryScreen extends StatefulWidget {
  static const String routeName = '/system_history';

  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  List<Widget>? _tabs;
  List<Widget>? _tabViews;
  TabController? _tabController;

  @override
  void initState() {
    _tabs = [
      const Tab(
        text: "Hari Ini",
      ),
      const Tab(
        text: "Semua Riwayat",
      )
    ];
    _tabViews = [const RiwayatHariIni(), const SemuaRiwayat()];
    _tabController = TabController(length: _tabViews!.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        centerTitle: true,
        title: const Text(
          "Riwayat Deteksi",
          style: TextStyle(
            color: kTitleColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: kTitleColor,
          splashRadius: 20.0,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      title: 'Hapus Riwayat',
                      text: 'Bersihkan semua riwayat yang tersimpan saat ini?.',
                      action: () {
                        HistoryRepo().deleteAllHistory();
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              color: kTitleColor,
              splashRadius: 20.0,
              icon: const Icon(Icons.delete_forever),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 120.0,
              decoration: const BoxDecoration(
                color: kBackgroundColor,
                border: Border(
                  bottom: BorderSide(color: kSecondaryColor, width: 1.0),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 32.0),
              child: Column(
                children: [
                  Container(
                    height: 42.0,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: _tabIndex.isEven
                            ? const BorderRadius.horizontal(
                                left: Radius.circular(6.0))
                            : const BorderRadius.horizontal(
                                right: Radius.circular(6.0)),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: kPrimaryColor,
                      labelStyle: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: _tabs!,
                      onTap: (int index) {
                        setState(() => _tabIndex = index);
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: _tabViews!,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
