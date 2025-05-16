/* Write your T-SQL query statement below */
With Matches_with_points As (
 Select home_team_id,
        away_team_id,
        home_team_goals,
        away_team_goals,
        (Case
             When home_team_goals > away_team_goals
             Then 3
             WHen home_team_goals = away_team_goals
             Then 1
             Else 0
             End
        ) As home_team_points,
        (Case
             When home_team_goals < away_team_goals
             Then 3
             WHen home_team_goals = away_team_goals
             Then 1
             Else 0
             End
        ) As away_team_points
 From Matches
),
Combined_Results As (
Select home_team_id As team_id,
       Count(home_team_id) As matches_played,
       Sum(home_team_points) As points,
       Sum(home_team_goals) As goal_for,
       Sum(away_team_goals) As goal_against
From Matches_with_points
Group By home_team_id

Union All

Select away_team_id As team_id,
       Count(away_team_id) As matches_played,
       Sum(away_team_points) As Points,
       Sum(away_team_goals) As goal_for,
       Sum(home_team_goals) As goal_against
From Matches_with_points
Group By away_team_id
)
Select t2.team_name,
       matches_played,
       points,
       goal_for,
       goal_against,
       goal_diff
From (
Select team_id,
       Sum(matches_played) As matches_played,
       Sum(points) As points,
       Sum(goal_for) As goal_for,
       Sum(goal_against) As goal_against,
       Sum(goal_for) - Sum(goal_against) As goal_diff
From Combined_Results
Group By team_id
) t1
Inner join Teams t2
On t1.team_id = t2.team_id
Order By points Desc, goal_diff Desc, team_name
