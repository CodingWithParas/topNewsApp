import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:topnews/api_services.dart';  // Make sure to import your news service
import 'details_page.dart';  // Import the details page for navigation

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Article>> _articles;

  @override
  void initState() {
    super.initState();
    _articles = NewsService().fetchTopHeadlines('us');  // Fetch top headlines for the US
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Article>>(
        future: _articles,  // The future to be resolved
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No articles found"));
          }

          // Get the list of articles from the snapshot
          List<Article> articles = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Carousel Slider for Top Headlines
                CarouselSlider.builder(
                  itemCount: articles.length > 6 ? 6 : articles.length,  // Show top 6 headlines
                  itemBuilder: (context, index, realIndex) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to DetailsPage with article data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              title: articles[index].title,
                              description: articles[index].description,
                              urlToImage: articles[index].urlToImage,
                              url: articles[index].url,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              articles[index].urlToImage.isNotEmpty
                                  ? articles[index].urlToImage
                                  : 'https://via.placeholder.com/600x400.png', // Fallback image
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.black.withOpacity(0.6),
                            child: Text(
                              articles[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                  ),
                ),

                // Spacer between carousel and news list
                SizedBox(height: 20),

                // News Section Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        "Top News",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // News List View Below the Carousel
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: articles[index].urlToImage.isNotEmpty
                            ? Image.network(
                          articles[index].urlToImage,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          'https://via.placeholder.com/100', // Placeholder
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          articles[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          articles[index].description ?? 'No description available',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          // Navigate to DetailsPage with article data
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                title: articles[index].title,
                                description: articles[index].description,
                                urlToImage: articles[index].urlToImage,
                                url: articles[index].url,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
