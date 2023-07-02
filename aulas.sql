/**************************************CAPITULO SELECT**************************************/
SELECT * FROM TAB;

SELECT * FROM DEPT;

SELECT * FROM EMP;

/**************************************CAPITULO INSERT**************************************/

SELECT * FROM DEPT;

INSERT INTO DEPT(dname,loc,deptno) VALUES('COMPRAS','LONDRINA','60');

desc dept /*verifica as colunas do banco*/

/* 1 - FORMA SCHEMA COM DBA*/
INSERT INTO TI_LUIZ_GALEGO.DEPT(dname,loc,deptno) VALUES('EXP','CURITIBA',70); 
COMMIT;

/* 2 - FORMA SCHEMA CONCEDENDO PRIVILEGIO*/
GRANT INSERT ON DEPT TO TI_LUIZ_GALEGO;

/*SUBQUERY*/

/*CRIANDO TABELA*/
CREATE TABLE DEPT_OLD(
CODIGO NUMBER(4),
NOME  VARCHAR2(40),
LOCAL VARCHAR2(40));

/*inserindo dados na tabela*/
INSERT INTO dept_old(codigo,nome,local)
    select deptno,
           dname,
           loc
    from dept;
    
select * from DEPT_OLD;


/******************************************************************/
/*              27-05-2023                                        */
/******************************************************************/
INSERT INTO EMP
(ename,empno,job,mgr,hiredate,sal,deptno)
VALUES('SAMANTA','103','ANALISTA',110,sysdate-30,1500,20);

INSERT INTO dept (deptno,dname, loc)
VALUES(99,'Financeiro','Curitiba');

INSERT INTO dept
VALUES (51,'PRODUCAO','MARINGA');

INSERT INTO emp(empno,ename,job,sal,comm,deptno)
VALUES(7890,'JINKS','CLERK',1.2E3,NULL,40);

INSERT INTO dept(deptno,dname,loc)
VALUES(&dept_num,'&dept_nome','&localizacao');

/**************************************CAPITULO UPDATE**************************************/
/*aumento sal�rio de 10% para o scott*/
UPDATE emp
SET job = 'VENDEDOR'
sal = sal*1.1 /*AUMENTO DE 10%*/
WHERE ename = 'SCOTT';

/*NULO COMISSAO DE CARGOS SALEMAN)*/
UPDATE emp
SET COMM = NULL
WHERE JOB = 'SALESMAN';

/*COMISSAO DE R$ 1000,00 PARA EMPNO=7499*/
UPDATE emp
SET COMM = 1000
WHERE EMPNO = 7499;

/*DOBRAR TODOS OS SALARIOS DE TODOS OS EMPREGADOS DO DEPARTAMENTO 20
E TRANSFERI-LO PARA O DEPARTAMENTO 30*/
UPDATE EMP
SET SAL = 2*SAL, DEPTNO = 30
WHERE DEPTNO = 20;

/*ATUALIZAR O SALARIO DO FUNCIONARIO 7902*/
UPDATE EMP 
SET SAL = 7100
WHERE EMPNO = 7902;

/*PARA DAR 10% DE AUMENTO PARA TODOS OS FUNCIONARIOS
QUE TRABLHAM NO DEPARTAMENTO 10*/
UPDATE EMP
SET SAL = 1.10*SAL
WHERE DEPTNO = 10;

/*PROMOVER JONES A GERENTE DO DEPARTAMENTO 20 COM UM SALARIO
DE R$1.000,00 (ASSSSUMINDO SOMENTE QUE TENHA JONES)*/
UPDATE EMP
SET JOB = 'MANAGER', SAL = 1000, DEPTNO = 20
WHERE ENAME = 'JONES';

/**************************************CAPITULO DELETE**************************************/
/*REMOVER EMREGADO 7369*/
DELETE EMP WHERE EMPNO = 7369;


/*TODOS OS EMPREGADOS DO DEPARTAMENTO 20*/
DELETE EMP WHERE DEPTNO = 20;

/*REMOVER TODOS OS EMPREGADOS*/
DELETE EMP;

/*REMOVER EMPREGADO 7934*/
DELETE EMP WHERE EMPNO = 7934;

/*REMOVER TODOS OS EMPREGADOS ADMITIDOS A PARTIR DE 1989*/
DELETE EMP
WHERE HIREDATE>= '01-JAN-1989';

