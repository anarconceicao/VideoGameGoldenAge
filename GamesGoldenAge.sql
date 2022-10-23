-- Select all information for the top 10 best-selling games
SELECT TOP(10) * 
FROM [dbo].[game_sales]
ORDER BY [Games_Sold] DESC

-- Result: The best-selling video games were released between 1985 to 2017


-- Top 10 year and average critic score for each year, grouped by release year and ordering from highest to lowest avg_critic_score
SELECT TOP(10) game_sales.Release_Year, ROUND(AVG(game_reviews.Critic_Score),2) AS Average_Critic_Score
FROM game_sales
INNER JOIN game_reviews ON game_reviews.Game = game_sales.Game
GROUP BY game_sales.Release_Year
ORDER BY AVG(game_reviews.Critic_Score) DESC

-- Result: The year of 1984 recived on average higher critic score (9.5)


-- Count of games released in each year and returning the years that have more than four reviewed games
SELECT TOP(10) game_sales.Release_Year, ROUND(AVG(game_reviews.Critic_Score),2) AS Average_Critic_Score, COUNT(game_sales.Games_Sold) AS Num_Games
FROM game_sales
INNER JOIN game_reviews ON game_reviews.Game = game_sales.Game
GROUP BY game_sales.Release_Year
HAVING COUNT(game_sales.Games_Sold) > 4
ORDER BY AVG(game_reviews.Critic_Score) DESC

-- Result: Of the top 10 years with the average higher critic score, 1994, with 8.72 of avg critic score, was the year with most games released (104) 


-- Top 10 year and average user score for each year, grouped by release year and ordering from highest to lowest avg_user_score
SELECT TOP(10) game_sales.Release_Year, ROUND(AVG(game_reviews.User_Score),2) AS Average_User_Score, COUNT(game_sales.Games_Sold) AS Num_Games
FROM game_sales
INNER JOIN game_reviews
ON game_reviews.Game = game_sales.Game
GROUP BY game_sales.Release_Year
HAVING COUNT(game_sales.Games_Sold) > 4
ORDER BY AVG(game_reviews.User_Score) DESC

-- Result: To the users the year of 1993 was, on average (9.5), the year with the best video games


-- Create 2 new tables: one with top years with higher CRITIC score on avg with more than 4 games and other with higher USER score on avg with more than 4 games
SELECT TOP(10) game_sales.Release_Year, ROUND(AVG(game_reviews.User_Score),2) AS Average_User_Score, COUNT(game_sales.Games_Sold) AS Num_Games
INTO top_user_years_more_than_four_games
FROM game_sales
INNER JOIN game_reviews
ON game_reviews.Game = game_sales.Game
GROUP BY game_sales.Release_Year
HAVING COUNT(game_sales.Games_Sold) > 4
ORDER BY AVG(game_reviews.User_Score) DESC

SELECT TOP(10) game_sales.Release_Year, ROUND(AVG(game_reviews.Critic_Score),2) AS Average_Critic_Score, COUNT(game_sales.Games_Sold) AS Num_Games
INTO top_critic_years_more_than_four_games
FROM game_sales
INNER JOIN game_reviews ON game_reviews.Game = game_sales.Game
GROUP BY game_sales.Release_Year
HAVING COUNT(game_sales.Games_Sold) > 4
ORDER BY AVG(game_reviews.Critic_Score) DESC


-- Years that both players and critics loved
SELECT Release_Year
FROM top_critic_years_more_than_four_games
INTERSECT
SELECT Release_Year
FROM top_user_years_more_than_four_games

-- Result: 1990,1991,1993 and 1994 were the years that both users and critics agreed were in the top ten 


-- Total sum of games of the years were both users and critics agreed were in the top ten 
SELECT Release_Year, SUM(Games_Sold) AS total_games_sold
FROM game_sales

WHERE Release_Year 
IN 
	(SELECT Release_Year
	FROM top_critic_years_more_than_four_games
	INTERSECT
	SELECT Release_Year
	FROM top_user_years_more_than_four_games)

GROUP BY Release_Year
ORDER BY SUM(Games_Sold) DESC

-- Final Thoughts: The year 1993 saw around 64 million copies sold and critics and users agree that it was one of the top ten years.



