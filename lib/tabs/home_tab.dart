import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  final List<String> _tabLabels = [
    'كل العروض',
    'ملابس',
    'أكسسوارات',
    'الكترونيات',
    'أثاث',
    'ساعات',
  ];
  final List<String> images = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image4.png',
    'assets/images/image5.png',
    'assets/images/image6.png',
  ];

  final List<String> labels = [
    'موضة رجالى',
    'ساعات',
    'موبايلات',
    'منتجات تجميل',
    'منتجات تجميل',
    'منتجات تجميل',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLabels.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppTheme.black.withValues(alpha: .5),
                  ),
                ),
                Text(
                  'الكل',
                  style: textTheme.titleMedium!.copyWith(
                    color: AppTheme.black.withValues(alpha: .5),
                  ),
                ),
                Expanded(
                  child: Text(
                    'أستكشف العروض',
                    style: textTheme.titleMedium!.copyWith(
                      color: AppTheme.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Directionality(
              textDirection: TextDirection.rtl,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                tabs: _tabLabels.map((label) {
                  final index = _tabLabels.indexOf(label);
                  final isSelected = _selectedIndex == index;
                  return Tab(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? AppTheme.primary : AppTheme.grey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? AppTheme.primary : AppTheme.grey,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 4),

                  itemCount: images.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            images[index],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 80,
                          child: Text(
                            labels[index],
                            textAlign: TextAlign.center,
                            style: textTheme.titleSmall!.copyWith(
                              color: AppTheme.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xFFfff7f4),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Text(
                    'لأى عرض تطلبه دلوقتى !',
                    style: textTheme.titleSmall!.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'شحن مجانى',
                    style: textTheme.titleSmall!.copyWith(
                      color: AppTheme.green,
                    ),
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset('assets/icons/check.svg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
