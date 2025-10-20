import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';
import 'package:flutter_task_essam_elmetwally/components/custom_elevated_button.dart';
import 'package:flutter_task_essam_elmetwally/components/custom_text_field.dart';
import 'package:flutter_task_essam_elmetwally/components/option_chips.dart';
import 'package:flutter_task_essam_elmetwally/screens/map_screen.dart';
import 'package:flutter_task_essam_elmetwally/services/location_service.dart';

class FilteringScreen extends StatefulWidget {
  const FilteringScreen({super.key});

  @override
  State<FilteringScreen> createState() => _FilteringScreenState();
}

class OptionGroup {
  final String title;
  final List<String> options;
  int selectedIndex;

  OptionGroup({
    required this.title,
    required this.options,
    this.selectedIndex = 0,
  }) : assert(options.isNotEmpty, 'options must not be empty');
}

class _FilteringScreenState extends State<FilteringScreen> {
  final TextEditingController textEditingController1 = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();
  final TextEditingController textEditingController3 = TextEditingController();
  final TextEditingController textEditingController4 = TextEditingController();
  String currentLocation = 'جاري الحصول على الموقع...';
  bool _locationLoading = true;

  final List<OptionGroup> _groups = [
    OptionGroup(
      title: 'النوع',
      options: ['الكل', 'توين هاوس', 'فيلا منفصلة', 'تاون هاوس'],
      selectedIndex: 0,
    ),
    OptionGroup(
      title: 'عدد الغرف',
      options: ['4 غرف', '5 غرف+', 'الكل', 'غرفتين', '3 غرف'],
      selectedIndex: 2,
    ),
    OptionGroup(
      title: 'طريقة الدفع',
      options: ['أى', 'تقسيط', 'كاش'],
      selectedIndex: 0,
    ),
    OptionGroup(
      title: 'حالة العقار',
      options: ['أى', 'جاهز', 'قيد الأنشاء'],
      selectedIndex: 0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final result = await LocationService.getCurrentLocationWithAddress();

    setState(() {
      _locationLoading = false;
      if (result.isSuccess) {
        currentLocation = result.address!;
      } else {
        currentLocation = 'تعذر الحصول على الموقع';
      }
    });
  }

  void clearControllers() {
    textEditingController1.clear();
    textEditingController2.clear();
    textEditingController3.clear();
    textEditingController4.clear();
    setState(() {
      _locationLoading = true;
      _getCurrentLocation();
    });
  }

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
    textEditingController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header Section
            Row(
              children: [
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    if (!mounted) return;
                    setState(() {
                      clearControllers();
                      for (final group in _groups) {
                        group.selectedIndex = 0;
                      }
                    });
                  },
                  child: Text(
                    'رجوع للأفتراضى',
                    style: textTheme.titleMedium!.copyWith(
                      color: AppTheme.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'فلترة',
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'الفئة',
                                style: textTheme.titleMedium!.copyWith(
                                  color: AppTheme.grey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'تغيير',
                                  style: textTheme.titleSmall!.copyWith(
                                    color: const Color(0xFF3B4CF2),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'عقارات',
                                    style: textTheme.titleSmall!.copyWith(
                                      color: AppTheme.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'فلل البيع',
                                    style: textTheme.titleSmall!.copyWith(
                                      color: AppTheme.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 5),
                              SvgPicture.asset('assets/icons/cars.svg'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: AppTheme.grey, thickness: 1),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MapScreen(),
                                ),
                              ).then((result) {
                                if (result != null) {
                                  setState(() {
                                    currentLocation = result['address'];
                                  });
                                }
                              });
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 16,
                              color: AppTheme.black.withValues(alpha: 0.5),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'الموقع',
                                  style: textTheme.titleSmall!.copyWith(
                                    color: AppTheme.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                _locationLoading
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        currentLocation,
                                        style: textTheme.titleSmall!.copyWith(
                                          color: AppTheme.blue,
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,
                                      ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            'assets/icons/location.svg',
                            colorFilter: ColorFilter.mode(
                              AppTheme.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const Divider(color: AppTheme.grey, thickness: 1),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'الأقساط الشهرية',
                                style: textTheme.titleMedium!.copyWith(
                                  color: AppTheme.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 80,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: textEditingController1,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: textEditingController2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
                    for (int i = 0; i < _groups.length; i++) ...[
                      const SizedBox(height: 8),
                      _buildSelectionSection(context, textTheme, _groups[i], i),
                    ],

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'السعر',
                                style: textTheme.titleMedium!.copyWith(
                                  color: AppTheme.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 80,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    hintText: 'أقصى سعر',
                                    controller: textEditingController3,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: CustomTextFormField(
                                    hintText: 'أقل سعر',
                                    controller: textEditingController4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomElevatedButton(
                        textElevatedButton: 'شاهد 10,000+ نتائج',
                        onPressed: () {
                          final Map<String, String> selected = {
                            for (int i = 0; i < _groups.length; i++)
                              _groups[i].title:
                                  _groups[i].options[_groups[i].selectedIndex],
                          };
                          log('Selected filters: $selected');
                          log('Current location: $currentLocation');
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionSection(
    BuildContext context,
    TextTheme textTheme,
    OptionGroup group,
    int groupIndex,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                group.title,
                style: textTheme.titleMedium!.copyWith(color: AppTheme.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Directionality(
            textDirection: TextDirection.rtl,
            child: OptionChips(
              options: group.options,
              selectedIndex: group.selectedIndex.clamp(
                0,
                group.options.length - 1,
              ),
              onSelected: (selected) {
                final safe = selected.clamp(0, group.options.length - 1);
                if (!mounted) return;
                setState(() {
                  group.selectedIndex = safe;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
