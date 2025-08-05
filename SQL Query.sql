	USE Absenteeism_Work;

	SELECT * FROM Absenteeism_at_work;
	SELECT * FROM compensation;
	SELECT * FROM Reasons;

	-- Joining All Table Using Left Join (Absenteeism_at_work a)
	SELECT * FROM Absenteeism_at_work a
	LEFT JOIN compensation b 
	ON a.ID = b.ID
	LEFT JOIN Reasons c 
	ON a.Reason_for_absence = c.Number;


	-- TASK 1 : Finding the healthiest employees	 
	SELECT * FROM Absenteeism_at_work
	WHERE Social_drinker = 0 and Social_smoker = 0 and Body_mass_index < 25;


	-- TASK 2 : Finding eligble non-smokers employees for compesations 
	SELECT 
	ID, 
	Social_smoker,
	Absenteeism_time_in_hours,
	Work_load_Average_day,
	Body_mass_index
	FROM Absenteeism_at_work
	WHERE Social_smoker = 0;

	--TASK 3 : Finding compesation increase (/people) for non smokers with budget of $1.500.000(million)
	SELECT 
	ID, 
	Social_smoker,
	Absenteeism_time_in_hours,
	Work_load_Average_day,
	Body_mass_index,
	ROUND(1500000 / (SELECT COUNT(*) FROM Absenteeism_at_work WHERE Social_smoker = 0), 2) AS [Compesation Increase]
	FROM Absenteeism_at_work
	WHERE Social_smoker = 0;


	-- TASK 4 : Make a query to preparing data for dashboard creation in PowerBI
	--Indonesia Season
	SELECT 
	a.ID,
	c.Number,
	Month_of_absence,
	Body_mass_index,
	CASE WHEN Body_mass_index < 18.5 then 'Underweight'
		WHEN Body_mass_index between 18.5 and 24.9 then 'Normal'
		WHEN Body_mass_index between 25 and 30 then 'Overweight'
		WHEN Body_mass_index > 30 then 'Obesse'
		ELSE 'Unknown' END AS BMI_Category,
	CASE WHEN Month_of_absence in (10, 11, 12, 1, 2, 3) THEN 'Rainy Season'
		WHEN Month_of_absence in (4, 5, 6, 7, 8, 9) THEN 'Dry Season'
		ELSE 'Unknown' END AS Season_Names,
	Day_of_the_week,
	Transportation_expense,
	Education,
	Son,
	Social_drinker,
	Social_smoker,
	Pet,
	Disciplinary_failure, 
	Age,
	Work_load_Average_day,
	Absenteeism_time_in_hours
	FROM Absenteeism_at_work a
	LEFT JOIN compensation b 
	ON a.ID = b.ID
	LEFT JOIN Reasons c 
	ON a.Reason_for_absence = c.Number;