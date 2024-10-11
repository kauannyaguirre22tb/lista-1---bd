use db_atividade_view;

-- 1. Exibir lista de alunos e seus cursos
CREATE VIEW alunos_cursos AS
SELECT a.nome, d.nome AS disciplina, c.nome AS curso
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
JOIN disciplina d ON m.id_disciplina = d.id_disciplina
JOIN curso c ON d.id_curso = c.id_curso;

-- 2. Exibir total de alunos por disciplina
CREATE VIEW total_alunos_disciplina AS
SELECT d.nome, COUNT(m.id_aluno) AS total_alunos
FROM disciplina d
JOIN matricula m ON d.id_disciplina = m.id_disciplina
GROUP BY d.nome;

-- 3. Exibir alunos e status das suas matrículas
CREATE VIEW alunos_status_matricula AS
SELECT a.nome, d.nome AS disciplina, m.status
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
JOIN disciplina d ON m.id_disciplina = d.id_disciplina;

-- 4. Exibir professores e suas turmas
CREATE VIEW professores_turmas AS
SELECT p.nome, d.nome AS disciplina, t.semestre, t.horario
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
JOIN disciplina d ON t.id_disciplina = d.id_disciplina;

-- 5. Exibir alunos maiores de 20 anos
CREATE VIEW alunos_maior_20 AS
SELECT a.nome, a.data_nascimento
FROM aluno a
WHERE TIMESTAMPDIFF(YEAR, a.data_nascimento, CURDATE()) > 20;

-- 6. Exibir disciplinas e carga horária total por curso
CREATE VIEW disciplinas_carga_horaria AS
SELECT c.nome AS curso, COUNT(d.id_disciplina) AS total_disciplinas, SUM(c.carga_horaria) AS carga_horaria_total
FROM curso c
JOIN disciplina d ON c.id_curso = d.id_curso
GROUP BY c.nome;

-- 7. Exibir professores e suas especialidades
CREATE VIEW professores_especialidades AS
SELECT p.nome, p.especialidade
FROM professor p;

-- 8. Exibir alunos matriculados em mais de uma disciplina
CREATE VIEW alunos_multi_disciplina AS
SELECT a.nome
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
GROUP BY a.nome
HAVING COUNT(m.id_disciplina) > 1;

-- 9. Exibir alunos e o número de disciplinas que concluíram
CREATE VIEW alunos_disciplinas_concluidas AS
SELECT a.nome, COUNT(m.id_disciplina) AS total_disciplinas_concluidas
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
WHERE m.status = 'Concluído'
GROUP BY a.nome;

-- 10. Exibir todas as turmas de um semestre específico
CREATE VIEW turmas_semestre AS
SELECT t.semestre, t.horario, d.nome AS disciplina, p.nome AS professor
FROM turma t
JOIN disciplina d ON t.id_disciplina = d.id_disciplina
JOIN professor p ON t.id_professor = p.id_professor
WHERE t.semestre = '2024.1';

-- 11. Exibir alunos com matrículas trancadas
CREATE VIEW alunos_matriculas_trancadas AS
SELECT a.nome
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
WHERE m.status = 'Trancado';

-- 12. Exibir disciplinas que não têm alunos matriculados
CREATE VIEW disciplinas_sem_alunos AS
SELECT d.nome
FROM disciplina d
LEFT JOIN matricula m ON d.id_disciplina = m.id_disciplina
WHERE m.id_disciplina IS NULL;

-- 13. Exibir a quantidade de alunos por status de matrícula
CREATE VIEW alunos_status_matricula_total AS
SELECT m.status, COUNT(m.id_aluno) AS total_alunos
FROM matricula m
GROUP BY m.status;

-- 14. Exibir o total de professores por especialidade
CREATE VIEW professores_especialidade_total AS
SELECT p.especialidade, COUNT(p.id_professor) AS total_professores
FROM professor p
GROUP BY p.especialidade;

-- 15. Exibir lista de alunos e suas idades
CREATE VIEW alunos_idades AS
SELECT a.nome, TIMESTAMPDIFF(YEAR, a.data_nascimento, CURDATE()) AS idade
FROM aluno a;

-- 16. Exibir alunos e suas últimas matrículas
CREATE VIEW alunos_ultimas_matriculas AS
SELECT a.nome, MAX(m.data_matricula) AS ultima_matricula
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
GROUP BY a.nome;

-- 17. Exibir todas as disciplinas de um curso específico
CREATE VIEW disciplinas_curso AS
SELECT d.nome AS disciplina
FROM disciplina d
JOIN curso c ON d.id_curso = c.id_curso
WHERE c.nome = 'Engenharia de Software';

-- 18. Exibir os professores que não têm turmas
CREATE VIEW professores_sem_turmas AS
SELECT p.nome
FROM professor p
LEFT JOIN turma t ON p.id_professor = t.id_professor
WHERE t.id_professor IS NULL;

-- 19. Exibir lista de alunos com CPF e email
CREATE VIEW alunos_cpf_email AS
SELECT a.nome, a.cpf, a.email
FROM aluno a;

-- 20. Exibir o total de disciplinas por professor
CREATE VIEW professores_disciplinas_total AS
SELECT p.nome, COUNT(t.id_disciplina) AS total_disciplinas
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
GROUP BY p.nome;