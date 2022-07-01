CREATE INDEX emp_department_ix ON employees (department_id);

CREATE INDEX emp_job_ix ON employees (job_id);

CREATE INDEX emp_manager_ix ON employees (manager_id);

CREATE INDEX emp_name_ix ON employees (last_name, first_name);

CREATE INDEX dept_location_ix ON departments (location_id);
