SQL> @ C:\Users\Joshua\Documents\itse1345\competency_3\competency3_4\ho7\Ho7.sql
SQL> -- Joshua Membreno
SQL> 
SQL> -- #7-1
SQL> CREATE OR REPLACE PACKAGE order_info_pkg IS
  2    FUNCTION ship_name_pf 
  3      (p_basket IN NUMBER)
  4      RETURN VARCHAR2;
  5    PROCEDURE basket_info_pp
  6      (p_basket IN NUMBER,
  7       p_shop OUT NUMBER,
  8       p_date OUT DATE);
  9  END;
 10  /

Package ORDER_INFO_PKG compiled

SQL> CREATE OR REPLACE PACKAGE BODY order_info_pkg
  2    IS
  3    FUNCTION ship_name_pf
  4      (p_basket IN NUMBER)
  5      RETURN VARCHAR2
  6    IS
  7      lv_name_txt VARCHAR2(25);
  8  BEGIN
  9    SELECT shipfirstname||' '||shiplastname
 10      INTO lv_name_txt
 11      FROM bb_basket
 12      WHERE idBasket = p_basket;
 13    RETURN lv_name_txt;
 14  EXCEPTION
 15    WHEN NO_DATA_FOUND THEN
 16      DBMS_OUTPUT.PUT_LINE('Invalid basket id');
 17    END ship_name_pf;
 18    PROCEDURE basket_info_pp
 19      (p_basket IN NUMBER,
 20       p_shop OUT NUMBER,
 21       p_date OUT DATE)
 22    IS
 23  BEGIN
 24    SELECT idshopper, dtordered
 25      INTO p_shop, p_date
 26      FROM bb_basket
 27      WHERE idbasket = p_basket;
 28  EXCEPTION
 29    WHEN NO_DATA_FOUND THEN
 30      DBMS_OUTPUT.PUT_LINE('Invalid basket id');
 31    END basket_info_pp;
 32  END;
 33  /

Package Body ORDER_INFO_PKG compiled

SQL> -- #7-2
SQL> CREATE OR REPLACE PACKAGE order_info_pkg
  2    IS
  3    FUNCTION ship_name_pf  
  4      (p_basket IN NUMBER)
  5      RETURN VARCHAR2;
  6    PROCEDURE basket_info_pp
  7      (p_basket IN NUMBER,
  8       p_shop OUT NUMBER,
  9       p_date OUT DATE);
 10  END;
 11  /

Package ORDER_INFO_PKG compiled

SQL> CREATE OR REPLACE PACKAGE BODY order_info_pkg
  2    IS
  3    FUNCTION ship_name_pf  
  4      (p_basket IN NUMBER)
  5      RETURN VARCHAR2
  6    IS
  7      lv_name_txt VARCHAR2(25);
  8  BEGIN
  9    SELECT shipfirstname||' '||shiplastname
 10      INTO lv_name_txt
 11      FROM bb_basket
 12      WHERE idBasket = p_basket;
 13    RETURN lv_name_txt;
 14  EXCEPTION
 15    WHEN NO_DATA_FOUND THEN
 16      DBMS_OUTPUT.PUT_LINE('Invalid basket id');
 17    END ship_name_pf;
 18    PROCEDURE basket_info_pp
 19      (p_basket IN NUMBER,
 20       p_shop OUT NUMBER,
 21       p_date OUT DATE)
 22    IS
 23  BEGIN
 24    SELECT idshopper, dtordered
 25      INTO p_shop, p_date
 26      FROM bb_basket
 27      WHERE idbasket = p_basket;
 28  EXCEPTION
 29    WHEN NO_DATA_FOUND THEN
 30      DBMS_OUTPUT.PUT_LINE('Invalid basket id');
 31    END basket_info_pp;
 32  END;
 33  /

Package Body ORDER_INFO_PKG compiled

SQL> -- ANONYMOUS BLOCK TO CALL BOTH PACKAGED PROCEDURE & FUNCTION
SQL> DECLARE
  2    lv_name       VARCHAR2(22);
  3    lv_id_shop    NUMBER(4);
  4    lv_order_dat    DATE;
  5  BEGIN
  6      lv_name := order_info_pkg.ship_name_pf(12);
  7      order_info_pkg.basket_info_pp(12,lv_id_shop, lv_order_dat);
  8      DBMS_OUTPUT.PUT_LINE('NAME: '||lv_name);
  9      DBMS_OUTPUT.PUT_LINE('ID: '||lv_id_shop);
 10      DBMS_OUTPUT.PUT_LINE('DATE: '||lv_order_dat);
 11  END;
 12  /
