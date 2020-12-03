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
    DBMS_OUTPUT.PUT_LINE('NAME: '||lv_name);
    DBMS_OUTPUT.PUT_LINE('ID: '||lv_id_shop);
    DBMS_OUTPUT.PUT_LINE('DATE: '||lv_order_dat);
END;
/
SELECT order_info_pkg.ship_name_pf(idbasket)
FROM bb_basket
WHERE idbasket = 12;
/
-- #7-3
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
-- ANONYMOUS BLOCK TO CALL BASKET_INFO_PP
DECLARE
    lv_name       VARCHAR2(22);
    lv_id_shop    NUMBER(4);
    lv_order_dat    DATE; 
BEGIN
    order_info_pkg.basket_info_pp(6,lv_id_shop, lv_order_dat, lv_name);
    DBMS_OUTPUT.PUT_LINE('NAME: '||lv_name);
    DBMS_OUTPUT.PUT_LINE('ID: '||lv_id_shop);
    DBMS_OUTPUT.PUT_LINE('DATE: '||lv_order_dat);
END;
/
-- #7-4
-- AS A FUNCTION
CREATE OR REPLACE 
FUNCTION LOGIN_CK
(p_usr  IN VARCHAR2,
 p_pwd  IN VARCHAR2)
RETURN VARCHAR2 
AS
lv_id_var  bb_shopper.idshopper%TYPE;
lv_zip_var bb_shopper.zipcode%type;
lv_usr bb_shopper.username%type;
lv_pass bb_shopper.password%TYPE;
lv_match VARCHAR2(1) := 'N';
BEGIN
    SELECT idshopper, SUBSTR(zipcode,1,3), username, password
    INTO lv_id_var, lv_zip_var, lv_usr, lv_pass
    FROM bb_shopper
    WHERE username = p_usr
        AND password = p_pwd;
    lv_match := 'Y';
  RETURN lv_match;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('INVALID LOGIN CREDENTIALS!');
END LOGIN_CK;
/
-- ANON BLOCK
DECLARE
    lv_login_ck  bb_shopper.username%TYPE;
    lv_usr_ck   bb_shopper.username%TYPE := 'gma1';
    lv_pwd_ck   bb_shopper.password%TYPE := 'goofy';
BEGIN
    lv_login_ck := LOGIN_CK(lv_usr_ck, lv_pwd_ck);
    DBMS_OUTPUT.PUT_LINE('Username: '||lv_usr_ck);
    DBMS_OUTPUT.PUT_LINE('Password: '||lv_pwd_ck);
    DBMS_OUTPUT.PUT_LINE('valid?(Y/N): '|| lv_login_ck);
END;
/
-- PLACEING IT IN A PACKAGE HEAD1
create or replace PACKAGE LOGIN_PKG
IS
lv_id_var  bb_shopper.idshopper%TYPE;
lv_zip_var bb_shopper.zipcode%TYPE;
FUNCTION LOGIN_CK
(p_usr  IN VARCHAR2,
 p_pwd  IN VARCHAR2)
RETURN VARCHAR2;
END;
/
-- IN A PACKAGE BODY
create or replace PACKAGE BODY LOGIN_PKG
IS
FUNCTION LOGIN_CK
(p_usr  IN VARCHAR2,
 p_pwd  IN VARCHAR2)
RETURN VARCHAR2 
AS
lv_id_var  bb_shopper.idshopper%TYPE;
lv_zip_var bb_shopper.zipcode%type;
lv_usr bb_shopper.username%type;
lv_pass bb_shopper.password%TYPE;
lv_match VARCHAR2(1) := 'N';
BEGIN
    SELECT idshopper, SUBSTR(zipcode,1,3), username, password
    INTO lv_id_var, lv_zip_var, lv_usr, lv_pass
    FROM bb_shopper
    WHERE username = p_usr
        AND password = p_pwd;
    lv_match := 'Y';
    lv_id_var := lv_id_var;
    lv_zip_var := lv_zip_var;
  RETURN lv_match;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('INVALID LOGIN CREDENTIALS!');
