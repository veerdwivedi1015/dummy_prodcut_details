import 'package:auto_route/auto_route.dart';
import 'package:demo_assignment/authentication/screen/splash_screen/splash_screen_view_model.dart';
import 'package:demo_assignment/components/atom/typography1.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SplashScreenViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(_controller, context),
        builder: (ctx, model, _) {
          return Scaffold(
            body: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.home,
                        size: 100,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Typography1(
                      data: 'Hey Guys!!',
                      textColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    LinearProgressIndicator(
                      minHeight: 20,
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(10),
                          left: Radius.circular(10)),
                      value: _animation.value,
                      backgroundColor: Colors.white,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.orangeAccent,
                      ),
                    )
                  ],
                )),
          );
        });
  }
}
