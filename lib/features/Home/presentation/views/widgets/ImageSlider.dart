import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageSlider extends StatefulWidget {
  final List<String> images;
  final int intervalSeconds; // Customizable interval for auto-slide

  const ImageSlider({
    super.key,
    required this.images,
    this.intervalSeconds = 3, // Default to 3 seconds
  });

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: widget.intervalSeconds), (timer) {
      setState(() {
        _currentPage = (_currentPage < widget.images.length - 1) ? _currentPage + 1 : 0;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h), // Responsive padding
      child: SizedBox(
        height: 250.h, // Responsive height
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0.r), // Responsive border radius
                    ),
                    elevation: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0.r), // Responsive border radius
                      child: Image.asset(
                        widget.images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 24.sp, // Responsive icon size
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              onPageChanged: _onPageChanged, // Update current page
            ),
            Positioned(
              bottom: 10.h, // Responsive position
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.images.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.h),
                    width: _currentPage == index ? 12.w : 8.w, // Responsive width
                    height: 8.h, // Responsive height
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.orange : Colors.grey,
                      borderRadius: BorderRadius.circular(4.r), // Responsive border radius
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