NAME: Joe Cookers
ID: 25
DATE: 19-FEB-12


PL/SQL procedure successfully completed.

SQL> SELECT order_info_pkg.ship_name_pf(idbasket)
  2  FROM bb_basket
  3  WHERE idbasket = 12;

ORDER_INFO_PKG.SHIP_NAME_PF(IDBASKET)                                                               
----------------------------------------------------------------------------------------------------
Joe Cookers

SQL> /
SQL> -- #7-3
SQL> CREATE OR REPLACE PACKAGE order_info_pkg 
  2   IS
  3   PROCEDURE basket_info_pp
  4       (p_basket IN  NUMBER,
  5        p_shop   OUT NUMBER,
  6        p_date   OUT DATE,
  7        p_name   OUT VARCHAR2);
  8   END order_info_pkg;
  9  /

Package ORDER_INFO_PKG compiled

SQL> CREATE OR REPLACE PACKAGE BODY order_info_pkg
  2    IS
  3    FUNCTION ship_name_pf  
  4      (p_basket IN NUMBER)
  5      RETURN VARCHAR2
  6    IS
  7      lv_name_txt VARCHAR2(25);
  8  BEGIN
  9    SELECT shipfirstname||' '||shiplastname
 10      INTO lv_name_txt
 11      FROM bb_basket
 12      WHERE idBasket = p_basket;
 13    RETURN lv_name_txt;
 14  EXCEPTION
 15    WHEN NO_DATA_FOUND THEN
 16      DBMS_OUTPUT.PUT_LINE('Invalid basket id');
 17    END ship_name_pf;
 18    PROCEDURE basket_info_pp
 19      (p_basket IN NUMBER,
 20       p_shop OUT NUMBER,
 21       p_date OUT DATE,
 22       p_name OUT VARCHAR2 )
 23    IS
 24  BEGIN
 25    SELECT idshopper, dtordered
 26      INTO p_shop, p_date
 27      FROM bb_basket
 28      WHERE idbasket = p_basket;
 29    p_name := ship_name_pf(p_basket);
 30  EXCEPTION
 31    WHEN NO_DATA_FOUND THEN
 32      DBMS_OUTPUT.PUT_LINE('Invalid basket id');
 33    END basket_info_pp;
 34  END;
 35  /

Package Body ORDER_INFO_PKG compiled

SQL> -- ANONYMOUS BLOCK TO CALL BASKET_INFO_PP
SQL> DECLARE
  2      lv_name       VARCHAR2(22);
  3      lv_id_shop    NUMBER(4);
  4      lv_order_dat    DATE; 
  5  BEGIN
  6      order_info_pkg.basket_info_pp(6,lv_id_shop, lv_order_dat, lv_name);
  7      DBMS_OUTPUT.PUT_LINE('NAME: '||lv_name);
  8      DBMS_OUTPUT.PUT_LINE('ID: '||lv_id_shop);
  9      DBMS_OUTPUT.PUT_LINE('DATE: '||lv_order_dat);
 10  END;
 11  /
NAME: Margaret Somner
ID: 22
DATE: 01-MAR-12


PL/SQL procedure successfully completed.

SQL> -- #7-4
SQL> -- AS A FUNCTION
SQL> CREATE OR REPLACE 
  2  FUNCTION LOGIN_CK
  3  (p_usr  IN VARCHAR2,
  4   p_pwd  IN VARCHAR2)
  5  RETURN VARCHAR2 
  6  AS
  7  lv_id_var  bb_shopper.idshopper%TYPE;
  8  lv_zip_var bb_shopper.zipcode%type;
  9  lv_usr bb_shopper.username%type;
 10  lv_pass bb_shopper.password%TYPE;
 11  lv_match VARCHAR2(1) := 'N';
 12  BEGIN
 13      SELECT idshopper, SUBSTR(zipcode,1,3), username, password
 14      INTO lv_id_var, lv_zip_var, lv_usr, lv_pass
 15      FROM bb_shopper
 16      WHERE username = p_usr
 17          AND password = p_pwd;
 18      lv_match := 'Y';
 19    RETURN lv_match;
 20  EXCEPTION
 21      WHEN NO_DATA_FOUND THEN
 22          DBMS_OUTPUT.PUT_LINE('INVALID LOGIN CREDENTIALS!');
 23  END LOGIN_CK;
 24  /

