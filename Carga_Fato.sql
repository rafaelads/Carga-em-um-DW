CREATE OR REPLACE PROCEDURE carga_Fato
AS
  CURSOR c_fato IS
  SELECT wd.sk_depto,wc.sk_cargo,wf.sk_funcionario,wl.sk_localizacao,wdt.sk_dt_contrat,e.salary,e.employee_id  
FROM employees e, d_departamento wd, d_cargo wc, d_funcionario wf, d_localizacao wl, d_dt_contrat wdt, departments d
WHERE e.department_id = wd.cod_depto AND
      e.employee_id = wf.cod_funcionario AND 
      e.job_id = wc.cod_cargo AND
      e.department_id = d.department_id AND
      d.location_id = wl.cod_localizacao AND
      e.hire_date = wdt.desc_data;
  v_sk_depto NUMBER;
  v_sk_cargo NUMBER;
  v_sk_funcionario NUMBER;
  v_sk_localizacao NUMBER;
  v_sk_dt_contrat NUMBER;
  v_valor_salario employees.salary%TYPE;
  v_employee_id employees.employee_id%TYPE;
  v_perc_sal NUMBER(6,2) := 0;
  v_total_salario NUMBER(9,2) := 0;
  v_total_func NUMBER := 1;
BEGIN
SELECT SUM(salary) INTO v_total_salario FROM employees;
OPEN c_fato;
LOOP
  FETCH c_fato INTO v_sk_depto, v_sk_cargo,v_sk_funcionario,v_sk_localizacao, v_sk_dt_contrat,v_valor_salario,v_employee_id;
  EXIT WHEN c_fato%NOTFOUND;
  v_perc_sal := fn_CalcPerc_Sal(v_employee_id);
  INSERT INTO F_REC_HUMANOS(sk_depto,sk_cargo,sk_funcionario,sk_localizacao,sk_dt_contrat,total_func,valor_salario,perc_salario) 
  VALUES(v_sk_depto,v_sk_cargo,v_sk_funcionario,v_sk_localizacao,v_sk_dt_contrat,v_total_func,v_valor_salario,v_perc_sal);
END LOOP; 
COMMIT;
CLOSE c_fato;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK; 
    raise_application_error(-20104, 'Ocorreu um erro na inserção da Tabela de Fato');
END carga_Fato;  
