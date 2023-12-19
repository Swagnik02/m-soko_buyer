import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/product_model.dart';

class ProductItemDetailPage extends StatefulWidget {
  final String pId;
  final ProductModel productModel;

  const ProductItemDetailPage({
    Key? key,
    required this.pId,
    required this.productModel,
  }) : super(key: key);

  @override
  State<ProductItemDetailPage> createState() => ProductItemDetailPageState();
}

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
            preferredSize: Size.fromHeight(48.0),
            child: CustomTabBar(
              color: Colors.white,
              controller: _tabController,
              tabs: [
                _customTab('assets/icons/overview_icon.png', 'Overview'),
                _customTab('assets/icons/details_icon.png', 'Details'),
                _customTab('assets/icons/similar_icon.png', 'Similar'),
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
                        child: Center(child: Text('Chat Now')),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.amber[500],
                        child: Center(child: Text('Send Inquiry')),
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

  int selectedImageIndex = 0;

  Widget _buildOverviewSection() {
    // Assuming `ProductModel` has a property `itemImages` that is a map of image URLs.
    Map<String, String>? photos = widget.productModel.itemImages;

    // Store the selected index

    // Create a list of Image.network widgets for preloading
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Row with Discount Percentage and Share/Bookmark buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.productModel.itemDiscountPercentage}% Discount",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        // Handle share button click
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.bookmark),
                      onPressed: () {
                        // Handle bookmark button click
                      },
                    ),
                  ],
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
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedImageIndex == index
                            ? Colors.blue
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
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${GlobalUtil.currencySymbol}${widget.productModel.price}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Min Order: ${widget.productModel.itemOrderCount}"),
                    Text("Max Order: ${widget.productModel.itemOrderCount}"),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.productModel.name ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    // Implement your Details section here
    return Center(child: Text("Details Section"));
  }

  Widget _buildSimilarSection() {
    // Implement your Similar section here
    return Center(child: Text("Similar Section"));
  }

  Tab _customTab(String iconUrl, String tabName) {
    return Tab(
      child: Container(
        child: Row(
          children: [
            Image.asset(iconUrl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(tabName),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;
  final TabController controller;
  final List<Tab> tabs;

  const CustomTabBar({
    Key? key,
    required this.color,
    required this.controller,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: TabBar(
        controller: controller,
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