Function LOGIN_CK compiled

SQL> -- ANON BLOCK
SQL> DECLARE
  2      lv_login_ck  bb_shopper.username%TYPE;
  3      lv_usr_ck   bb_shopper.username%TYPE := 'gma1';
  4      lv_pwd_ck   bb_shopper.password%TYPE := 'goofy';
  5  BEGIN
  6      lv_login_ck := LOGIN_CK(lv_usr_ck, lv_pwd_ck);
  7      DBMS_OUTPUT.PUT_LINE('Username: '||lv_usr_ck);
  8      DBMS_OUTPUT.PUT_LINE('Password: '||lv_pwd_ck);
  9      DBMS_OUTPUT.PUT_LINE('valid?(Y/N): '|| lv_login_ck);
 10  END;
 11  /
Username: gma1
Password: goofy
valid?(Y/N): Y


PL/SQL procedure successfully completed.

SQL> -- PLACEING IT IN A PACKAGE HEAD1
SQL> create or replace PACKAGE LOGIN_PKG
  2  IS
  3  lv_id_var  bb_shopper.idshopper%TYPE;
  4  lv_zip_var bb_shopper.zipcode%TYPE;
  5  FUNCTION LOGIN_CK
  6  (p_usr  IN VARCHAR2,
  7   p_pwd  IN VARCHAR2)
  8  RETURN VARCHAR2;
  9  END;
 10  /

Package LOGIN_PKG compiled

SQL> -- IN A PACKAGE BODY
SQL> create or replace PACKAGE BODY LOGIN_PKG
  2  IS
  3  FUNCTION LOGIN_CK
  4  (p_usr  IN VARCHAR2,
  5   p_pwd  IN VARCHAR2)
  6  RETURN VARCHAR2 
  7  AS
  8  lv_id_var  bb_shopper.idshopper%TYPE;
  9  lv_zip_var bb_shopper.zipcode%type;
 10  lv_usr bb_shopper.username%type;
 11  lv_pass bb_shopper.password%TYPE;
 12  lv_match VARCHAR2(1) := 'N';
 13  BEGIN
 14      SELECT idshopper, SUBSTR(zipcode,1,3), username, password
 15      INTO lv_id_var, lv_zip_var, lv_usr, lv_pass
 16      FROM bb_shopper
 17      WHERE username = p_usr
 18          AND password = p_pwd;
 19      lv_match := 'Y';
 20      lv_id_var := lv_id_var;
 21      lv_zip_var := lv_zip_var;
 22    RETURN lv_match;
 23  EXCEPTION
 24      WHEN NO_DATA_FOUND THEN
 25          DBMS_OUTPUT.PUT_LINE('INVALID LOGIN CREDENTIALS!');
 26  END LOGIN_CK;
 27  END;
 28  /

Package Body LOGIN_PKG compiled

SQL> DECLARE
  2      lv_login_ck  bb_shopper.username%TYPE;
  3      lv_usr_ck   bb_shopper.username%TYPE := 'gma1';
  4      lv_pwd_ck   bb_shopper.password%TYPE := 'goofy';
  5  BEGIN
  6      lv_login_ck := LOGIN_CK(lv_usr_ck, lv_pwd_ck);
  7      DBMS_OUTPUT.PUT_LINE('Username: '||lv_usr_ck);
  8      DBMS_OUTPUT.PUT_LINE('Password: '||lv_pwd_ck);
  9      DBMS_OUTPUT.PUT_LINE('valid?(Y/N): '|| lv_login_ck);
 10  END;
 11  /
Username: gma1
Password: goofy
valid?(Y/N): Y


PL/SQL procedure successfully completed.

SQL> -- #7-5
SQL> CREATE OR REPLACE PACKAGE shop_query_pkg
  2  IS
  3    PROCEDURE shopper_search 
  4      (p_usr_id    IN bb_shopper.idshopper%TYPE,
  5       p_usr_name  OUT VARCHAR2,
  6       p_usr_city  OUT bb_shopper.city%TYPE,
  7       p_usr_state OUT bb_shopper.state%TYPE,
  8       p_usr_phone OUT bb_shopper.phone%TYPE,
  9       p_usr_email OUT bb_shopper.email%TYPE);
 10  -- OVERLOADED
 11    PROCEDURE shopper_search 
 12      (p_usr_lastn  OUT bb_shopper.lastname%TYPE,
 13       p_usr_name  OUT VARCHAR2,
 14       p_usr_city  OUT bb_shopper.city%TYPE,
 15       p_usr_state OUT bb_shopper.state%TYPE,
 16       p_usr_phone OUT bb_shopper.phone%TYPE,
 17       p_usr_email OUT bb_shopper.email%TYPE);
 18  END;
 19  /

