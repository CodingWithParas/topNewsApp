import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final String urlToImage;
  final String url;

  const DetailsPage({
    Key? key,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show image (if available)
              urlToImage.isNotEmpty
                  ? Image.network(urlToImage)
                  : Placeholder(fallbackHeight: 200),  // Fallback image if no URL

              SizedBox(height: 20),

              // Title
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              // Description
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),

              // Link to the full article
              if (url.isNotEmpty)
                GestureDetector(
                  onTap: () => _launchURL(url),  // Open the URL in browser
                  child: Text(
                    "Read full article",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Launch the URL in a web browser
  void _launchURL(String url) async {
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
