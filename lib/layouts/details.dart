import 'package:flutter/material.dart';
import 'package:imaginemosTest/components/rating.dart';
import 'package:imaginemosTest/models/credits.dart';
import 'package:imaginemosTest/models/movie.dart';

class Details extends StatefulWidget {
  final Movie selectedMovie;
  Details({Key key, @required this.selectedMovie}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState(selectedMovie);
}

class _DetailsState extends State<Details> {
  Movie selectedMovie;
  _DetailsState(this.selectedMovie);

  Credits credits = new Credits();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.favorite_border), onPressed: (() {}))
        ],
      ),
      body: new Stack(
        children: [
          new Container(
            height: height * 0.4,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: new DecorationImage(
                  fit: selectedMovie.backdrop_path != null
                      ? BoxFit.cover
                      : BoxFit.contain,
                  image: NetworkImage(
                    selectedMovie.backdrop_path != null
                        ? 'http://image.tmdb.org/t/p/w500/${selectedMovie.backdrop_path}'
                        : 'https://images-na.ssl-images-amazon.com/images/I/31yW7R1ccdL._AC_SY400_.jpg',
                  ),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: new Container(
              height: height * 0.6,
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    new Row(
                      children: [
                        Flexible(
                          child: new Text(
                            selectedMovie.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {},
                            child: new Text(
                              'WATCH NOW',
                              style: new TextStyle(color: Colors.white),
                            )),
                        new Rating(
                          rating: selectedMovie.vote_average / 2,
                        )
                      ],
                    ),
                    new Text(
                      selectedMovie.overview,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(color: Colors.white70),
                    ),
                    centerDetails(),
                    bottomDetails(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget que se encarga de construir la informacion de los actores de la pelicula
  Container centerDetails() {
    return new Container(
      height: 80,
      child: new FutureBuilder(
        future: credits.getCredits(selectedMovie.id),
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
                Credits currentCredit = Credits.fromMap(snapshot.data[index]);
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: new Container(
                    height: 80,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(currentCredit
                                      .profile_path !=
                                  null
                              ? 'http://image.tmdb.org/t/p/w500/${currentCredit.profile_path}'
                              : 'https://images-na.ssl-images-amazon.com/images/I/31yW7R1ccdL._AC_SY400_.jpg'),
                          backgroundColor: Colors.transparent,
                        ),
                        new Text(
                          '${currentCredit.name}',
                          textAlign: TextAlign.start,
                          style: new TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          maxLines: 2,
                        ),
                      ],
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

  // widget que se encarga de construir la informacion de fondo de los detalles
  // Estudio, Genero, Fecha de lanzamiento

  FutureBuilder bottomDetails() {
    return new FutureBuilder(
      future: credits.getDetails(selectedMovie.id),
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
          return new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Row(
                children: [
                  new Text(
                    "Studio",
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  new Text(
                    snapshot.data['production_companies'].length > 0
                        ? snapshot.data['production_companies'][0]["name"] + '.'
                        : '',
                    style: new TextStyle(color: Colors.white70),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              new Row(
                children: [
                  new Text(
                    "Genre",
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  new Text(
                    snapshot.data['genres'].length > 0
                        ? snapshot.data['genres'][0]["name"] + '.'
                        : '',
                    style: new TextStyle(color: Colors.white70),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              new Row(
                children: [
                  new Text(
                    "Release",
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  new Text(
                    snapshot.data['release_date'],
                    style: new TextStyle(color: Colors.white70),
                  )
                ],
              )
            ],
          );
        }
      },
    );
  }
}