Package SHOP_QUERY_PKG compiled

SQL> CREATE OR REPLACE PACKAGE BODY shop_query_pkg
  2  IS
  3    PROCEDURE shopper_search 
  4      (p_usr_id IN bb_shopper.idshopper%TYPE,
  5       p_usr_name OUT VARCHAR2,
  6       p_usr_city OUT bb_shopper.city%TYPE,
  7       p_usr_state OUT bb_shopper.state%TYPE,
  8       p_usr_phone OUT bb_shopper.phone%TYPE,
  9       p_usr_email OUT bb_shopper.email%TYPE)
 10  IS
 11    BEGIN
 12      SELECT firstname||' '||lastname, city, state, phone, email
 13      INTO p_usr_name, p_usr_city, p_usr_state, p_usr_phone, p_usr_email
 14      FROM bb_shopper
 15      WHERE idshopper = p_usr_id;
 16     EXCEPTION
 17    WHEN NO_DATA_FOUND THEN
 18      DBMS_OUTPUT.PUT_LINE('Invalid Credential');
 19  END;
 20  -- OVERLOADED
 21    PROCEDURE shopper_search 
 22      (p_usr_lastn OUT bb_shopper.lastname%TYPE,
 23       p_usr_name  OUT VARCHAR2,
 24       p_usr_city OUT bb_shopper.city%TYPE,
 25       p_usr_state OUT bb_shopper.state%TYPE,
 26       p_usr_phone OUT bb_shopper.phone%TYPE,
 27       p_usr_email OUT bb_shopper.email%TYPE)
 28  IS
 29    BEGIN
 30      SELECT firstname||' '||lastname, city, state, phone, email
 31      INTO p_usr_name, p_usr_city, p_usr_state, p_usr_phone, p_usr_email
 32      FROM bb_shopper
 33      WHERE lastname = p_usr_lastn;
 34      EXCEPTION
 35    WHEN NO_DATA_FOUND THEN
 36      DBMS_OUTPUT.PUT_LINE('Invalid Lastname');
 37   END;
 38  END;
 39  /

Package Body SHOP_QUERY_PKG compiled

SQL> -- ANON BLOCK TO SEARCH SHOPPER INFO
SQL> DECLARE
  2    lv_name  VARCHAR2(25);
  3    lv_lname bb_shopper.lastname%TYPE := 'Ratman';
  4    lv_city bb_shopper.city%TYPE;
  5    lv_state bb_shopper.state%TYPE;
  6    lv_phone bb_shopper.phone%TYPE;
  7    lv_email bb_shopper.email%TYPE;
  8    lv_id    bb_shopper.idshopper%TYPE := 23; 
  9  BEGIN
 10  shop_query_pkg.shopper_search(lv_id,lv_name,lv_city,lv_state,
 11      lv_phone,lv_email);
 12    DBMS_OUTPUT.PUT_LINE('Name: '||lv_name);
 13    DBMS_OUTPUT.PUT_LINE('City: '||lv_city);
 14    DBMS_OUTPUT.PUT_LINE('State: '||lv_state);
 15    DBMS_OUTPUT.PUT_LINE('Phone: '||lv_phone);
 16    DBMS_OUTPUT.PUT_LINE('Email: '||lv_email);
 17  -- OVERLOADED
 18  shop_query_pkg.shopper_search(lv_lname,lv_lname,lv_city, lv_state,
 19      lv_phone,lv_email);
 20    DBMS_OUTPUT.PUT_LINE(lv_lname);
 21    DBMS_OUTPUT.PUT_LINE(lv_city);
 22    DBMS_OUTPUT.PUT_LINE(lv_state);
 23    DBMS_OUTPUT.PUT_LINE(lv_phone);
 24    DBMS_OUTPUT.PUT_LINE(lv_email);
 25  END;
 26  /
Name: Kenny Ratmans
City: South Park
State: NC
Phone: 9015680902
Email: ratboy@msn.net
Invalid Lastname







PL/SQL procedure successfully completed.

SQL> -- #7-6
SQL> CREATE OR REPLACE PACKAGE tax_rate_pkg
  2    IS
  3    pv_tax_nc CONSTANT NUMBER := .035;
  4    pv_tax_tx CONSTANT NUMBER := .05;
  5    pv_tax_tn CONSTANT NUMBER := .02;
  6  END;
  7  /

