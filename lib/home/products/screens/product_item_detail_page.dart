import 'package:flutter/material.dart';
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
  int _selectedSectionIndex = 0; // Default selected index

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
          title: Text("Product Details"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: "Overview"),
                Tab(text: "Details"),
                Tab(text: "Similar"),
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
            ? null // Hide bottom bar for "Similar" section
            : BottomAppBar(
                child: Container(
                  height: 56.0,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to ChatNow page
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatNowPage()));
                        },
                        child: Text("ChatNow"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Enquiry page
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => EnquiryPage()));
                        },
                        child: Text("Enquiry"),
                      ),
                    ],
                  ),
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
        return Container(); // Placeholder, add appropriate sections
    }
  }

  Widget _buildOverviewSection() {
    // // Assuming `ProductModel` has a property `photos` that is a list of image URLs.
    // List<String> photos = widget.productModel.photos;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Row with Discount Percentage and Share/Bookmark buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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

          // // Image Carousel with Timeline
          // Container(
          //   height: 200.0, // Adjust height as needed
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: photos.length,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           // Change the selected photo in the carousel
          //           // You can implement this based on your carousel widget
          //         },
          //         child: Container(
          //           margin: EdgeInsets.all(8.0),
          //           width: 100.0, // Adjust width as needed
          //           decoration: BoxDecoration(
          //             border: Border.all(
          //               color: index == 0
          //                   ? Colors.blue // Highlight the selected photo
          //                   : Colors.transparent,
          //             ),
          //           ),
          //           child: Image.network(
          //             photos[index],
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),

          // Price Tag
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Text(
              "\$${widget.productModel.price}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),

          // Min and Max Order
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Min Order: ${widget.productModel.itemOrderCount}"),
                Text("Max Order: ${widget.productModel.itemOrderCount}"),
              ],
            ),
          ),

          // Product Name
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              widget.productModel.name ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
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
}
