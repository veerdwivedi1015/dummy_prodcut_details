import 'package:auto_route/auto_route.dart';
import 'package:demo_assignment/components/atom/typography1.dart';
import 'package:demo_assignment/components/atom/typography3.dart';
import 'package:demo_assignment/models/product.dart';
import 'package:demo_assignment/product/screen/home_screen/home_screen_view_model.dart';
import 'package:demo_assignment/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeScreenViewModel(),
        onViewModelReady: (model) => model.init(context),
        builder: (ctx, model, _) => _Body(
              model: model,
            ));
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.model,
  });

  final HomeScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Typography1(data: 'Home'),
        leading: model.isAtTop(context)
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => model.handleBackClick(context),
              ),
      ),
      body: model.isBusy
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
                strokeWidth: 2,
              ),
            )
          : SizedBox(
              height:
                  Functions.responsiveHeight(context: context, percent: 100),
              width: Functions.responsiveDeviceWidth(
                  context: context, percent: 100),
              child: ListView.builder(
                  itemCount: model.data.length,
                  itemBuilder: (ctx, index) => _Product(
                        item: model.data[index],
                        model: model,
                      )),
            ),
    );
  }
}

class _Product extends StatelessWidget {
  const _Product({
    required this.item,
    required this.model,
  });

  final Product item;
  final HomeScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => model.onItemClick(item, context),
      child: Hero(
        tag: item.id,
        child: Card(
          elevation: 2,
          color: Colors.orangeAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Image(item: item),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Typography3(
                      data: item.title,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Typography3(
                        data: 'Price: \$ ${item.price}',
                        textColor: Colors.black,
                        textAlign: TextAlign.start)
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.item});

  final Product item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Image.network(
        item.image,
        fit: BoxFit.fill,
        width: Functions.responsiveDeviceWidth(
          context: context,
          percent: 40,
        ),
        height: Functions.responsiveHeight(context: context, percent: 20),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Container(
            decoration: const BoxDecoration(color: Colors.white30),
            width: Functions.responsiveDeviceWidth(
              context: context,
              percent: 40,
            ),
            height: Functions.responsiveHeight(context: context, percent: 20),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
                strokeWidth: 2,
              ),
            ),
          );
        },
      ),
    );
  }
}
