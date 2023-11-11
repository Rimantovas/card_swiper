import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'forms/form_widget.dart';

class ExampleCustom extends StatefulWidget {
  const ExampleCustom({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ExampleCustomState();
  }
}

class _ExampleCustomState extends State<ExampleCustom> {
  //properties want to custom
  late int _itemCount;

  late bool _loop;

  late bool _autoplay;

  late int _autoplayDelay;

  late double _padding;

  late bool _outer;

  late double _radius;

  late double _viewportFraction;

  late SwiperLayout _layout;

  late int _currentIndex;

  late double _scale;

  late Axis _scrollDirection;

  late AxisDirection _axisDirection;

  late Curve _curve;

  late double _fade;

  late bool _autoplayDisableOnInteraction;

  late CustomLayoutOption customLayoutOption;

  late SwiperController _controller;

  TextEditingController numberController = TextEditingController();

  Widget _buildItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: Colors.green, width: 8.0),
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(ExampleCustom oldWidget) {
    customLayoutOption = CustomLayoutOption(startIndex: -1, stateCount: 3)
      ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
      ..addTranslate(
        [
          const Offset(-370.0, -40.0),
          Offset.zero,
          const Offset(370.0, -40.0),
        ],
      );
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    customLayoutOption = CustomLayoutOption(startIndex: -1, stateCount: 3)
      ..addRotate([-25.0 / 180, 0.0, 25.0 / 180])
      ..addTranslate(
        [
          const Offset(-350.0, 0.0),
          Offset.zero,
          const Offset(350.0, 0.0),
        ],
      );
    _fade = 1.0;
    _currentIndex = 0;
    _curve = Curves.ease;
    _scale = 0.8;
    _autoplay = false;
    _controller = SwiperController();
    _layout = SwiperLayout.TINDER;
    _radius = 10.0;
    _padding = 0.0;
    _loop = true;
    _itemCount = 4;
    _autoplayDelay = 3000;
    _viewportFraction = 0.8;
    _outer = false;
    _scrollDirection = Axis.horizontal;
    _axisDirection = AxisDirection.left;
    _autoplayDisableOnInteraction = false;
    super.initState();
  }

// maintain the index

  Widget buildSwiper() {
    return Swiper(
      backgroundColor: Colors.transparent,
      onTap: (index) {
        Navigator.of(context).push(MaterialPageRoute<Object>(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('New page'),
              ),
              body: Container(),
            );
          },
        ));
      },
      customLayoutOption: customLayoutOption,
      fade: _fade,
      index: _currentIndex,
      onIndexChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      curve: _curve,
      scale: _scale,
      itemWidth: MediaQuery.of(context).size.width,
      controller: _controller,
      layout: _layout,
      outer: _outer,
      itemHeight: 316.0,
      viewportFraction: _viewportFraction,
      autoplayDelay: _autoplayDelay,
      loop: _loop,
      autoplay: _autoplay,
      itemBuilder: _buildItem,
      itemCount: _itemCount,
      scrollDirection: _scrollDirection,
      axisDirection: _axisDirection,
      autoplayDisableOnInteraction: _autoplayDisableOnInteraction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverPersistentHeaderBuilderDelegate(
            maxExtentHeight: 300,
            minExtentHeight: 150,
            builder: (context, shrinkOffset, overlapsContent) {
              return Container(
                color: Colors.transparent,
                child: buildSwiper(),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.red,
            width: 400,
            height: 800,
          ),
        ),
      ],
    );
  }
}

class SliverPersistentHeaderBuilderDelegate
    extends SliverPersistentHeaderDelegate {
  final double maxExtentHeight;
  final double minExtentHeight;
  final Widget Function(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) builder;

  SliverPersistentHeaderBuilderDelegate({
    required this.maxExtentHeight,
    required this.minExtentHeight,
    required this.builder,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: builder(context, shrinkOffset, overlapsContent),
    );
  }

  @override
  double get maxExtent => maxExtentHeight;

  @override
  double get minExtent => minExtentHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
