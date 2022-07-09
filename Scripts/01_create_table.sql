-- 部门信息表
CREATE TABLE departments
    ( department_id    INTEGER NOT NULL -- 部门编号，主键
    , department_name  CHARACTER VARYING(30) NOT NULL -- 部门名称
    , manager_id       INTEGER -- 部门经理的员工编号
    , location_id      INTEGER -- 部门所在位置编号
    , CONSTRAINT dept_id_pk PRIMARY KEY (department_id)
    ) ;

-- 职位信息表
CREATE TABLE jobs
    ( job_id         CHARACTER VARYING(10) NOT NULL -- 职位编号，主键
    , job_title      CHARACTER VARYING(35) NOT NULL -- 职位名称
    , min_salary     INTEGER -- 最低月薪
    , max_salary     INTEGER -- 最高月薪
    , CONSTRAINT job_id_pk PRIMARY KEY(job_id)
    ) ;

-- 员工信息表
CREATE TABLE employees
    ( employee_id    INTEGER NOT NULL -- 员工编号，主键
    , first_name     CHARACTER VARYING(20) -- 名字
    , last_name      CHARACTER VARYING(25) NOT NULL -- 姓氏
    , email          CHARACTER VARYING(25) NOT NULL -- 邮箱
    , phone_number   CHARACTER VARYING(20) -- 电话号码
    , hire_date      DATE NOT NULL -- 入职日期
    , job_id         CHARACTER VARYING(10) NOT NULL -- 职位编号
    , salary         NUMERIC(8,2) -- 月薪
    , commission_pct NUMERIC(2,2) -- 销售提成百分比
    , manager_id     INTEGER -- 经理
    , department_id  INTEGER -- 部门编号
    , CONSTRAINT emp_emp_id_pk PRIMARY KEY (employee_id)
    , CONSTRAINT emp_salary_min CHECK (salary > 0) 
    , CONSTRAINT emp_email_uk UNIQUE (email)
    , CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES departments(department_id)
    , CONSTRAINT emp_job_fk FOREIGN KEY (job_id) REFERENCES jobs(job_id)
    , CONSTRAINT emp_manager_fk FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
    ) ;

ALTER TABLE departments
ADD CONSTRAINT dept_mgr_fk FOREIGN KEY (manager_id) REFERENCES employees(employee_id);

-- 员工详细信息视图
CREATE VIEW emp_details_view
  (employee_id,
   job_id,
   manager_id,
   department_id,
   location_id,
   first_name,
   last_name,
   salary,
   commission_pct,
   department_name,
   job_title)
AS SELECT
  e.employee_id, 
  e.job_id, 
  e.manager_id, 
  e.department_id,
  d.location_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title
FROM
  employees e,
  departments d,
  jobs j
WHERE e.department_id = d.department_id
  AND j.job_id = e.job_id;
