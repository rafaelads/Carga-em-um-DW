CREATE OR REPLACE PROCEDURE carga_Dt_Contratacao
AS
  v_DataIni DATE;
  v_DataFim DATE;
  v_sk_dt_contrat NUMBER := 1;
  v_desc_data DATE;
  v_desc_dia_semana  VARCHAR2(20);
  v_numero_diames NUMBER;
  v_desc_mes VARCHAR2(20);
  v_numero_mes NUMBER;
  v_ano NUMBER;
BEGIN
  SELECT MIN(hire_date) INTO v_DataIni FROM employees;   
  SELECT MAX(hire_date) INTO v_DataFim FROM employees; 
  v_desc_data := v_DataIni;
  WHILE v_desc_data <= v_DataFim LOOP
       v_desc_dia_semana := TO_CHAR (v_desc_data, 'DAY');
       v_numero_diames := TO_NUMBER(TO_CHAR (v_desc_data, 'D'));
       v_desc_mes := TO_CHAR (v_desc_data, 'MONTH');
       v_numero_mes := TO_NUMBER(TO_CHAR (v_desc_data, 'MM'));
       v_ano := TO_NUMBER(TO_CHAR (v_desc_data, 'YYYY'));
       INSERT INTO D_DT_CONTRAT(sk_dt_contrat,desc_data,desc_dia_semana,numero_diames,desc_mes,numero_mes,ano) 
          VALUES(v_sk_dt_contrat, v_desc_data,v_desc_dia_semana,v_numero_diames,v_desc_mes,v_numero_mes,v_ano);
       v_desc_data := v_desc_data + 1;
       v_sk_dt_contrat := v_sk_dt_contrat + 1;
  END LOOP;  
  COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
	ROOLBACK;
    raise_application_error(-20106, 'Erro na Tabela de data de contratação');
END carga_Dt_Contratacao;