/*APAGAR TODOS OS EMPREGADOS QUE TENHAM PROFISSSAO
SALESMAN E COMISSAO MENOR DO QUE R$ 100,00*/
DELETE EMP
WHERE JOB = 'SALESMAN'
AND COMM < 100;

/* EXERCICIOS*/
/*01 - INSIRA DADOS SOBRE VOCE E ALGUM MEMBRO DA SUA FAMILIA NA TABELA EMP*/
INSERT INTO EMP(ename,empno,job,mgr,hiredate,sal,deptno)
VALUES('LUCAS','889','ANALISTA',110,SYSDATE-30,3500,20);

INSERT INTO EMP(ename,empno,job,mgr,hiredate,sal,deptno)
VALUES('MALU','890','ANALISTA',110,SYSDATE-30,2700,20);

/*02 - CONSULTE SEU NOME E A DATA DE ADMISSAO DAS PESSSOAS CADASTRADAS*/
/*MEU NOME*/
SELECT * FROM EMP
WHERE ENAME = 'LUCAS';

/*DATA DE ADMISSSAO DAS PESSOAS CADATRADAS*/
SELECT HIREDATE FROM EMP;

/*03 - SOMENTE O MEU SALARIO*/
SELECT SAL FROM EMP
WHERE EMPNO = 889;

/*04 - DOBRAR O SALARIO DO FUNCIONARIO DE NUMERO 7566*/
UPDATE EMP
SET SAL = 2*SAL 
WHERE EMPNO = 7566;



/*05 - REMOVER OS EMPREGADOS QUE POSSUEM COMISSAO MAIOR QUE
O PROPRIO SALARIO*/
DELETE FROM EMP
WHERE COMM >SAL; 


/******************************************************************/
/*             CONSULTAS B�SICAS                                  */
/******************************************************************/


/*********OPERADORES ARITM�TICOS *****/
/*NVL - FUNCAO ORACLE*/
SELECT EMPNO NR_EMPREGADO,
       ENAME NM_EMPREGADO,
       HIREDATE DT_EMPREGADO,
       SAL SAL_MENSAL_EMPREGADO,
       COMM COMM_MENSAL_EMPREGADO,
       (SAL + NVL(COMM,0))*13  "SAL�RIO_ANUAL"
 FROM  EMP;
 

 /*DATA*/
SELECT TO_CHAR(SYSDATE, 'DD/MM/YY HH24:MI:SS') FROM DUAL;

/*LENGHT*/
SELECT LENGTH(ENAME) +
       LENGTH(JOB) "COMPRIMENTO TOTAL"
 FROM  EMP;
 
/*********OPERADORES CARACTERES *****/
SELECT UPPER('O Funcion�rio ' ||ename|| ' trabalha no depto '||deptno||' e ganha R$'||sal) FRASE
 FROM EMP;
 
/*SYSDATE*/
SELECT ENAME,
      TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)) MESES
    FROM EMP
  WHERE COMM > SAL*0.50;
  
/*EXEMPLO PARA ANOS DE TRABALHO*/
SELECT ENAME,
      TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12) ANOS
    FROM EMP;
--WHERE COMM > SAL*0.50;


/******* 03-06-2023**********/
/*OPERADORE DE COMPARA��O*/

/*IN OU NOT IN*/
SELECT * FROM EMP
    WHERE DEPTNO NOT IN (10,30);

/*BETWEEN*/
SELECT * FROM EMP
    WHERE SAL BETWEEN 2000 AND 3000;

/*MAL USO*/
SELECT * FROM EMP
    WHERE SAL >= 2000
    AND   SAL <= 3000;
    
/*BETWEEN NOT */
SELECT * FROM EMP
    WHERE SAL NOT BETWEEN 2000 AND 3000;

/*NULO*/
SELECT * FROM EMP
    WHERE COMM IS NULL;

SELECT * FROM EMP
    WHERE COMM IS NOT NULL;

/*OPERADORES L�GICOS*/

--AND
SELECT EMPNO,
       ENAME,
       SAL
  FROM EMP
WHERE  DEPTNO IN (10,20)
    AND SAL > 2000;
    
--OR
SELECT EMPNO,
       ENAME,
       DEPTNO,
       SAL
  FROM EMP
WHERE  DEPTNO IN(10,20)
    OR SAL > 2000;

/*SUBSTITUI��O DE VARI�VEIS*/

--UPPER
SELECT ENAME, SAL
 FROM  EMP
 WHERE UPPER(ENAME) = UPPER('&nome_do_funcionario');
 

