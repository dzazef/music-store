DELIMITER $$
CREATE PROCEDURE add_instrument(price FLOAT,instrument_type VARCHAR(80),instrument_name VARCHAR(50),
  manufacturer_name VARCHAR(50))
  BEGIN
      DECLARE var_manufacturer_id INT DEFAULT NULL ;
      DECLARE var_manufacturer_name VARCHAR(50) DEFAULT NULL;
      /*inserting into products*/
      INSERT INTO products (category, price) VALUES ('instrument',price);
      SET @product_id = LAST_INSERT_ID();
      /*check if manufacturer with given name exists, if not add it to instrument_manufacturers*/
      SELECT `name`,manufacturer_id
        INTO var_manufacturer_name, var_manufacturer_id
        FROM instrument_manufacturers
        WHERE instrument_name LIKE manufacturer_name;
      IF var_manufacturer_name IS NULL OR var_manufacturer_id IS NULL THEN
        INSERT INTO instrument_manufacturers (name) VALUES (manufacturer_name);
        SET var_manufacturer_id = LAST_INSERT_ID();
      END IF;
      /*add instrument to instruments*/
      INSERT INTO instruments (instrument_id, manufacturer_id, type, name) 
        VALUES(@product_id,var_manufacturer_id,instrument_type,instrument_name);

  END $$
DELIMITER ;