CREATE OR REPLACE PROCEDURE carga_Funcionario
AS
  CURSOR c_funcionario IS
  SELECT employee_id, first_name, last_name,email, phone_number
    FROM employees;
  v_sk_funcionario NUMBER;
  v_cod_funcionario employees.employee_id%TYPE;
  v_pri_nome employees.first_name%TYPE;
  v_ult_nome employees.last_name%TYPE;
  v_email employees.email%TYPE;
  v_telefone employees.phone_number%TYPE;
BEGIN
OPEN c_funcionario;
LOOP
  FETCH c_funcionario INTO v_cod_funcionario, v_pri_nome,v_ult_nome,v_email,v_telefone;
  EXIT WHEN c_funcionario%NOTFOUND;
  v_sk_funcionario := fn_gera_Surrougate('D_FUNCIONARIO');
  IF v_telefone = '' THEN
     v_telefone := '9999-9999';
  END IF;   
  INSERT INTO D_FUNCIONARIO(sk_funcionario,cod_funcionario,nome_funcionario,email,telefone) 
  VALUES(v_sk_funcionario, v_cod_funcionario,v_pri_nome || ' ' || v_ult_nome,v_email,v_telefone);
END LOOP; 
COMMIT;
CLOSE c_funcionario;
EXCEPTION
  WHEN OTHERS THEN
	ROLLBACK;
    raise_application_error(-20105, 'Erro de inserção no cursor de C_funcionário');
END carga_Funcionario;