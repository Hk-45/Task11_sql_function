select * from employee

select first_name, last_name, experience from employee

select experience > 5 from employee where employee_id = 3

select experience, 
     Case 
        When experience <=5 Then 'junior exp'
        When experience > 5 And experience <=8 Then 'senior exp'
        When experience > 8 Then 'super senior exp'
	    Else 'No exp'
     End 
from employee

--Function for check the experience of employee
Create or Replace Function checkexp(exp int)
Returns varchar as $$
Declare output varchar;

BEGIN
   Case 
        When exp <=5 Then output := 'junior exp';
        When exp > 5 And exp <=8 Then output := 'senior exp';
        When exp > 8 Then output := 'super senior exp';
	    Else output := 'No exp'; 
   End Case;
   Return output;

END 
$$ LANGUAGE plpgsql;

select employee_id, first_name, last_name, age, experience,checkexp(experience) from employee 


select * from employee

select employee_id, first_name, last_name, age, experience, salary from employee
where hire_date in ('2024-05-01','2024-05-31')

select 
	   Case
        When hire_date between '2024-05-01' And '2024-05-31' Then 'Employees hire in May'
        When hire_date between '2024-06-01' And '2024-06-29' Then 'Employees hire in June'
	    Else 'No hire'
       End
from employee

--check the hiring month of the employees
Create or Replace Function checkHire_date(hiring Date)
Returns varchar as $$
Declare 
	hiring_status varchar;
BEGIN
    Case
	    When hiring between '2023-01-01' And '2023-01-30' Then hiring_status := 'Employees hire in January 2023';
	    When hiring between '2024-04-01' And '2024-04-30' Then hiring_status := 'Employees hire in April';
        When hiring between '2024-05-01' And '2024-05-31' Then hiring_status := 'Employees hire in May';
        When hiring between '2024-06-01' And '2024-06-29' Then hiring_status := 'Employees hire in June';
	    When hiring between '2024-07-01' And '2024-07-31' Then hiring_status := 'Employees hire in July';
	    Else hiring_status := 'No hire'; 
    End Case;
    Return hiring_status;
END
$$ language plpgsql

select hire_date, checkHire_date(hire_date::date) from employee

select employee_id,first_name,last_name,age,experience, checkHire_date(hire_date::date) from employee