END LOGIN_CK;
END;
/
DECLARE
    lv_login_ck  bb_shopper.username%TYPE;
    lv_usr_ck   bb_shopper.username%TYPE := 'gma1';
    lv_pwd_ck   bb_shopper.password%TYPE := 'goofy';
BEGIN
    lv_login_ck := LOGIN_CK(lv_usr_ck, lv_pwd_ck);
    DBMS_OUTPUT.PUT_LINE('Username: '||lv_usr_ck);
    DBMS_OUTPUT.PUT_LINE('Password: '||lv_pwd_ck);
    DBMS_OUTPUT.PUT_LINE('valid?(Y/N): '|| lv_login_ck);
END;
/
-- #7-5
CREATE OR REPLACE PACKAGE shop_query_pkg
IS
  PROCEDURE shopper_search 
    (p_usr_id    IN bb_shopper.idshopper%TYPE,
     p_usr_name  OUT VARCHAR2,
     p_usr_city  OUT bb_shopper.city%TYPE,
     p_usr_state OUT bb_shopper.state%TYPE,
     p_usr_phone OUT bb_shopper.phone%TYPE,
     p_usr_email OUT bb_shopper.email%TYPE);
-- OVERLOADED
  PROCEDURE shopper_search 
    (p_usr_lastn  OUT bb_shopper.lastname%TYPE,
     p_usr_name  OUT VARCHAR2,
     p_usr_city  OUT bb_shopper.city%TYPE,
     p_usr_state OUT bb_shopper.state%TYPE,
     p_usr_phone OUT bb_shopper.phone%TYPE,
     p_usr_email OUT bb_shopper.email%TYPE);
END;
/
CREATE OR REPLACE PACKAGE BODY shop_query_pkg
IS
  PROCEDURE shopper_search 
    (p_usr_id IN bb_shopper.idshopper%TYPE,
     p_usr_name OUT VARCHAR2,
     p_usr_city OUT bb_shopper.city%TYPE,
     p_usr_state OUT bb_shopper.state%TYPE,
     p_usr_phone OUT bb_shopper.phone%TYPE,
     p_usr_email OUT bb_shopper.email%TYPE)
IS
  BEGIN
    SELECT firstname||' '||lastname, city, state, phone, email
    INTO p_usr_name, p_usr_city, p_usr_state, p_usr_phone, p_usr_email
    FROM bb_shopper
    WHERE idshopper = p_usr_id;
--    EXCEPTION
--    WHEN CASE_NOT_FOUND THEN
--      DBMS_OUTPUT.PUT_LINE('Lastname not found'); 
END;
-- OVERLOADED
  PROCEDURE shopper_search 
    (p_usr_lastn OUT bb_shopper.lastname%TYPE,
     p_usr_name  OUT VARCHAR2,
     p_usr_city OUT bb_shopper.city%TYPE,
     p_usr_state OUT bb_shopper.state%TYPE,
     p_usr_phone OUT bb_shopper.phone%TYPE,
     p_usr_email OUT bb_shopper.email%TYPE)
IS
  BEGIN
    SELECT firstname||' '||lastname, city, state, phone, email
    INTO p_usr_name, p_usr_city, p_usr_state, p_usr_phone, p_usr_email
    FROM bb_shopper
    WHERE lastname = p_usr_lastn;
 EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Lastname not found');  
 END;
END;
/
-- ANON BLOCK TO SEARCH SHOPPER INFO
DECLARE
  lv_name  VARCHAR2(25);
  lv_lname bb_shopper.lastname%TYPE := 'Ratman';
  lv_city bb_shopper.city%TYPE;
  lv_state bb_shopper.state%TYPE;
  lv_phone bb_shopper.phone%TYPE;
  lv_email bb_shopper.email%TYPE;
  lv_id    bb_shopper.idshopper%TYPE := 23; 
BEGIN
shop_query_pkg.shopper_search(lv_id,lv_name,lv_city,lv_state,
    lv_phone,lv_email);
  DBMS_OUTPUT.PUT_LINE('Name: '||lv_name);
  DBMS_OUTPUT.PUT_LINE('City: '||lv_city);
  DBMS_OUTPUT.PUT_LINE('State: '||lv_state);
  DBMS_OUTPUT.PUT_LINE('Phone: '||lv_phone);
  DBMS_OUTPUT.PUT_LINE('Email: '||lv_email);
