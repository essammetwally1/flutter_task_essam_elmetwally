import 'package:flutter/material.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';
import 'package:flutter_task_essam_elmetwally/components/custom_elevated_button.dart';
import 'package:flutter_task_essam_elmetwally/components/plan_card.dart';
import 'package:flutter_task_essam_elmetwally/components/plan_row.dart';

class ProfileTab extends StatefulWidget {
  final ScrollController? scrollController;

  const ProfileTab({super.key, this.scrollController});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late TabController tabController;
  bool isSelectMainPlan = false;
  bool isSelectExtraPlan = true;
  bool isSelectPlusPlan = true;
  bool isSelectSuperPlan = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        controller: widget.scrollController,
        physics: const BouncingScrollPhysics(),

        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'أختر الباقات اللى تناسبك',
                      style: textTheme.titleLarge!.copyWith(
                        fontSize: 24,
                        color: AppTheme.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'أختار من باقات التمييز بل أسفل اللى تناسب أحتياجاتك',
                    style: textTheme.titleSmall!.copyWith(
                      color: AppTheme.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            PlanCard(
              price: '3,000ج.م',
              planName: 'أساسية',
              isSelectPlan: isSelectMainPlan,
              onChanged: (value) {
                setState(() {
                  isSelectMainPlan = value ?? false;
                });
              },
              widget: PlanRow(text: 'صلاحية الأعلان 30 يوم', iconpath: 'time'),
            ),
            PlanCard(
              price: '3,000ج.م',
              planName: 'أكسترا',
              isSelectPlan: isSelectExtraPlan,
              onChanged: (value) {
                setState(() {
                  isSelectExtraPlan = value ?? false;
                });
              },
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/views.png'),
                  Expanded(
                    child: Column(
                      children: [
                        PlanRow(
                          text: 'صلاحية الأعلان 30 يوم',
                          iconpath: 'time',
                        ),
                        PlanRow(
                          text: 'رفع لأعلى القائمة كل 3 أيام',
                          iconpath: 'rocket',
                        ),
                        PlanRow(
                          text: 'تثبيت فى مقاول صحى',
                          iconpath: 'keep',
                          widget: Text(
                            '( خلال ال48 ساعة القادمة )',
                            style: textTheme.titleSmall!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PlanCard(
              price: '3,000ج.م',

              planName: 'بلس',
              isSelectPlan: isSelectPlusPlan,
              onChanged: (value) {
                setState(() {
                  isSelectPlusPlan = value ?? false;
                });
              },
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/views.png'),
                  Expanded(
                    child: Column(
                      children: [
                        PlanRow(
                          text: 'صلاحية الأعلان 30 يوم',
                          iconpath: 'time',
                        ),
                        PlanRow(
                          text: 'رفع لأعلى القائمة كل 2 أيام',
                          iconpath: 'rocket',
                        ),
                        PlanRow(
                          text: 'تثبيت فى مقاول صحى',
                          iconpath: 'keep',
                          widget: Text(
                            '( خلال ال48 ساعة القادمة )',
                            style: textTheme.titleSmall!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                        PlanRow(
                          text: 'ظهور فى كل محافظات مصر',
                          iconpath: 'global',
                        ),
                        PlanRow(text: 'أعلان مميز', iconpath: 'mark'),
                        PlanRow(
                          text: 'تثبيت فى مقاول صحى فى الجهراء',
                          iconpath: 'keep',
                        ),
                        PlanRow(
                          text: 'تثبيت فى مقاول صحى',
                          iconpath: 'keep',
                          widget: Text(
                            '( خلال ال48 ساعة القادمة )',
                            style: textTheme.titleSmall!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            PlanCard(
              price: '3,000ج.م',

              planName: 'سوبر',
              isSelectPlan: isSelectSuperPlan,
              onChanged: (value) {
                setState(() {
                  isSelectSuperPlan = value ?? false;
                });
              },
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/views.png'),
                  Expanded(
                    child: Column(
                      children: [
                        PlanRow(
                          text: 'صلاحية الأعلان 30 يوم',
                          iconpath: 'time',
                        ),
                        PlanRow(
                          text: 'رفع لأعلى القائمة كل 2 أيام',
                          iconpath: 'rocket',
                        ),
                        PlanRow(
                          text: 'تثبيت فى مقاول صحى',
                          iconpath: 'keep',
                          widget: Text(
                            '( خلال ال48 ساعة القادمة )',
                            style: textTheme.titleSmall!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                        PlanRow(
                          text: 'ظهور فى كل محافظات مصر',
                          iconpath: 'global',
                        ),
                        PlanRow(text: 'أعلان مميز', iconpath: 'mark'),
                        PlanRow(
                          text: 'تثبيت فى مقاول صحى فى الجهراء',
                          iconpath: 'keep',
                        ),
                        PlanRow(
                          text: 'تثبيت فى مقاول صحى',
                          iconpath: 'keep',
                          widget: Text(
                            '( خلال ال48 ساعة القادمة )',
                            style: textTheme.titleSmall!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.grey.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(8),
                border: BoxBorder.all(color: AppTheme.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'باقات مخصصة لك',
                    style: textTheme.titleSmall!.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                  Text(
                    'تواصل معنا لأختيار الباقة المناسبة لك',
                    style: textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                      color: AppTheme.black,
                    ),
                  ),
                  Text(
                    'فريق المبيعات',
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomElevatedButton(
                textElevatedButton: 'التالى',
                onPressed: () {},
                widget: Icon(Icons.arrow_back, color: AppTheme.white, size: 24),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
