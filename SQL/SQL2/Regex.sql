SELECT dummy
FROM   dual
WHERE  REGEXP_LIKE('abcdefxydef', '(abc(def))xy\2');

SELECT first_name,
       last_name
FROM   employees
WHERE  REGEXP_LIKE(first_name, '^Ste(v|ph)en$');

SELECT LAST   NAME,
       REGEXP REPLACE(phone NUMBER, '\.', '-') AS phone
FROM   employees;

SELECT street_address,
       REGEXP_INSTR(street_address, '[[:alpha:]]') AS First_Alpha_Position
FROM   locations;

SELECT REGEXP_SUBSTR(street_address, ' [^ ]+ ') AS Road
FROM   locations;

SELECT REGEXP_INSTR('0123456789', -- source char or search value
                    '(123)(4(56)(78))', -- regular expression patterns
                    1, -- position to start searching
                    1, -- occurrence
                    0, -- return option
                    'i', -- match option (case insensitive)
                    1) -- subexpression on which to search
       "Position"
FROM   dual;

SELECT REGEXP_INSTR('ccacctttccctccactcctcacgttctcacctgtaaagcgtccctc
cctcatccccatgcccccttaccctgcagggtagagtaggctagaaaccagagagctccaagc
tccatctgtggagaggtgccatccttgggctgcagagagaggagaatttgccccaaagctgcc
tgcagagcttcaccacccttagtctcacaaagccttgagttcatagcatttcttgagttttca
ccctgcccagcaggacactgcagcacccaaagggcttcccaggagtagggttgccctcaagag
gctcttgggtctgatggccacatcctggaattgttttcaagttgatggtcacagccctgaggc
atgtaggggcgtggggatgcgctctgctctgctctcctctcctgaacccctgaaccctctggc
taccccagagcacttagagccag',
                     '(gtc(tcac)(aaag))',
                     1,
                     1,
                     0,
                     'i',
                     1) "Position"
FROM   dual;

SELECT REGEXP_SUBSTR('acgctgcactgca', -- source char or search value
                     'acg(.*)gca', -- regular expression patternn 1, -- position to start searching
                     1, -- position to start searching
                     1, -- occurrence
                     'i', -- match option (case insensitive)
                     1) -- sub-expression
       "Value"
FROM   dual;

SELECT REGEXP_COUNT('ccacctttccctccactcctcacgttctcacctgtaaagcgtccctccctcatccccatgcccccttaccctgcag
ggtagagtaggctagaaaccagagagctccaagctccatctgtggagaggtgccatccttgggctgcagagagaggag
aatttgccccaaagctgcctgcagagcttcaccacccttagtctcacaaagccttgagttcatagcatttcttgagtt
ttcaccctgcccagcaggacactgcagcacccaaagggcttcccaggagtagggttgccctcaagaggctcttgggtc
tgatggccacatcctggaattgttttcaagttgatggtcacagccctgaggcatgtaggggcgtggggatgcgctctg
ctctgctctcctctcctgaacccctgaaccctctggctaccccagagcacttagagccag',
                     'gtc') AS COUNT
FROM   dual;

SELECT REGEXP_COUNT('123123123123', -- source char or search value
                    '123', -- regular expression pattern
                    2, -- position where the search should start
                    'i') -- match option (case insensitive)
       AS COUNT
FROM   dual;

--------------------------------------------

ALTER TABLE emp8 ADD CONSTRAINT email_addr CHECK(REGEXP_LIKE(email, '@')) NOVALIDATE;

INSERT INTO emp8
VALUES
  (500,
   'Christian',
   'Patel',
   'ChrisP2creme.com',
   1234567890,
   '12-Jan-2004',
   'HR_REP',
   2000,
   NULL,
   102,
   40);