--LOWER
SELECT ENAME, SAL
 FROM  EMP
 WHERE LOWER(ENAME) = LOWER('&nome_do_funcionario');
 
--INITCAP
SELECT UPPER('lucas'),
       LOWER('LUCAS'),
       INITCAP('lucas stefano')
 FROM DUAL;

/*ORDENA��O DE RESULTADOS*/
--ROWID

--PRIMEIRO TIPO DE ORDER BY: ASC
SELECT * 
  FROM EMP
ORDER BY ENAME;

/*** Exemplos ***/
/*01: Retorne o nome, sal�rio multiplicado por 12 e n�mero do departamento em 
ordem alfab�tica*/
SELECT ENAME,
       JOB,
       SAL*12,
       DEPTNO
 FROM  EMP
 ORDER BY ENAME;

/*02: Listar funcion�rios em ordem alfab�tica*/       
SELECT ENAME,
       JOB,
       SAL
 FROM  EMP
 ORDER BY ENAME; --POR PADR�O VEM ASC NO ORACLE

/*03: Lisstar os empregados em ordem decrescente de sal�rio, por cargo*/
SELECT ENAME,
       JOB,
       SAL
 FROM  EMP
 WHERE JOB IN ('ANALYST','SALESMAN','MANAGER')
 ORDER BY JOB,
          SAL DESC;

/*04: Usando express�es ou referencias a posi��o de expresssoes no SELECT
como argumento de ORDER BY*/
SELECT ENAME,
       JOB,
       LENGTH(JOB) JOB_2,
       SAL
 FROM  EMP
 WHERE JOB IN ('ANALYST','SALESMAN','MANAGER')
 ORDER BY 3, SAL + NVL(COMM,0) DESC;



/******** CL�USULA GROUP BY ********/

--FUN��O DE AGRUPAMENTO: AVG
SELECT JOB,
       AVG(SAL)
  FROM EMP
GROUP BY JOB;

/*AGRUPAMENTO MAIS LINHAS*/
SELECT JOB,
       DEPTNO,
       AVG(SAL)
 FROM  EMP
GROUP BY DEPTNO,
         JOB;

-- FUN��O DE AGRUPAMENTO MIN E MAX:
SELECT DEPTNO,
       MIN(SAL),
       MAX(SAL)
 FROM  EMP
 GROUP BY DEPTNO;
 
/*MENOR E MAIOR SAL�RIO PARA OS FUNCIONA�RIOSS QUE TEM COMO PROFISSAO
CLERK, POR DEPARTAMENTO*/
SELECT DEPTNO,
       MIN(SAL),
       MAX(SAL)
 FROM  EMP
WHERE JOB = 'CLERK'
GROUP BY DEPTNO;

--FUN��O DE AGRUPAMENTO: COUNT
SELECT DEPTNO,
       COUNT(*) 
 FROM  EMP
GROUP BY DEPTNO;

/******** CL�USULA HAVING ********/

/*01: Especificando quais grupos ser�o exibidos:*/
SELECT DEPTNO, 
       ROUND(AVG(SAL),2)
 FROM  EMP
GROUP BY DEPTNO
HAVING COUNT(*) >3;

/*02: MENOR E MAIOR SAL�RIO PARA OS FUNCION�RIOSS QUE TEM COMO PROFISS�O
CLERK POR DEPARTAMENTO, TENDO O MENOR SAL�RIO MENOR DO QUE 1000.*/
SELECT DEPTNO,
       MIN(SAL),
       MAX(SAL)
 FROM  EMP
GROUP BY DEPTNO
HAVING MIN(SAL) <1000;
       
/*03: A SOMA DOS SAL�RIOS PARA OS CARGOS ONDE A M�DIA DE SAL�RIOS � MAIOR
QUE 1500*/
SELECT JOB,
       SUM(SAL),
       MAX(SAL)
 FROM  EMP
GROUP BY JOB
HAVING AVG(SAL) > 1500


/******** OPERA��ES DE CONJUNTO ********/
--UNION
SELECT DEPTNO
FROM DEPT
UNION
SELECT DEPTNO
FROM   EMP;

--UNION ALL
SELECT DEPTNO
FROM DEPT
UNION ALL
SELECT DEPTNO
FROM   EMP;

/*EXEMPLO*/
SELECT DEPTNO,
       DNAME,
       LOC,
       TO_NUMBER(NULL) SAL
 FROM  DEPT
