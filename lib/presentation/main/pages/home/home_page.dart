import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_project/app/di.dart';
import 'package:new_project/domain/models.dart';
import 'package:new_project/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:new_project/presentation/main/pages/home/home_viewmodel.dart';
import 'package:new_project/presentation/resources/color_manager.dart';
import 'package:new_project/presentation/resources/font_manager.dart';
import 'package:new_project/presentation/resources/routes_manager.dart';
import 'package:new_project/presentation/resources/string_manager.dart';
import 'package:new_project/presentation/resources/styles_manager.dart';
import 'package:new_project/presentation/resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
          child: StreamBuilder<FlowState>(
              stream: _viewModel.outputState,
              builder: (context, snapshot) {
                return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                        () {
                  _viewModel.start();
                }) ?? _getContentWidget();
          }),
    ));
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewObject>(
      stream: _viewModel.outHomeData,
      builder: (context, snapshot) {
        return snapshot.data != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getBannersCarousel(snapshot.data?.banners),
                  _getSection(AppStrings.services.tr()),
                  _getServices(snapshot.data?.services),
                  _getSection(AppStrings.stores.tr()),
                  _getStores(snapshot.data?.stores),
                ],
              )
            : Container();
      },
    );
  }

  _getBannersCarousel(List<Banners>? banner) {
    return CarouselSlider(
        items: banner
            ?.map((banner) => SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: AppSize.z1_5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.z12),
                      side: BorderSide(
                          color: ColorManger.primary, width: AppSize.z1_5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.z12),
                      child: Image.network(
                        banner.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          height: AppSize.z200,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ));
  }

  _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: getBoldStyle(color: ColorManger.primary, fontSize: FontSize.s12),
      ),
    );
  }

  _getServices(List<Services>? service) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      child: Container(
        height: AppSize.z160,
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: service!
              .map((service) => Card(
                    elevation: AppSize.z4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.z12),
                      side: BorderSide(
                          color: ColorManger.white, width: AppSize.z1_5),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.z12),
                          child: Image.network(
                            service.image,
                            fit: BoxFit.cover,
                            width: AppSize.z120,
                            height: AppSize.z120,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: AppPadding.p8),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                service.title,
                                style: getLightStyle(color: ColorManger.gray2),
                                textAlign: TextAlign.center,
                              )),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  _getStores(List<Stores>? stores) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
      child: Flex(
        direction: Axis.vertical,
        children: [
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(
                stores!.length,
                (index) => InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                    },
                    child: Card(
                      elevation: AppSize.z4,
                      child: Image.network(
                        stores[index].image,
                        fit: BoxFit.cover,
                      ),
                    ))),
          )
        ],
      ),
    );
  }
}
