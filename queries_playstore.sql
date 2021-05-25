--Find the app with an ID of 1880--
SELECT * FROM analytics WHERE id = 1880;

--Find the ID and app name for all apps that were last updated on August 01, 2018.--
SELECT id, app_name FROM analytics WHERE last_updated = '2018-08-01';

--Count the number of apps in each category, e.g. “Family | 1972”.--
SELECT COUNT(*) as Family FROM analytics GROUP BY category;

--Find the top 5 most-reviewed apps and the number of reviews for each.--
SELECT app_name, reviews FROM analytics ORDER BY reviews DESC LIMIT 5;

--Find the app that has the most reviews with a rating greater than equal to 4.8.--
 SELECT app_name, rating, reviews FROM analytics WHERE rating > 4.8 and reviews > (SELECT AVG(reviews) FROM analytics);

--Find the average rating for each category ordered by the highest rated to lowest rated.--
SELECT COUNT(*) , AVG(rating) as average_rating FROM analytics GROUP by category ORDER BY average_rating DESC;

--Find the name, price, and rating of the most expensive app with a rating that’s less than 3.--
SELECT app_name, price, rating FROM analytics WHERE rating < 3 AND price BETWEEN (SELECT AVG(price) FROM analytics) AND (SELECT MAX(price) FROM analytics) ORDER BY price DESC;

--Find all apps with a min install not exceeding 50, that have a rating. Order your results by highest rated first.--
SELECT * FROM analytics WHERE min_installs <= 50 AND rating > 0 ORDER BY rating DESC;

--Find the names of all apps that are rated less than 3 with at least 10000 reviews.--
SELECT app_name FROM analytics WHERE reviews > 10000 AND rating < 3;

--Find the top 10 most-reviewed apps that cost between 10 cents and a dollar.--
SELECT * FROM analytics WHERE price BETWEEN .1 and 1.00 ORDER BY reviews DESC;

--Find the most out of date app.--
SELECT app_name, last_updated FROM analytics ORDER BY last_updated;

--Find the most expensive app--
SELECT app_name, price FROM analytics ORDER BY price DESC;
SELECT MAX(price) as price, category FROM analytics GROUP BY category HAVING MAX(price) > 70 ORDER BY price DESC;

--Count all the reviews in the Google Play Store--
SELECT SUM(reviews) as total_reviews FROM analytics;

--Find all the categories that have more than 300 apps in them.--
SELECT COUNT(*) as apps_total_in_category, category FROM analytics GROUP BY category HAVING COUNT(*) > 300;

--Find the app that has the highest proportion of min_installs to reviews, among apps that have been installed at least 100,000 times.-- 
--Display the name of the app along with the number of reviews, the min_installs, and the proportion.--
SELECT app_name, reviews, min_installs, (min_installs / reviews) as proportion FROM analytics WHERE min_installs >= 100000 ORDER BY proportion DESC;


-- Find the name and rating of the top rated apps in each category, among apps that have been installed at least 50,000 times--
SELECT app_name, rating, category FROM analytics A JOIN (SELECT MAX(rating) as max_rating, category as max_category FROM analytics GROUP BY category)B ON A.rating = B.max_rating AND A.category = B.max_category AND A.min_installs > 50000;

--Find all the apps that have a name similar to “facebook”.--
SELECT app_name FROM analytics WHERE app_name ILIKE 'face%';

-- Find all the apps that have more than 1 genre.--
SELECT * FROM analytics WHERE cardinality(genres) > 1;

--Find all the apps that have education as one of their genres.--
SELECT * FROM analytics WHERE ARRAY_TO_STRING(genres, ' ') ILIKE '%educatio_';