UNION ALL
SELECT EMPNO,
       ENAME,
       TO_CHAR(NULL),
       SAL
FROM EMP;

/******** JUN��O DE TABELAS ********/
SELECT DNAME,
       ENAME
 FROM  DEPT,
       EMP
ORDER BY 1,2;

SELECT * FROM DEPT;

SELECT * FROM EMP;

/*RESOLVENDO O CARTESIANO*/
SELECT DEPT.DNAME,
       DEPT.DEPTNO,
       EMP.ENAME,
       EMP.SAL
 FROM  DEPT,
       EMP
WHERE  DEPT.DEPTNO = EMP.DEPTNO
ORDER BY 1,2;

/*01: COMBINANDO DIVERSAS OP��ES NO MESMO COMANDO SQL:*/
SELECT DNAME,
       GRADE,
       COUNT(*)
 FROM  EMP,
       DEPT,
       SALGRADE
WHERE  EMP.DEPTNO = DEPT.DEPTNO
 AND   SAL BETWEEN LOSAL AND HISAL
GROUP BY DNAME, GRADE
HAVING SUM(SAL) > 1200
ORDER BY DNAME, COUNT(*) DESC;

/*RETORNAR O NOME, CARGO E NUMERO DO DEPARTAMENTO*/
SELECT ENAME,
       DEPT.DEPTNO,
       DNAME
 FROM  EMP,
       DEPT
WHERE  EMP.DEPTNO = DEPT.DEPTNO;

/*RETORNAR NOME, CARGO, NUMERO DO DEPARTAAMENTO DOS EMPREGADOSS E O NOME
DE TODOS OS FUNCIONARIOSS CLERKS*/
SELECT ENAME,
       JOB,
       DEPT.DEPTNO,
       DNAME
 FROM  EMP,DEPT
WHERE  EMP.DEPTNO = DEPT.DEPTNO
 AND   JOB = 'CLERK';
  
/*********** EXERCICIOS **********/
/*01: CONSULTE O NOME, O LOCAL DO DEPARTAMENTO, O SAL�RIO POR HORA(ASSUMINDO
160 HORA/M�S) E O TOTAL MENSAL (SAL�RIO + COMISS�O) DOS VENDEDORES DA 
TABELA EMP*/
SELECT ENAME,
       DEPTNO,
       EMPNO,
       SAL,
       SUM(SAL + COMM) TOTAL_MENSAL
 FROM  EMP
GROUP BY EMPNO;

/*02: MODIFIQUE O EXERCICIO ANTERIOR DE FORMA A ORDENAR O RESULTADO
EM ORDEM DECRESCENTE DO SAL�RIO POR HORA.*/


/*03: DESCOBRA O MENOR SAL�RIO DE TODOS OS EMPREGADOS*/
SELECT ENAME,
       MIN(SAL)
FROM EMP
GROUP BY SAL;

SELECT * FROM EMP;


/*04: OBTENHA A SOMA DOS SAL�RIOS DOSS EMPREGADOS QUE N�O TRABALHAM
NOS DEPARTAMENTO 10 OU 30.*/

/*05: OBTENHA O NOME E A M�DIA SALARIAL DOS DEPARTAMENTOS (EXCETO O 10), CUJO
MAIOR SAL�RIO SEJA INFERIOR A 4000*/

/*06: OBTENHA A M�DIA DO SAL�RIO PARA CADA FAIXA SALARIAL*/



/*********** 01/07/2023 **********/
/* Consultas Encaixadas*/
/*Exemplo 01: Empregado que ganham mais que a m�dia*/
SELECT empno, ename, sal
FROM   emp
WHERE sal > (SELECT AVG(SAL) FROM emp);

/*Exemplo 02: Quais funcion�rios trabalham com o SCOTT*/
SELECT ename,deptno
FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SCOTT');

/*Exemplo 03: Quais os departamentos que n�o tem empregado*/
SELECT deptno, dname
FROM dept
WHERE deptno NOT IN (SELECT DISTINCT deptno FROM emp);

/*Exemplo 04: Funcion�rio com o maior sal�rio*/
SELECT ename, job
FROM emp
WHERE sal = (SELECT max(sal) FROM emp);

/*Exemplo 05: Funcion�rios com o maior sal�rio*/
SELECT ename, job, deptno
FROM emp
WHERE sal IN (SELECT MAX(sal) FROM emp
              GROUP BY deptno);
              
