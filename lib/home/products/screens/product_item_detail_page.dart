import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/products/widgets/product_detail_widgets.dart';
import 'package:m_soko/models/product_model.dart';

class ProductItemDetailPage extends StatefulWidget {
  final String pId;
  final ProductModel productModel;

  const ProductItemDetailPage({
    super.key,
    required this.pId,
    required this.productModel,
  });

  @override
  State<ProductItemDetailPage> createState() => ProductItemDetailPageState();
}

int selectedImageIndex = 0;

class ProductItemDetailPageState extends State<ProductItemDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedSectionIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _selectedSectionIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.blue700,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: CustomTabBar(
              color: Colors.white,
              controller: _tabController,
              tabs: [
                customTab('assets/icons/overview_icon.png', 'Overview'),
                customTab('assets/icons/details_icon.png', 'Details'),
                customTab('assets/icons/similar_icon.png', 'Similar'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildSectionBody(0),
            _buildSectionBody(1),
            _buildSectionBody(2),
          ],
        ),
        bottomNavigationBar: _selectedSectionIndex == 2
            ? null
            : BottomAppBar(
                elevation: 0,
                clipBehavior: Clip.antiAlias,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: const Center(child: Text('Chat Now')),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.amber[500],
                        child: const Center(child: Text('Send Inquiry')),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSectionBody(int index) {
    switch (index) {
      case 0:
        return _buildOverviewSection();
      case 1:
        return _buildDetailsSection();
      case 2:
        return _buildSimilarSection();
      default:
        return Container();
    }
  }

  Widget _buildOverviewSection() {
    Map<String, String>? photos = widget.productModel.itemImages;
    List<Widget> imageWidgets = [];

    if (photos != null) {
      photos.forEach((imageKey, imageUrl) {
        imageWidgets.add(Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ));
      });
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Row with Discount Percentage and Share/Bookmark buttons
                Container(
                  padding: const EdgeInsets.only(top: 5, left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // discount tag
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ColorConstants.green50,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "${widget.productModel.itemDiscountPercentage?.toInt()}% off",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.green900,
                          ),
                        ),
                      ),
                      // ShareButton and bookmark button
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: InkWell(
                                onTap: () {
                                  // Handle share button click
                                },
                                child: const Icon(
                                  Icons.share_outlined,
                                  size: 18,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: InkWell(
                                onTap: () {
                                  // Handle bookmark button click
                                },
                                child: const Icon(
                                  Icons.bookmark_border_rounded,
                                  // size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Large Image Container using PageView
                Container(
                  height: 280,
                  // margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: PageView.builder(
                    itemCount: photos != null ? photos.length : 0,
                    onPageChanged: (index) {
                      setState(() {
                        selectedImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      String imageKey = photos!.keys.elementAt(index);
                      return Image.network(
                        photos[imageKey]!,
                        fit: BoxFit.fitHeight,
                      );
                    },
                  ),
                ),
                // Image Timeline
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 60.0,
                  child: ListView.builder(
                    primary: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: photos != null ? photos.length : 0,
                    itemBuilder: (context, index) {
                      String imageKey = photos!.keys.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          // Fluttertoast.showToast(msg: index.toString());

                          setState(() {
                            selectedImageIndex = index;
                          });
                        },
                        child: Container(
                          width: 60.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: selectedImageIndex == index
                                  ? ColorConstants.yellow200
                                  : Colors.transparent,
                            ),
                          ),
                          child: Image.network(
                            photos[imageKey]!,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Price Tag, Min and Max Order, Product Name (Remaining details)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  // color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${GlobalUtil.currencySymbol}${widget.productModel.price}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.,
                        children: [
                          Text(
                            "Min Order: ${widget.productModel.itemOrderCount} pieces",
                            style: const TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Text(
                            "< ${widget.productModel.itemOrderCount} pieces",
                            style: const TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.productModel.name ?? '',
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                      // ordercount

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: RichText(
                          text: TextSpan(
                            text:
                                '${widget.productModel.itemOrderCount} orders | See Store Reviews',
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Fluttertoast.showToast(msg: 'ratingPage');
                              },
                          ),
                        ),
                      ),

                      // Ratings
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: PannableRatingBar(
                          rate: widget.productModel.itemAvgRating ?? 0,
                          items: List.generate(
                              5,
                              (index) => const RatingWidget(
                                    selectedColor: Color(0xFFFFCE31),
                                    unSelectedColor: Colors.grey,
                                    child: Icon(
                                      Icons.star,
                                      size: 20,
                                    ),
                                  )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _tabController.animateTo(1);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              height: 56.1,
              color: ColorConstants.blue50,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('All Details'),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8.0),
            child: Text(
              'Highlights',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
          ),
          if (widget.productModel.mainCategory == 'Mobiles')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('RAM | ROM'),
                Text('Processor'),
                Text('Rear Camera'),
                Text('Front Camera'),
                Text('Display'),
                Text('Battery'),

                // Other Details

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Other Details',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      mobileOtherDetailsRow('Network Type', '4', 'G'),
                      mobileOtherDetailsRow('Sim Type', 'Dual', 'Sim'),
                      mobileOtherDetailsRow('Expandable Storage', 'No', ''),
                      mobileOtherDetailsRow('Audio Jack', 'No', ''),
                      mobileOtherDetailsRow('Quick Charging', 'No', ''),
                      mobileOtherDetailsRow(
                          'In The Box',
                          'USB Cable, Adaptor, cable, Mobile Phone, Ejection Pin, Manual',
                          ''),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSimilarSection() {
    // Implement your Similar section here
    return const Center(child: Text("Similar Section"));
  }
}
