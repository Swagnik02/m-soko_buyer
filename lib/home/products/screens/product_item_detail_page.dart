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
    // Implement your Overview section here
    return Center(child: Text("Overview Section"));
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
