import 'package:auto_route/auto_route.dart';
import 'package:demo_assignment/components/atom/typography1.dart';
import 'package:demo_assignment/components/atom/typography2.dart';
import 'package:demo_assignment/components/molecule/button.dart';
import 'package:demo_assignment/models/product.dart';
import 'package:demo_assignment/product/screen/details_screen/details_screen_view_model.dart';
import 'package:demo_assignment/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DetailsScreenViewModel(product: product),
      builder: (ctx, model, _) => _Body(
        model: model,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.model});

  final DetailsScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Typography1(data: 'Details'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => model.handleBackClick(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: Functions.responsiveDeviceWidth(
              context: context,
              percent: 100,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: _ProductDetails(model: model)),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({required this.model});

  final DetailsScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Image(item: model.product!),
        const SizedBox(
          height: 16,
        ),
        TypoGraphy2(
          data: model.product!.title,
          textColor: Colors.black,
        ),
        const SizedBox(
          height: 16,
        ),
        TypoGraphy2(
          data: 'Price: \$ ${model.product!.price}',
          textColor: Colors.black,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.orangeAccent, width: 1),
              color: Colors.orangeAccent,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: TypoGraphy2(
            data: model.product!.description,
            textColor: Colors.black,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CommonButton(buttonTitle: 'Like', callback: () {})
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.item});

  final Product item;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: item.id,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Image.network(
          item.image,
          fit: BoxFit.fill,
          width: Functions.responsiveDeviceWidth(
            context: context,
            percent: 70,
          ),
          height: Functions.responsiveHeight(
            context: context,
            percent: 40,
          ),
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
      ),
    );
  }
}
