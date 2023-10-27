spool C:\Users\jnvg9\OneDrive\Escritorio\salidasbases\salida.txt

--clear screen;
set linesize 150
set PAGESIZE 99
set COLSEP '|*|'

--Borrar tablas
DROP TABLE l_c CASCADE CONSTRAINT;
DROP TABLE a_c CASCADE CONSTRAINT;
DROP TABLE coustomer CASCADE CONSTRAINT;
DROP TABLE coustomer CASCADE CONSTRAINT;
DROP TABLE loan CASCADE CONSTRAINT;
DROP TABLE account CASCADE CONSTRAINT;
DROP TABLE bank_branch CASCADE CONSTRAINT;
DROP TABLE bank CASCADE CONSTRAINT;

--Tablas
CREATE TABLE bank(
    code NUMBER(20),
    nombre VARCHAR(45),
    addr VARCHAR(10)
);

CREATE TABLE bank_branch(
    branch_no NUMBER(20),
    code VARCHAR(20),
    addr VARCHAR(10)
);

CREATE TABLE account(
    acct_no NUMBER(20),
    branch_no NUMBER(20),
    balance VARCHAR(45),
    tipo VARCHAR(45)
);

CREATE TABLE loan(
    loan_no NUMBER(20),
    branch_no NUMBER(20),
    amount VARCHAR(45),
    tipo VARCHAR(45)
);

CREATE TABLE coustomer(
    ssn NUMBER(20),
    name VARCHAR(45),
    phone NUMBER(20),
    addr VARCHAR(10)
);

--Relaciones
CREATE TABLE a_c(
    acct_no NUMBER(20),
    ssn NUMBER(20)
);

CREATE TABLE l_c(
    loan_no NUMBER(20),
    ssn NUMBER(20)
);

--Restricciones de las tablas
ALTER TABLE  bank
ADD CONSTRAINT code_PK PRIMARY KEY (code);

ALTER TABLE bank_branch
ADD CONSTRAINT branch_no_PK PRIMARY KEY (branch_no);

ALTER TABLE account
ADD CONSTRAINT acct_no_PK PRIMARY KEY (acct_no);

ALTER TABLE loan
ADD CONSTRAINT loan_no_PK PRIMARY KEY (loan_no);

ALTER TABLE coustomer
ADD CONSTRAINT ssn_PK PRIMARY KEY (ssn);

--Restricciones de las relaciones
ALTER TABLE bank_branch
ADD CONSTRAINT code_FKBB FOREIGN KEY (code) REFERENCES bank(code);

ALTER TABLE account
ADD CONSTRAINT branch_no_FK FOREIGN KEY (branch_no) REFERENCES bank_branch(branch_no);

ALTER TABLE loan
ADD CONSTRAINT branch_no_FKL FOREIGN KEY (branch_no) REFERENCES bank_branch(branch_no);

ALTER TABLE a_c
ADD CONSTRAINT acct_no_FKAC FOREIGN KEY (acct_no) REFERENCES account(acct_no);

ALTER TABLE l_c
ADD CONSTRAINT loan_noFKLC FOREIGN KEY (loan_no) REFERENCES loan(loan_no);

--Insertar datos para las tablas 
INSERT INTO bank (code, nombre, addr)
VALUES (1, 'Banco1', 'Dirección1');
INSERT INTO bank (code, nombre, addr)
VALUES (2, 'Banco2', 'Dirección2');

-- Insertar datos en la tabla bank_branch
INSERT INTO bank_branch (branch_no, code, addr)
VALUES (101, 'Banco1', 'Sucursal1');
INSERT INTO bank_branch (branch_no, code, addr)
VALUES (102, 'Banco2', 'Sucursal2');

-- Insertar datos en la tabla account
INSERT INTO account (acct_no, branch_no, balance, tipo)
VALUES (1001, 101, '1000.00', 'Ahorros');
INSERT INTO account (acct_no, branch_no, balance, tipo)
VALUES (1002, 102, '2500.00', 'Corriente');

-- Insertar datos en la tabla loan
INSERT INTO loan (loan_no, branch_no, amount, tipo)
VALUES (2001, 101, '5000.00', 'Préstamo Hipotecario');
INSERT INTO loan (loan_no, branch_no, amount, tipo)
VALUES (2002, 102, '8000.00', 'Préstamo Personal');

-- Insertar datos en la tabla coustomer
INSERT INTO coustomer (ssn, name, phone, addr)
VALUES (123456789, 'Juan Pérez', '555-555-5555', 'Calle Principal 123');
INSERT INTO coustomer (ssn, name, phone, addr)
VALUES (987654321, 'Maria Garcia', '555-123-4567', 'Avenida Principal 456');

-- Insertar datos en la tabla de relación a_c (cuenta a cliente)
INSERT INTO a_c (acct_no, ssn)
VALUES (1001, 123456789);
INSERT INTO a_c (acct_no, ssn)
VALUES (1002, 987654321);

-- Insertar datos en la tabla de relación l_c (préstamo a cliente)
INSERT INTO l_c (loan_no, ssn)
VALUES (2001, 123456789);

INSERT INTO l_c (loan_no, ssn)
VALUES (2002, 987654321);

--Desplega las tablas
SELECT * FROM bank;
SELECT * from bank_branch;
SELECT * from account;
SELECT * from loan;
SELECT * from coustomer;
SELECT * from a_c;
SELECT * from l_c;

--Da formato a la salida de datos 
rem desplegar por TABLE_NAME & CONSTRAINT
col owner FORMAT A12
col CONSTRAINT_NAME FORMAT A31
col CONSTRAINT_TYPE FORMAT A10
col table_name FORMAT A25
col status  FORMAT A10

--Despliega las restricciones 
SELECT owner, CONSTRAINT_NAME,
    CONSTRAINT_TYPE, status
    from user_constraints
    where table_name in ('BANK', 'BANK_BRANCH', 'ACCOUNT', 'LOAN', 'COUSTOMER', 'A_C', 'L_C');

spool off