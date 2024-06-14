import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/onboarding/pages/onboarding_page_one.dart';
import 'package:savoir/features/onboarding/pages/onboarding_page_three.dart';
import 'package:savoir/features/onboarding/pages/onboarding_page_two.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _pageController = PageController();

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // add skip button at the top left

          PageView(
            controller: _pageController,
            children: const [
              OnboardingPageOne(),
              OnboardingPageTwo(),
              OnboardingPageThree(),
            ],
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
          ),

          // ================== Not shown if above of the page view ==================
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignment: const Alignment(-1, -0.9),
            child: Opacity(
              opacity: _currentPage == 2 ? 0 : 1,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  'Saltar',
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                ),
              ),
            ),
          ),

          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Opacity(
                  opacity: _currentPage == 0 ? 0 : 1,
                  child: IconButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_back, color: AppTheme.primaryColor),
                  ),
                ),
                SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppTheme.primaryColor,
                    )),
                Opacity(
                  opacity: _currentPage == 2 ? 0 : 1,
                  child: IconButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_forward, color: AppTheme.primaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
