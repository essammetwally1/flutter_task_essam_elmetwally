// lib/screens/home_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';
import 'package:flutter_task_essam_elmetwally/components/product_item.dart';
import 'package:flutter_task_essam_elmetwally/models/product_model.dart';
import 'package:flutter_task_essam_elmetwally/providers/product_provider.dart';
import 'package:flutter_task_essam_elmetwally/screens/filtering_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  final ScrollController? scrollController;
  const HomeTab({super.key, this.scrollController});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  final List<String> tabLabels = [
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
  Future<void> _ensureLocationAndNavigate(BuildContext context) async {
    final status = await Permission.locationWhenInUse.status;

    if (status.isGranted) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => FilteringScreen()));
      return;
    }

    final result = await Permission.locationWhenInUse.request();

    if (result.isGranted) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => FilteringScreen()));
      return;
    }

    if (result.isPermanentlyDenied) {
      final open = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Permission required'),
          content: const Text(
            'Location permission is permanently denied. Go to app settings to enable it.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );

      if (open == true) await openAppSettings();
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Location permission denied — cannot continue.'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabLabels.length, vsync: this);

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        selectedIndex = tabController.index;
        final provider = Provider.of<ProductProvider>(context, listen: false);

        final category = tabLabels[selectedIndex];
        provider.filterByCategory(category);
      }
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ProductProvider>(context, listen: false);
      if (provider.loading) {
        while (provider.loading) {
          await Future.delayed(const Duration(milliseconds: 50));
        }
      }
      provider.filterByCategory('كل العروض');
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<Product> productList = provider.filterdProducts;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _ensureLocationAndNavigate(context),
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
                const SizedBox(height: 10),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TabBar(
                    controller: tabController,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                    onTap: (value) {
                      selectedIndex = value;
                    },
                    tabs: tabLabels.map((label) {
                      final index = tabLabels.indexOf(label);
                      final isSelected = selectedIndex == index;
                      return Tab(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.primary
                                  : AppTheme.grey,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? AppTheme.primary
                                  : AppTheme.grey,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                controller: widget.scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          physics: const BouncingScrollPhysics(),
                          itemCount: images.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFfff7f4),
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
                          const Spacer(),
                          Text(
                            'شحن مجانى',
                            style: textTheme.titleSmall!.copyWith(
                              color: AppTheme.green,
                            ),
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.asset('assets/icons/check.svg'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: .45,
                          ),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return ProductItem(
                          product: productList[index],
                          onTap: () {},
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
