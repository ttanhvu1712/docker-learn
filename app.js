const express = require("express");
const bodyParser = require("body-parser");
const axios = require("axios").default;
const mongoose = require("mongoose");

const Favorite = require("./models/favorite");

const app = express();

app.use(bodyParser.json());

app.get("/favorites", async (req, res) => {
  const favorites = await Favorite.find();
  res.status(200).json({
    favorites: favorites,
  });
});

app.post("/favorites", async (req, res) => {
  const favName = req.body.name;
  const favType = req.body.type;
  const favUrl = req.body.url;

  try {
    if (favType !== "movie" && favType !== "character") {
      throw new Error('"type" should be "movie" or "character"!');
    }
    const existingFav = await Favorite.findOne({ name: favName });
    if (existingFav) {
      throw new Error("Favorite exists already!");
    }
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }

  const favorite = new Favorite({
    name: favName,
    type: favType,
    url: favUrl,
  });

  try {
    await favorite.save();
    res
      .status(201)
      .json({ message: "Favorite saved!", favorite: favorite.toObject() });
  } catch (error) {
    res.status(500).json({ message: "Something went wrong." });
  }
});

app.get("/movies", async (req, res) => {
  try {
    const response = await axios.get("https://www.swapi.tech/api/films");
    res.status(200).json({ movies: response.data });
  } catch (error) {
    res.status(500).json({ message: "Something went wrong." });
  }
});

app.get("/people", async (req, res) => {
  try {
    const response = await axios.get("https://www.swapi.tech/api/people");
    res.status(200).json({ people: response.data });
  } catch (error) {
    res.status(500).json({ message: "Something went wrong." });
  }
});

// To run mongoose, follow the instruction in https://www.mongodb.com/docs/manual/tutorial/install-mongodb-community-with-docker/ to run the mongo docker container first
mongoose.connect(
  // "mongodb://localhost:27017/swfavorites", // this url for running app on local machine
  // "mongodb://host.docker.internal:27017/swfavorites", // this url for running app on docker container that call to localhost endpoint in local machine
  // "mongodb://172.17.0.2:27017/swfavorites", // this url for running app on docker container that call to ip address of mongo container
  "mongodb://mongodb:27017/swfavorites", // this url for running app on docker container that call to domain of mongo container inside of created docket network, see how create and use network in README.
  { useNewUrlParser: true },
  (err) => {
    if (err) {
      console.log(err);
    } else {
      app.listen(3000);
    }
  }
);
