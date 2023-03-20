CREATE OR REPLACE FUNCTION fn_Conta_Registro
(
 tabela IN CHAR
)
RETURN NUMBER
IS
v_registro NUMBER := 0;
BEGIN
 CASE tabela
    WHEN 'D_DEPARTAMENTO' THEN
      SELECT count(*) INTO v_registro FROM d_departamento;
    WHEN 'D_CARGO' THEN 
      SELECT count(*) INTO v_registro FROM d_cargo;
    WHEN 'D_FUNCIONARIO' THEN 
      SELECT count(*) INTO v_registro FROM d_funcionario;
    WHEN 'D_LOCALIZACAO' THEN 
      SELECT count(*) INTO v_registro FROM d_localizacao;
    WHEN 'D_DT_CONTRAT' THEN 
      SELECT count(*) INTO v_registro FROM d_dt_contrat;
  END CASE; 
  RETURN v_registro;
END fn_Conta_Registro; 