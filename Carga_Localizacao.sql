CREATE OR REPLACE PROCEDURE carga_Localizacao
AS
  CURSOR c_localizacao IS
  SELECT l.location_id, l.street_address,l.postal_code,l.city, l.state_province,c.country_name,r.region_name
    FROM locations l, regions r, countries c
  WHERE l.country_id = c.country_id AND
        c.region_id = r.region_id;
  v_sk_localizacao NUMBER;
  v_cod_localizacao locations.location_id%TYPE;
  v_rua locations.street_address%TYPE;
  v_cep locations.postal_code%TYPE;
  v_desc_cidade locations.city%TYPE;
  v_desc_estado locations.state_province%TYPE;
  v_desc_pais countries.country_name%TYPE;
  v_desc_regiao regions.region_name%TYPE;
BEGIN
OPEN c_localizacao;
LOOP
  FETCH c_localizacao INTO v_cod_localizacao,v_rua,v_cep,v_desc_cidade,v_desc_estado,v_desc_pais,v_desc_regiao;
  EXIT WHEN c_localizacao%NOTFOUND;
  v_sk_localizacao := fn_gera_Surrougate('D_LOCALIZACAO');
  INSERT INTO D_LOCALIZACAO(sk_localizacao,cod_localizacao,desc_localizacao,desc_cidade,desc_estado,desc_pais,desc_regiao) 
  VALUES(v_sk_localizacao, v_cod_localizacao,v_rua || ' ' || v_cep,v_desc_cidade,v_desc_estado,v_desc_pais,v_desc_regiao);
END LOOP; 
COMMIT;
CLOSE c_localizacao;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK; 
    raise_application_error(-20104, 'Ocorreu um erro na inserção do cursor');
END carga_Localizacao;