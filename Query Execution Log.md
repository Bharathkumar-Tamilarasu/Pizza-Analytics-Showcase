# Pizza Analytics Showcase

## Query Execution Log

**Author**: Bharathkumar Tamilarasu <br />
**Email**: bharathkumar.t.17@gmail.com <br />
**Website**: https://bharathkumart17.wixsite.com/portfolio <br />
**LinkedIn**: https://www.linkedin.com/in/bharathkumar-tamilarasu-218429222/  <br />
##
### Breaking things down by Country

**1.**  What is the liklihood of dying if you contract covid (in India)?

````sql
SELECT LOCATION,DATE,TOTAL_CASES,
	TOTAL_DEATHS,
	(TOTAL_DEATHS * 1.0 / TOTAL_CASES * 1.0) * 100 AS DEATH_PERCENTAGE
FROM COVID_DEATHS
WHERE LOCATION = 'India'
	AND CONTINENT IS NOT NULL
ORDER BY 1,2 DESC
````

**Results: Latest 5 values**

| location | date       | total_cases | total_deaths | death_percentage |
|----------|------------|-------------|--------------|------------------|
| India    | 27-09-2023 | 44998525    | 532031       | 1.182329865      |
| India    | 26-09-2023 | 44998525    | 532031       | 1.182329865      |
| India    | 25-09-2023 | 44998525    | 532031       | 1.182329865      |
| India    | 24-09-2023 | 44998525    | 532031       | 1.182329865      |
| India    | 23-09-2023 | 44998463    | 532031       | 1.182331494      |

**2.**  What is the percentage of population infected with covid (in India)?

````sql
SELECT LOCATION,DATE,POPULATION,
	TOTAL_CASES,
	(TOTAL_CASES * 1.0 / POPULATION * 1.0) * 100 AS INFECTED_PERCENTAGE
FROM COVID_DEATHS
WHERE LOCATION = 'India'
	AND CONTINENT IS NOT NULL
ORDER BY 1,2 DESC
````

**Results: Latest 5 values**

| location | date       | population | total_cases | infected_percentage |
|----------|------------|------------|-------------|---------------------|
| India    | 27-09-2023 | 1417173120 | 44998525    | 3.175231337         |
| India    | 26-09-2023 | 1417173120 | 44998525    | 3.175231337         |
| India    | 25-09-2023 | 1417173120 | 44998525    | 3.175231337         |
| India    | 24-09-2023 | 1417173120 | 44998525    | 3.175231337         |
| India    | 23-09-2023 | 1417173120 | 44998463    | 3.175226962         |

**3.**  What are the top 10 countries with the highest infection rates compared to their populations?

````sql
SELECT LOCATION,
	POPULATION,
	MAX(TOTAL_CASES) AS HIGHEST_INFECTION_COUNT,
	MAX((TOTAL_CASES * 1.0 / POPULATION * 1.0) * 100) AS HIGHEST_INFECTED_PERCENTAGE
FROM COVID_DEATHS
WHERE CONTINENT IS NOT NULL
	AND TOTAL_DEATHS IS NOT NULL GROUP
	BY 1,2
ORDER BY 4 DESC
````

**Results:**

| location       | population | highest_infection_count | highest_infected_percentage |
|----------------|------------|-------------------------|-----------------------------|
| Cyprus         | 896007     | 660854                  | 73.75545057                 |
| San Marino     | 33690      | 24518                   | 72.77530424                 |
| Brunei         | 449002     | 311020                  | 69.2691792                  |
| Austria        | 8939617    | 6081287                 | 68.02625884                 |
| South Korea    | 51815808   | 34571873                | 66.72070616                 |
| Faeroe Islands | 53117      | 34658                   | 65.24841388                 |
| Slovenia       | 2119843    | 1344826                 | 63.43988682                 |
| Gibraltar      | 32677      | 20550                   | 62.88827004                 |
| Martinique     | 367512     | 230354                  | 62.67931387                 |
| Andorra        | 79843      | 48015                   | 60.13676841                 |

**4.**  What are the top 10 countries with the highest death count?

````sql
SELECT LOCATION,
	MAX(TOTAL_DEATHS) AS HIGHEST_DEATH_COUNT
FROM COVID_DEATHS
WHERE CONTINENT IS NOT NULL
	AND TOTAL_DEATHS IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
````

**Results:**

| location       | highest_death_count |
|----------------|---------------------|
| United States  | 1127152             |
| Brazil         | 704659              |
| India          | 532031              |
| Russia         | 400023              |
| Mexico         | 334586              |
| United Kingdom | 229307              |
| Peru           | 221465              |
| Italy          | 191469              |
| Germany        | 174979              |
| France         | 167985              |



