set serveroutput on
prompt MENU PRINCIPAL DE CARGA DAS TABELAS - DW
prompt 1 - CARGA DA DIMENSÃO DEPARTAMENTO
prompt 2 - CARGA DA DIMENSÃO CARGO
prompt 3 - CARGA DA DIMENSÃO FUNCIONÁRIO
prompt 4 - CARGA DA DIMENSÃO LOCALIZAÇÃO
prompt 5 - CARGA DA DIMENSÃO DATA CONTRATAÇÃO
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
    ELSE DBMS_OUTPUT.PUT_LINE('OPÇÃO INVÁLIDA!');
  END CASE; 
EXCEPTION
  WHEN OTHERS THEN            /* Erro no sistema */
    DBMS_OUTPUT.PUT_LINE('Ocorreu um Erro');
END;