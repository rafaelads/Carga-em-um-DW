set serveroutput on
prompt MENU PRINCIPAL DE CARGA DAS TABELAS - DW
prompt 1 - CARGA DA DIMENS�O DEPARTAMENTO
prompt 2 - CARGA DA DIMENS�O CARGO
prompt 3 - CARGA DA DIMENS�O FUNCION�RIO
prompt 4 - CARGA DA DIMENS�O LOCALIZA��O
prompt 5 - CARGA DA DIMENS�O DATA CONTRATA��O
prompt 6 - CARGA TABELA DE FATO
accept v_opcao_input NUMBER prompt Entre com a opcao: ;
DECLARE
  v_opcao NUMBER;
BEGIN
  v_opcao := &v_opcao_input;
  CASE v_opcao
    WHEN 1 THEN carga_Departamento;
    WHEN 2 THEN carga_Cargo;
    WHEN 3 THEN carga_Funcionario;
    WHEN 4 THEN carga_Localizacao;
    WHEN 5 THEN carga_Dt_Contratacao;
    WHEN 6 THEN carga_Fato;
    ELSE DBMS_OUTPUT.PUT_LINE('OP��O INV�LIDA!');
  END CASE; 
EXCEPTION
  WHEN OTHERS THEN            /* Erro no sistema */
    DBMS_OUTPUT.PUT_LINE('Ocorreu um Erro');
END;