/* Exemplo 06: Recuperar os empregados que ganham mais que a m�dia de
sal�rio do seu departamento*/
SELECT deptno, ename, sal
FROM emp x
WHERE sal > (SELECT AVG(sal) FROM emp y
              WHERE x.deptno = y.deptno)
ORDER BY deptno;

/*Exemplo 07: Nomes dos funcion�rios que s�o chefes de algu�m*/
SELECT ename, job, deptno
FROM emp x
WHERE EXISTS (SELECT 'x' FROM emp y
              WHERE x.empno = y.mgr);
/****************************************/
/***Teste outra alternativa para o teste*/
SELECT 1 
FROM emp
WHERE empno = 7369;
/***************************************/

/*Exemplo 08: Eliminar oss empregados mais novos de cada departamento*/
DELETE emp e
WHERE hiredate = (SELECT MAX(hiredate) FROM emp
                    WHERE deptno = e.deptno);
                    
/* Exemplo 09: Todos os empregados mais novos de cada cargo ganhem o melhor
sal�rio e a m�dia das comisss�es de seu cargo*/
UPDATE emp e
SET (sal, comm) = (SELECT MAX(sal), AVG(comm) FROM emp
                    WHERE job = e.job)
WHERE hiredate = (SELECT MAX(hiredate) FROM emp
                    WHERE job = e.job);
                    
/*************************** CONSULTAS HIERARQUICAS ************************/
/*Exemplo 01: Todo os superiores do SCOTT*/
SELECT empno, ename, job
FROM emp
WHERE ename <> 'SCOTT'
CONNECT BY empno = PRIOR mgr /*PRIOR INDICA O SENTIDO DA CONSULTA*/
START WITH ename = 'SCOTT';

/*Exemplo 02: O nome do Presidente e de seus subordinados, exceto aqueles 
que s�o tamb�m subordinados de Jones*/
SELECT empno, ename, job
FROM emp
CONNECT BY PRIOR empno = mgr AND mgr <> 7566
START WITH job = 'PRESIDENT';

/*Exemplo 03: N�vel de cada regitro na hierarquia*/
SELECT LEVEL, LPAD(' ',2*LEVEL)| | ename nome
 FROM emp
CONNECT BY PRIOR empno = mgr
START WITH job = 'PRESIDENT';


/**** EXERC�CIOS ****/
/* Exerc�cio 01: 
Conulte o nome dos chefes (NOME_CHEFE) dos funcion�rios
(ENAME) da tabela EMP, ordenados por NOME_CHEF. Caso algum funcion�rio,
n�o possua chefe, mostre a cadeia de caracteres '_____' em NOME_CHEFE.*/
SELECT e.ename nm_empregado,
       NVL(c.ename,'-----') nm_chefe
 FROM  emp e,
       emp c
WHERE  c.empno(+) = e.mgr;

/*Exerc�cio 02:
Consulte os nomes e sal�rios do funcion�rios que est�o na mesma faixa
salarial que seus chefes*/
SELECT e.ename  nm_empregado,
       e.sal    sal_empregado,
       se.grade grade_empregado,
       c.ename  nm_chefe,
       c.sal    sal_chefe
 FROM   emp e, 
        salgrade se,
        emp c 
WHERE e.sal BETWEEN se.losal AND se.hisal
  AND c.empno = e.mgr
  AND c.sal BETWEEN se.losal AND se.hisal;

-- SEGUNDA FORMA DE RESOLU��O
select e.ename   nm_empregado,
       e.sal    sal_empregado,
       se.grade grade_empregado,
       c.ename  nm_chefe,
       sc.grade grade_chefe
 from emp e,
      salgrade se,
      emp c,
      salgrade sc
where e.sal between se.losal and se.hisal
and c.empno = e.mgr
and c.sal between sc.losal and sc.hisal
and se.grade = sc.grade;

/*Exerc�cio 03:
Aumente o sal�rio em 20% para os empregados que sejam os mais antigos
de seus departamentos*/
UPDATE emp
sal = sal*2.1 /*aumento de 10%*/






/*Exerc�cio 04:
Promova a diretor os empregados que recebem mais que a m�dia de seuss cargos.*/

/*Exerc�cio 05:
Desfa�a as opera��es anteriores*/

/*Exerc�cio 06:
Fa�a com que os empregados passem a ganhar o maior sal�rio dentre os companheiros
da mesma faixa*/

