CREATE DATABASE IF NOT EXISTS netflix;

USE netflix;

CREATE TABLE IF NOT EXISTS show_types
       ( type_id INT(11) NOT NULL AUTO_INCREMENT
       , type_name VARCHAR(255) NOT NULL
       , PRIMARY KEY (type_id)
       , INDEX (type_name)
       );

CREATE TABLE IF NOT EXISTS directors
       ( director_id INT(11) NOT NULL AUTO_INCREMENT
       , director_name VARCHAR(255) NOT NULL
       , PRIMARY KEY (director_id)
       , INDEX (director_name)
       );

CREATE TABLE IF NOT EXISTS actors
       ( actor_id INT(11) NOT NULL AUTO_INCREMENT
       , actor_name VARCHAR(255) NOT NULL
       , PRIMARY KEY (actor_id)
       , INDEX (actor_name)
       );

CREATE TABLE IF NOT EXISTS countries
       ( country_id INT(11) NOT NULL AUTO_INCREMENT
       , country_name VARCHAR(255) NOT NULL
       , PRIMARY KEY (country_id)
       , INDEX (country_name)
       );

CREATE TABLE IF NOT EXISTS ratings
       ( rating_id INT(11) NOT NULL AUTO_INCREMENT
       , rating_name VARCHAR(255) NOT NULL
       , PRIMARY KEY (rating_id)
       , INDEX (rating_name)
       );

CREATE TABLE IF NOT EXISTS categories
       ( category_id INT(11) NOT NULL AUTO_INCREMENT
       , category_name VARCHAR(255) NOT NULL
       , PRIMARY KEY (category_id)
       , INDEX (category_name)
       );

CREATE TABLE IF NOT EXISTS shows
       ( show_id VARCHAR(255) NOT NULL
       , type_id INT(11) NOT NULL
       , title VARCHAR(255) NOT NULL
       , country_id INT(11) NOT NULL
       , date_added DATE NOT NULL
       , release_year INT(11) NOT NULL
       , rating_id INT(11) NOT NULL
       , duration VARCHAR(255) NOT NULL
       , description VARCHAR(1023) NOT NULL
       , PRIMARY KEY (show_id)
       , FOREIGN KEY (type_id) REFERENCES show_types (type_id)
       , FOREIGN KEY (country_id) REFERENCES countries (country_id)
       , FOREIGN KEY (rating_id) REFERENCES ratings (rating_id)
       , INDEX (title, release_year)
       );

CREATE TABLE IF NOT EXISTS actor_show
       ( actor_id INT(11) NOT NULL
       , show_id VARCHAR(255) NOT NULL
       , FOREIGN KEY (actor_id) REFERENCES actors (actor_id)
       , FOREIGN KEY (show_id) REFERENCES shows (show_id)
       );

CREATE TABLE IF NOT EXISTS director_show
       ( director_id INT(11) NOT NULL
       , show_id VARCHAR(255) NOT NULL
       , FOREIGN KEY (director_id) REFERENCES directors (director_id)
       , FOREIGN KEY (show_id) REFERENCES shows (show_id)
       );

CREATE TABLE IF NOT EXISTS category_show
       ( category_id INT(11) NOT NULL
       , show_id VARCHAR(255) NOT NULL
       , FOREIGN KEY (category_id) REFERENCES categories (category_id)
       , FOREIGN KEY (show_id) REFERENCES shows (show_id)
       );
