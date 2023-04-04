------------ Create database ----------------
CREATE DATABASE my_catalog;

------------ Create music album table ----------------
CREATE TABLE music_albums (
  id SERIAL PRIMARY KEY,
  publish_date DATE NOT NULL DEFAULT DATE,
  on_spotify BOOLEAN,
  archived BOOLEAN,
  genre_id INT,
  label_id INT,
  author_id INT,
  CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
  CONSTRAINT fk_label FOREIGN KEY (label_id) REFERENCES label(label_id),
  CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors(author_id),
  PRIMARY KEY(id)
);

------------ Create genre table -------------------
CREATE TABLE genres (
  genre_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  PRIMARY KEY(genre_id)
);