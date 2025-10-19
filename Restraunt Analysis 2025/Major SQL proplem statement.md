**SQL Problem and Solution Examples**--



Here are some examples of the types of problems and solutions you will find in the generated SQL file:



**Problem**: Identify the most common transportation method used by consumers to get to restaurants.

**Solution**: A query that groups consumers by their Transportation\_Method and counts the occurrences to find the most frequent one.



**Problem**: Find restaurants that have a high food rating but a low service rating.

**Solution**: A query that joins the ratings and restaurants tables, then uses a HAVING clause to filter for restaurants with an average Food\_Rating greater than 1.5 and an average Service\_Rating less than 1.0.



**Problem**: Find consumers who have rated more than one type of cuisine.

**Solution**: A query that joins consumers, ratings, and restaurant\_cuisines tables and uses COUNT(DISTINCT rc.Cuisine) to count the number of unique cuisines rated by each consumer, filtering for those with a count greater than one.



These queries, along with the other 12 in the file, will provide a robust foundation for the "Restaurant Analysis 2025" project.

