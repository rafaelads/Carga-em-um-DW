CREATE OR REPLACE FUNCTION fn_CalcPerc_Sal
(
 v_cod_func IN NUMBER
)
RETURN NUMBER
IS
v_perc_sal NUMBER(6,2) := 0;
v_salario NUMBER(8,2) := 0;
v_total_salario NUMBER(9,2) := 0;
BEGIN
  SELECT SUM(salary) INTO v_total_salario FROM employees;
  SELECT salary INTO v_salario FROM employees
    WHERE employee_id = v_cod_func;
  v_perc_sal := (v_salario / v_total_salario)*100;
  RETURN v_perc_sal;
END fn_CalcPerc_Sal; 
