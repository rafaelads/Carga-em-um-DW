CREATE OR REPLACE PROCEDURE carga_Departamento
AS
  CURSOR c_departamento IS
  SELECT department_id, department_name FROM departments;
  v_sk_depto NUMBER;
  v_cod_depto departments.department_id%TYPE;
  v_desc_depto departments.department_name%TYPE;
BEGIN
OPEN c_departamento;
LOOP
  FETCH c_departamento INTO v_cod_depto, v_desc_depto;
  EXIT WHEN c_departamento%NOTFOUND;
  v_sk_depto := fn_gera_Surrougate('D_DEPARTAMENTO');
  INSERT INTO D_DEPARTAMENTO(sk_depto, cod_depto,desc_depto) 
  VALUES(v_sk_depto, v_cod_depto,v_desc_depto);
END LOOP; 
COMMIT;
CLOSE c_departamento;
EXCEPTION
   WHEN OTHERS THEN
	 ROLLBACK;
     raise_application_error(-20107, 'Erro de inserção na Tabela de Departamento');
END carga_Departamento;