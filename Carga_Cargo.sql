CREATE OR REPLACE PROCEDURE carga_Cargo
AS
  CURSOR c_cargo IS
  SELECT job_id, job_title   FROM jobs;
  v_sk_cargo NUMBER;
  v_cod_cargo jobs.job_id%TYPE;
  v_desc_cargo jobs.job_title%TYPE;
BEGIN
OPEN c_cargo;
LOOP
  FETCH c_cargo INTO v_cod_cargo, v_desc_cargo;
  EXIT WHEN c_cargo%NOTFOUND;
  v_sk_cargo := fn_gera_Surrougate('D_CARGO');
  INSERT INTO D_CARGO(sk_cargo, cod_cargo,desc_cargo) 
  VALUES(v_sk_cargo, v_cod_cargo,v_desc_cargo);
END LOOP; 
COMMIT;
CLOSE c_cargo;
EXCEPTION
  WHEN OTHERS THEN
	  ROLLBACK;
    raise_application_error(-20108, 'Erro de inserção no cursor da tabela de Cargo');
END carga_Cargo; 