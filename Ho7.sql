-- Joshua Membreno

-- #7-1
CREATE OR REPLACE PACKAGE order_info_pkg IS
  FUNCTION ship_name_pf 
    (p_basket IN NUMBER)
    RETURN VARCHAR2;
  PROCEDURE basket_info_pp
    (p_basket IN NUMBER,
     p_shop OUT NUMBER,
     p_date OUT DATE);
END;
/
CREATE OR REPLACE PACKAGE BODY order_info_pkg
  IS
  FUNCTION ship_name_pf
    (p_basket IN NUMBER)
    RETURN VARCHAR2
  IS
    lv_name_txt VARCHAR2(25);
BEGIN
  SELECT shipfirstname||' '||shiplastname
    INTO lv_name_txt
    FROM bb_basket
    WHERE idBasket = p_basket;
  RETURN lv_name_txt;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid basket id');
  END ship_name_pf;
  PROCEDURE basket_info_pp
    (p_basket IN NUMBER,
     p_shop OUT NUMBER,
     p_date OUT DATE)
  IS
BEGIN
  SELECT idshopper, dtordered
    INTO p_shop, p_date
    FROM bb_basket
    WHERE idbasket = p_basket;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid basket id');
  END basket_info_pp;
END;
/
-- #7-2
CREATE OR REPLACE PACKAGE order_info_pkg
  IS
  FUNCTION ship_name_pf  
    (p_basket IN NUMBER)
    RETURN VARCHAR2;
  PROCEDURE basket_info_pp
    (p_basket IN NUMBER,
     p_shop OUT NUMBER,
     p_date OUT DATE);
END;
/
CREATE OR REPLACE PACKAGE BODY order_info_pkg
  IS
  FUNCTION ship_name_pf  
    (p_basket IN NUMBER)
    RETURN VARCHAR2
  IS
    lv_name_txt VARCHAR2(25);
BEGIN
  SELECT shipfirstname||' '||shiplastname
    INTO lv_name_txt
    FROM bb_basket
    WHERE idBasket = p_basket;
  RETURN lv_name_txt;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid basket id');
  END ship_name_pf;
  PROCEDURE basket_info_pp
    (p_basket IN NUMBER,
     p_shop OUT NUMBER,
     p_date OUT DATE)
  IS
BEGIN
  SELECT idshopper, dtordered
    INTO p_shop, p_date
    FROM bb_basket
    WHERE idbasket = p_basket;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid basket id');
  END basket_info_pp;
END;
/
-- ANONYMOUS BLOCK TO CALL BOTH PACKAGED PROCEDURE & FUNCTION
DECLARE
  lv_name       VARCHAR2(22);
  lv_id_shop    NUMBER(4);
  lv_order_dat    DATE;
BEGIN
    lv_name := order_info_pkg.ship_name_pf(12);
    order_info_pkg.basket_info_pp(12,lv_id_shop, lv_order_dat);
    DBMS_OUTPUT.PUT_LINE(lv_name);
    DBMS_OUTPUT.PUT_LINE(lv_id_shop);
    DBMS_OUTPUT.PUT_LINE(lv_order_dat);
END;
/
SELECT order_info_pkg.ship_name_pf(idbasket)
FROM bb_basket
WHERE idbasket = 12;
/
-- 7-3
CREATE OR REPLACE PACKAGE order_info_pkg 
 IS
 PROCEDURE basket_info_pp
     (p_basket IN  NUMBER,
      p_shop   OUT NUMBER,
      p_date   OUT DATE,
      p_name   OUT VARCHAR2);
 END order_info_pkg;
/
CREATE OR REPLACE PACKAGE BODY order_info_pkg
  IS
  FUNCTION ship_name_pf  
    (p_basket IN NUMBER)
    RETURN VARCHAR2
  IS
    lv_name_txt VARCHAR2(25);
BEGIN
  SELECT shipfirstname||' '||shiplastname
    INTO lv_name_txt
    FROM bb_basket
    WHERE idBasket = p_basket;
  RETURN lv_name_txt;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid basket id');
  END ship_name_pf;
  PROCEDURE basket_info_pp
    (p_basket IN NUMBER,
     p_shop OUT NUMBER,
     p_date OUT DATE,
     p_name OUT VARCHAR2 )
  IS
BEGIN
  SELECT idshopper, dtordered
    INTO p_shop, p_date
    FROM bb_basket
    WHERE idbasket = p_basket;
  p_name := ship_name_pf(p_basket);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid basket id');
  END basket_info_pp;
END;
/
-- ANONYMOUS BLOCK TO CALL BASKET_INFO_PP SIMILAR TO 7-1
DECLARE
    lv_name       VARCHAR2(22);
    lv_id_shop    NUMBER(4);
    lv_order_dat    DATE; 
BEGIN
    lv_name := order_info_pkg.ship_name_pf(4);
    order_info_pkg.basket_info_pp(4,lv_id_shop, lv_order_dat);
    DBMS_OUTPUT.PUT_LINE(lv_name);
    DBMS_OUTPUT.PUT_LINE(lv_id_shop);
    DBMS_OUTPUT.PUT_LINE(lv_order_dat);
END;
/
--7-4
