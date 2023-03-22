# Pewlett-Hackard-Analysis_Ch7
DU-VIRT-DATA-PT-10-2022-U-B-MW—Module 7 Challenge—Pewlett-Hackard-Analysis—Python 3.9.13

# Analysis of Pewlett Hackard Employees' Database
## Overview
The purpose of this analysis is to assist the manager in anticipating the upcoming "silver tsunami" and preparing the organization for the retirement of the older generation of employees. The database of employees contains information from the 1980s and 1990s, and many of the employees are reaching retirement age.

The following two deliverables have been generated to support the analysis:

A table of retiring employees, classified by their job titles.
A table of employees who are eligible for the mentorship program.

## Results
### Deliverable 1: Retirement Titles
There are 72,458 employees who are about to retire soon.
Senior Engineers and Senior Staff members are the two job titles that will be affected the most by the wave of retirees.
There are only 2 managers that are about to retire, the sales manager and the research manager. This is good news for the organization, as managers who know their teams possess a lot of valuable "tribal" knowledge and experience which goes out the door when they leave.
Pewlett Hackard needs to fill 72,458 positions in the near future.


### Deliverable 2: Mentorship Eligibility
There are 1,549 employees who are eligible for the mentorship program.
Senior Staff members are the largest group of employees who are eligible for the mentorship program.
There are only 815 employees who are eligible for the mentorship program and are also titled "senior" or "leader". 
        "count"
    1    815
    from query: SELECT COUNT(mei.title)
                FROM mentoring_eligible_info AS mei
                WHERE mei.title LIKE '%Senior%' OR mei.title LIKE '%Leader%';
None are listed as managers. However, they likely collectively carry a great deal of the company culture and should be strongly incentivized to stay on part-time if the company doesn't want that culture to leave when they do.

Pewlett Hackard has enough qualified, retirement-ready employees in the departments to mentor the next generation of employees. If it develops a program to effectively pass on the company acumen of its senior leadership, there should be little disruption to its operations.


## Summary
How many roles will need to be filled as the "silver tsunami" begins to make an impact?

There will be 72,458 roles that need to be filled as the huge wave of retirees begins to make an impact.

Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

Yes, there are enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees and more than half are considered senior or leader. The mentorship eligibility table shows that there are 1,549 employees who are eligible for the mentorship program. There is never a guarantee that the workerforce will want to stay on longer than retirement age. PH ought to consider that incentives will need to be good enough for employees to desire to stay on "into their retirement," even part-time.

