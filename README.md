# VideoGameGoldenAge
When was the Golden Age of Video Games? | SQL Analysis

In this project I analyzed video game critic and user scores as well as sales data for the over 13 000 video games released between 1977 and 2020. 

The purpose of this project is to find the a golden year of video games by identifying release years that users and critics liked best, and explore the business side of gaming by looking at game sales data.

This project was developed in SQL Server.

Tables:
game_sales
column	        type	meaning
Game	        varchar	Name of the video game
Platform	    varchar	Gaming platform
Publisher	    varchar	Game publisher
Developer	    varchar	Game developer
Games_Sold	    float	Number of copies sold (millions)
Release_Year	int	    Release year

game_reviews
column	        type	meaning
game	        varchar	Name of the video game
critic_score	float	Critic score according to Metacritic
user_score	    float	User score according to Metacritic


Dataset: https://www.kaggle.com/datasets/holmjason2/videogamedata