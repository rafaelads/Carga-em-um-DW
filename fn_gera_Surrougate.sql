CREATE OR REPLACE FUNCTION fn_gera_Surrougate
(
 tabela IN CHAR
)
RETURN NUMBER
IS
v_max_sk NUMBER := 0;
v_registro NUMBER := 0;
BEGIN
 CASE tabela
    WHEN 'D_DEPARTAMENTO' THEN
      v_registro := fn_Conta_Registro('D_DEPARTAMENTO');
      IF v_registro <> 0 THEN 
         SELECT MAX(sk_depto) INTO v_max_sk FROM d_departamento;
      END IF;   
    WHEN 'D_CARGO' THEN 
      v_registro := fn_Conta_Registro('D_CARGO');
      IF v_registro <> 0 THEN 
         SELECT MAX(sk_cargo) INTO v_max_sk FROM d_cargo;
      END IF;
    WHEN 'D_FUNCIONARIO' THEN 
      v_registro := fn_Conta_Registro('D_FUNCIONARIO');
      IF v_registro <> 0 THEN 
         SELECT MAX(sk_funcionario) INTO v_max_sk FROM d_funcionario;
      END IF;
    WHEN 'D_LOCALIZACAO' THEN 
      v_registro := fn_Conta_Registro('D_LOCALIZACAO');
      IF v_registro <> 0 THEN 
         SELECT MAX(sk_localizacao) INTO v_max_sk FROM d_localizacao; 
      END IF;
    WHEN 'D_DT_CONTRAT' THEN 
       v_registro := fn_Conta_Registro('D_DT_CONTRAT');
      IF v_registro <> 0 THEN 
         SELECT MAX(sk_dt_contrat) INTO v_max_sk FROM d_dt_contrat; 
      END IF;
  END CASE; 
  RETURN v_max_sk + 1;
END fn_gera_Surrougate;  