Package TAX_RATE_PKG compiled

SQL> BEGIN
  2    DBMS_OUTPUT.PUT_LINE('nc: '||tax_rate_pkg.pv_tax_nc);
  3    DBMS_OUTPUT.PUT_LINE('tx: '||tax_rate_pkg.pv_tax_tx);
  4    DBMS_OUTPUT.PUT_LINE('tn: '||tax_rate_pkg.pv_tax_tn);
  5  END;
  6  /
nc: .035
tx: .05
tn: .02


PL/SQL procedure successfully completed.

SQL> -- #7-7
SQL> CREATE OR REPLACE PACKAGE tax_rate_pkg
  2    IS
  3    CURSOR cur_tax IS
  4      SELECT state, taxrate
  5        FROM bb_tax;
  6    FUNCTION tax_ck
  7      (p_state IN bb_tax.state%TYPE)
  8      RETURN NUMBER;
  9  END tax_rate_pkg;
 10  /

Package TAX_RATE_PKG compiled

SQL> CREATE OR REPLACE PACKAGE BODY tax_rate_pkg
  2    IS
  3    FUNCTION tax_ck
  4      (p_state IN bb_tax.state%TYPE)
  5      RETURN NUMBER
  6    IS
  7      lv_taxrate bb_tax.taxrate%TYPE :=0;
  8  BEGIN
  9    FOR tax_rec IN cur_tax LOOP
 10      IF tax_rec.state = p_state THEN
 11        lv_taxrate := tax_rec.taxrate;
 12        RETURN lv_taxrate;
 13        EXIT;
 14      END IF;
 15    END LOOP;
 16    END;
 17  END tax_rate_pkg;
 18  /

Package Body TAX_RATE_PKG compiled

SQL> -- ANON BLOCK
SQL> DECLARE
  2      lv_rate bb_tax.taxrate%TYPE;
  3  BEGIN
  4      lv_rate := tax_rate_pkg.tax_ck('NC');
  5      DBMS_OUTPUT.PUT_LINE('NC: '||lv_rate);
  6  END;
  7  /
NC: .03


PL/SQL procedure successfully completed.

SQL> --#7-8
SQL> CREATE OR REPLACE PACKAGE login_pkg
  2    IS
  3    usr_log_time DATE;
  4    pv_id_num NUMBER(3);
  5    FUNCTION login_ck_pf 
  6      (p_user IN VARCHAR2,
  7       p_pass IN VARCHAR2)
  8       RETURN CHAR;
  9  END;
 10  /

Package LOGIN_PKG compiled

SQL> CREATE OR REPLACE PACKAGE BODY login_pkg
  2    IS
  3    FUNCTION login_ck_pf
  4      (p_user IN VARCHAR2,
  5       p_pass IN VARCHAR2)
  6    RETURN CHAR
  7    IS
  8      lv_ck_txt CHAR(1) := 'N';
  9      lv_id_num NUMBER(5);
 10  BEGIN
 11    SELECT idShopper
 12      INTO lv_id_num
 13      FROM bb_shopper
 14      WHERE username = p_user
 15        AND password = p_pass;
 16        lv_ck_txt := 'Y';
 17        pv_id_num := lv_id_num;
 18    RETURN lv_ck_txt;
 19  EXCEPTION
 20    WHEN NO_DATA_FOUND THEN
 21      RETURN lv_ck_txt;
 22     END;
 23  BEGIN
 24     usr_log_time := SYSDATE;
 25  END;
 26  /

Package Body LOGIN_PKG compiled

SQL> -- ANON BLOCK
SQL> DECLARE
  2      lv_usr bb_shopper.username%TYPE := 'kids2';
  3      lv_pwd bb_shopper.password%TYPE := 'steel';
  4  BEGIN
  5  DBMS_OUTPUT.PUT_LINE('user: '||lv_usr);
  6  DBMS_OUTPUT.PUT_LINE('password: '||lv_pwd);
  7  DBMS_OUTPUT.PUT_LINE('LOGIN TIME: '||TO_CHAR(login_pkg.usr_log_time,
  8      'MM/DD/YYYY HH:MM:SS'));
  9  END;
 10  /
user: kids2
password: steel
LOGIN TIME: 12/02/2020 07:12:58


PL/SQL procedure successfully completed.

SQL> spool off
