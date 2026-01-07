-- Join employees and departments
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;

-- Department-wise average salary
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- Salary vs department average
SELECT emp_name, dept_name, salary, dept_avg
FROM (
  SELECT e.emp_name, d.dept_name, e.salary,
  AVG(e.salary) OVER (PARTITION BY d.dept_name) AS dept_avg
  FROM employees e
  JOIN departments d
  ON e.dept_id = d.dept_id
) t;

-- Rank employees inside department
SELECT *
FROM (
  SELECT e.emp_name, d.dept_name, e.salary,
  RANK() OVER (PARTITION BY d.dept_name ORDER BY e.salary DESC) AS rnk
  FROM employees e
  JOIN departments d
  ON e.dept_id = d.dept_id
) t;
