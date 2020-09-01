import 'package:flutter/material.dart';
import 'package:imaginemosTest/blocs/customProvider.dart';
import 'package:imaginemosTest/components/rating.dart';
import 'package:imaginemosTest/layouts/details.dart';
import 'package:imaginemosTest/models/movie.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Movie movie = Movie();
    final myThemeBloc =
        context.dependOnInheritedWidgetOfExactType<CustomProvider>();
    return new Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: new Stack(
          children: [
            top(height, context),
            new Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 5, top: 30),
                child: StreamBuilder(
                    stream: myThemeBloc.myThemeBloc.currentTheme,
                    builder: (context, snapshot) {
                      return new IconButton(
                          icon: Icon(
                            Icons.brightness_medium,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (snapshot.data == true) {
                              myThemeBloc.myThemeBloc.changeTheme(false);
                            } else {
                              myThemeBloc.myThemeBloc.changeTheme(true);
                            }
                          });
                    }),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                  height: height * 0.7,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Theme.of(context).backgroundColor),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Text(
                              'RECOMENDED FOR YOU',
                              style: new TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            new Text(
                              'See all',
                              style: new TextStyle(
                                  fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                        buildList(movie, movie.getRecommendation()),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Text(
                              'TOP RATED',
                              style: new TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            new Container(),
                            new Text(
                              'See all',
                              style: new TextStyle(
                                  fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                        buildList(movie, movie.getTopRated()),
                      ],
                    ),
                  )),
            )
          ],
        ));
  }

  //Widget para el top de la pagina principal

  Container top(double height, BuildContext context) {
    return new Container(
      height: height * 0.35,
      decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new Text(
              'Hello, what do you want to watch?',
              style: new TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 35,
              child: TextField(
                style: new TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: new InputDecoration(
                    filled: true,
                    fillColor: Color(0xffffffff).withOpacity(0.6),
                    prefixIcon: IconButton(
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: new Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        }),
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30)),
                    contentPadding: EdgeInsets.only(
                      left: 15,
                    ),
                    hintText: "Search",
                    hintStyle: new TextStyle(
                        color: Color(0xffffffff).withOpacity(0.8))),
              ),
            )
          ],
        ),
      ),
    );
  }

  // widget que se encarga  de construir los listviews a partir del future builder
  //tomando como parametros una instancia de Movie y la funcion a ejecutar ya sea TopRated o Recommendation
  Container buildList(Movie movie, Future func) {
    return new Container(
      height: 170,
      child: new FutureBuilder(
        future: func,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "ERROR: " + snapshot.error.toString(),
              ),
            );
          } else if (snapshot.data.length == 0) {
            return Center(
              child: Text(
                "Api error",
              ),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Movie currentMovie = Movie.fromMap(snapshot.data[index]);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Details(selectedMovie: currentMovie)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: new Container(
                      height: 170,
                      width: 110,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Container(
                            height: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: new DecorationImage(
                                    image: NetworkImage(
                                      currentMovie.poster_path != null
                                          ? 'http://image.tmdb.org/t/p/w185/${currentMovie.poster_path}'
                                          : 'https://images-na.ssl-images-amazon.com/images/I/31yW7R1ccdL._AC_SY400_.jpg',
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          new Text(
                            '${currentMovie.title}',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            maxLines: 1,
                          ),
                          Rating(
                            rating: currentMovie.vote_average / 2,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
