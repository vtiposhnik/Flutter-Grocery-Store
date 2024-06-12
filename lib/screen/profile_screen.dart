import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late List<String> dateSplit;
  late String date;

  void _getLocaleDate() {
    dateSplit = _auth.currentUser!.metadata.creationTime.toString().split(' ');
    setState(() {
      date =
          _auth.currentUser!.metadata.creationTime.toString().split(' ').first;
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocaleDate();
    print('${_auth.currentUser!.metadata.creationTime} INSTANCE USER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green.shade200,
                  child: Image.asset('./assets/icons/user_profile.png')),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Text(
                  '${context.watch<UserProvider>().user!['username']}, you are with us since: ${_auth.currentUser!.metadata.creationTime.toString().split(' ').first}',
                  style: TextStyle(fontSize: 19),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'My Purchases',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildPurchaseList(),
              SizedBox(height: 20),
              Text(
                'My Coupons',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildCouponList(),
              SizedBox(height: 20),
              _buildRateAppSection(),
              SizedBox(height: 20),
              _buildSocialMediaLinks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPurchaseList() {
    // Replace with your actual data fetching logic
    List<String> purchases = [];

    if (purchases.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: purchases.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.green.shade100,
            child: ListTile(
              title: Text(purchases[index]),
            ),
          );
        },
      );
    } else {
      return Card(
        color: Colors.white,
        child: ListTile(
          title: Text('No Purchases yet...', textAlign: TextAlign.center),
        ),
      );
    }
  }

  Widget _buildCouponList() {
    List<String> coupons = [];

    if (coupons.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.green.shade100,
            child: ListTile(
              title: Text(coupons[index]),
            ),
          );
        },
      );
    } else {
      return Card(
        color: Colors.white,
        child: ListTile(
          title: Text('No Coupons yet...', textAlign: TextAlign.center),
        ),
      );
    }
  }

  Widget _buildRateAppSection() {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.green.shade200,
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Rate the App',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  Icons.star_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Handle rating logic
                },
              );
            }),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(Colors.white)),
            onPressed: () {
              // Handle rate the app button press
            },
            child: Text(
              'Submit Rating'
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Follow Us',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.facebook),
              onPressed: () {
                // Handle Facebook link press
              },
            ),
            IconButton(
              icon: Icon(Icons.live_tv_rounded),
              onPressed: () {
                // Handle Twitter link press
              },
            ),
            IconButton(
              icon: Icon(Icons.tiktok_rounded),
              onPressed: () {
                // Handle Instagram link press
              },
            ),
          ],
        ),
      ],
    );
  }
}