**5.**  What is the number of people who have received at least one COVID vaccine (in India)?

````sql
SELECT DE.LOCATION,
	DE.DATE,
	DE.POPULATION,
	VA.NEW_VACCINATIONS AS DAILY_NEW_VACCINATIONS,
	SUM(VA.NEW_VACCINATIONS) OVER(PARTITION BY DE.LOCATION
		ORDER BY DE.LOCATION ASC,DE.DATE ASC) AS TOTAL_VACCINATIONS
FROM COVID_DEATHS DE
JOIN COVID_VACCINATIONS VA ON DE.LOCATION = VA.LOCATION
AND DE.DATE = VA.DATE
WHERE DE.CONTINENT IS NOT NULL
	AND DE.LOCATION = 'India'
ORDER BY 2 DESC
````

**Results: Latest 5 values**

| location | date       | population | daily_new_vaccinations | total_vaccinations |
|----------|------------|------------|------------------------|--------------------|
| India    | 27-09-2023 | 1417173120 | 119                    | 2112027222         |
| India    | 26-09-2023 | 1417173120 | 167                    | 2112027103         |
| India    | 25-09-2023 | 1417173120 | 67                     | 2112026936         |
| India    | 24-09-2023 | 1417173120 | 114                    | 2112026869         |
| India    | 23-09-2023 | 1417173120 | 157                    | 2112026755         |

**6.**  What is the percentage of the population that has received at least one COVID vaccine (in India)?

````sql
WITH POP_VAC_CTE (LOCATION,DATE,POPULATION, NEW_VACCINATIONS, TOTAL_VACCINATIONS) 
AS
	(
	SELECT DE.LOCATION,
		DE.DATE,
		DE.POPULATION,
		VA.NEW_VACCINATIONS AS DAILY_NEW_VACCINATIONS,
		SUM(VA.NEW_VACCINATIONS) OVER(PARTITION BY DE.LOCATION
			ORDER BY DE.LOCATION ASC,DE.DATE ASC) AS TOTAL_VACCINATIONS
	FROM COVID_DEATHS DE
	JOIN COVID_VACCINATIONS VA ON DE.LOCATION = VA.LOCATION
	AND DE.DATE = VA.DATE
	WHERE DE.CONTINENT IS NOT NULL
	)
		
SELECT *,(TOTAL_VACCINATIONS * 1.0 / POPULATION * 1.0) * 100 AS TOTAL_VACCINATIONS_PERCENTAGE
FROM POP_VAC_CTE
WHERE LOCATION = 'India'
ORDER BY 1,2 DESC
````

**Results: Latest 5 values**

| location | date       | population | new_vaccinations | total_vaccinations | total_vaccinations_percentage |
|----------|------------|------------|------------------|--------------------|-------------------------------|
| India    | 27-09-2023 | 1417173120 | 119              | 2112027222         | 149.0309964                   |
| India    | 26-09-2023 | 1417173120 | 167              | 2112027103         | 149.030988                    |
| India    | 25-09-2023 | 1417173120 | 67               | 2112026936         | 149.0309763                   |
| India    | 24-09-2023 | 1417173120 | 114              | 2112026869         | 149.0309715                   |
| India    | 23-09-2023 | 1417173120 | 157              | 2112026755         | 149.0309635                   |

### Breaking things down by Continent

**7.**  What is the total death count per continent?

````sql
SELECT CONTINENT,
	SUM(TOTAL_DEATHS) AS TOTAL_DEATHS
FROM COVID_DEATHS
WHERE CONTINENT IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
````

**Results:**

| continent     | total_deaths |
|---------------|--------------|
| Europe        | 1711185547   |
| North America | 1368907386   |
| Asia          | 1285867860   |
| South America | 1228855967   |
| Africa        | 226883410    |
| Oceania       | 13982259     |

### Global numbers

**8.**  What is the global total death count?

````sql
SELECT SUM(NEW_CASES) AS TOTAL_CASES,
	SUM(NEW_DEATHS) AS NEW_DEATHS,
	(SUM(NEW_DEATHS) * 1.0 / SUM(NEW_CASES) * 1.0) * 100 AS DEATH_PERCENTAGE
FROM COVID_DEATHS
WHERE CONTINENT IS NOT NULL
````

**Results:**

| total_cases | new_deaths | death_percentage |
|-------------|------------|------------------|
| 770955465   | 6965862    | 0.903536237      |