-- OVERLOADED
shop_query_pkg.shopper_search(lv_lname,lv_name,lv_city, lv_state,
    lv_phone,lv_email);
  DBMS_OUTPUT.PUT_LINE(lv_lname);
  DBMS_OUTPUT.PUT_LINE(lv_city);
  DBMS_OUTPUT.PUT_LINE(lv_state);
  DBMS_OUTPUT.PUT_LINE(lv_phone);
  DBMS_OUTPUT.PUT_LINE(lv_email);
END;
/
-- #7-6
CREATE OR REPLACE PACKAGE tax_rate_pkg
  IS
  pv_tax_nc CONSTANT NUMBER := .035;
  pv_tax_tx CONSTANT NUMBER := .05;
  pv_tax_tn CONSTANT NUMBER := .02;
END;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE('nc: '||tax_rate_pkg.pv_tax_nc);
  DBMS_OUTPUT.PUT_LINE('tx: '||tax_rate_pkg.pv_tax_tx);
  DBMS_OUTPUT.PUT_LINE('tn: '||tax_rate_pkg.pv_tax_tn);
END;
/
-- #7-7
CREATE OR REPLACE PACKAGE tax_rate_pkg
  IS
  CURSOR cur_tax IS
    SELECT state, taxrate
      FROM bb_tax;
  FUNCTION tax_ck
    (p_state IN bb_tax.state%TYPE)
    RETURN NUMBER;
END tax_rate_pkg;
/
CREATE OR REPLACE PACKAGE BODY tax_rate_pkg
  IS
  FUNCTION tax_ck
    (p_state IN bb_tax.state%TYPE)
    RETURN NUMBER
  IS
    lv_taxrate bb_tax.taxrate%TYPE :=0;
BEGIN
  FOR tax_rec IN cur_tax LOOP
    IF tax_rec.state = p_state THEN
      lv_taxrate := tax_rec.taxrate;
      RETURN lv_taxrate;
      EXIT;
    END IF;
  END LOOP;
  END;
END tax_rate_pkg;
/
-- ANON BLOCK
DECLARE
    lv_rate bb_tax.taxrate%TYPE;
BEGIN
    lv_rate := tax_rate_pkg.tax_ck('NC');
    DBMS_OUTPUT.PUT_LINE('NC: '||lv_rate);
END;
/
--#7-8
CREATE OR REPLACE PACKAGE login_pkg
  IS
  usr_log_time DATE;
  pv_id_num NUMBER(3);
  FUNCTION login_ck_pf 
    (p_user IN VARCHAR2,
     p_pass IN VARCHAR2)
     RETURN CHAR;
END;
/
CREATE OR REPLACE PACKAGE BODY login_pkg
  IS
  FUNCTION login_ck_pf
    (p_user IN VARCHAR2,
     p_pass IN VARCHAR2)
  RETURN CHAR
  IS
    lv_ck_txt CHAR(1) := 'N';
    lv_id_num NUMBER(5);
BEGIN
  SELECT idShopper
    INTO lv_id_num
    FROM bb_shopper
    WHERE username = p_user
      AND password = p_pass;
      lv_ck_txt := 'Y';
      pv_id_num := lv_id_num;
  RETURN lv_ck_txt;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN lv_ck_txt;
   END;
BEGIN
   usr_log_time := SYSDATE;
END;
/
-- ANON BLOCK
DECLARE
    lv_usr bb_shopper.username%TYPE := 'kids2';
    lv_pwd bb_shopper.password%TYPE := 'steel';
BEGIN
DBMS_OUTPUT.PUT_LINE('user: '||lv_usr);
DBMS_OUTPUT.PUT_LINE('password: '||lv_pwd);
DBMS_OUTPUT.PUT_LINE('LOGIN TIME: '||TO_CHAR(login_pkg.usr_log_time,
    'MM/DD/YYYY HH:MM:SS'));
END;
/