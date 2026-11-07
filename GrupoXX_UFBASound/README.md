# UFBASound - Gestão de Estúdio Musical

**Universidade Federal da Bahia (UFBA)**  
**MATB09 - Laboratório de Banco de Dados**  
**Professor:** Dr. Joselito Júnior  

---

## 1. Integrantes

- Wellington Miguel de Jesus Silva (Matrícula: 222116288)
- Luan Felizola Leal (Matrícula: 224116983)
- Landerson Evangelista Miranda (Matrícula: 222116281)
- *[Nome do Integrante 3]* (Matrícula: *[Matrícula]*)

---

## 2. Descrição do Problema

O **UFBASound** é um sistema de banco de dados voltado para a gestão operacional de um estúdio de música e gravação. O estúdio necessita controlar o cadastro de artistas/bandas clientes, a disponibilidade e tarifação das salas acústicas de ensaio, o agendamento de sessões (reservas) e a locação adicional de equipamentos de áudio e instrumentos musicais vinculados a cada sessão.

---

## 3. Regras de Negócio

1. **RN01 - Identificação e Responsabilidade do Artista:** Toda reserva deve estar vinculada obrigatoriamente a um único artista responsável. Não é permitido cadastrar dois artistas com o mesmo documento de identificação (CPF/CNPJ) nem com o mesmo e-mail (`UNIQUE`).
2. **RN02 - Ocupação e Tarifação das Salas:** Uma reserva aloca uma única sala de ensaio em data e horário definidos, com duração mínima de 1 hora (`horas_duracao > 0`). O valor por hora da sala não pode ser negativo (`valor_hora >= 0`) e sua capacidade de músicos deve ser maior que zero (`capacidade_musicos > 0`).
3. **RN03 - Locação de Equipamentos e Histórico de Preço:** Uma reserva pode incluir diversos equipamentos adicionais, e um mesmo equipamento pode ser alugado em várias reservas em datas diferentes (relação N:N resolvida por `item_locacao_equipamento`). No ato da locação, registra-se a quantidade (`quantidade > 0`) e o `valor_unitario_cobrado`, preservando o valor praticado na época caso o preço de tabela do equipamento sofra reajustes futuros.

---

## 4. Instruções para Execução dos Scripts SQL

Os scripts foram desenvolvidos para execução sequencial em um banco de dados **PostgreSQL** novo e vazio:

1. Crie um banco de dados vazio no PostgreSQL (por exemplo, `ufbasound`) e conecte-se a ele.
2. Execute os arquivos exatamente na ordem abaixo:
   - **1º `01_ddl_esquema.sql`:** Cria as 5 tabelas do modelo (`artista`, `sala_ensaio`, `equipamento`, `reserva` e `item_locacao_equipamento`) com suas chaves primárias, chaves estrangeiras e restrições (`NOT NULL`, `UNIQUE`, `CHECK`).
   - **2º `02_dml_dados.sql`:** Insere 29 registros distribuídos entre as tabelas, contemplando artista com múltiplas reservas e artistas/salas sem reservas para validação das junções.
   - **3º `03_dql_consultas.sql`:** Executa as quatro consultas obrigatórias de negócio (`Q1` a `Q4`).

Via terminal (`psql`), dentro da pasta dos arquivos:
```bash
psql -U postgres -c "CREATE DATABASE ufbasound;"
psql -U postgres -d ufbasound -f 01_ddl_esquema.sql
psql -U postgres -d ufbasound -f 02_dml_dados.sql
psql -U postgres -d ufbasound -f 03_dql_consultas.sql
```

---

## 5. Observações sobre os Resultados das Consultas

- **Q1 (Filtro com `WHERE` e `ORDER BY`):** Filtra os equipamentos com `preco_diaria >= 80.00` e ordena de forma decrescente. Retorna 4 equipamentos (do Microfone Neumann U87 de R$ 180,00 ao Amplificador Marshall de R$ 110,00), excluindo itens mais baratos como o Shure SM58 (R$ 40,00) e a Caixa JBL (R$ 70,00).
- **Q2 (Consulta com `INNER JOIN`):** Relaciona `reserva`, `artista` e `sala_ensaio`. Retorna apenas as 5 reservas efetivamente registradas com seus respectivos artistas e salas. Artistas sem reserva (IDs 4 e 5) e salas nunca utilizadas (IDs 4 e 5) não aparecem no resultado.
- **Q3 (Consulta com `LEFT JOIN`):** Relaciona `artista` à esquerda com `reserva`. Retorna 7 linhas: todos os 6 artistas aparecem (sendo que o artista 1 aparece duas vezes por possuir 2 reservas), e os artistas de ID 4 (`Mari & Violao`) e ID 5 (`AfroSons Coletivo`) aparecem com os atributos de reserva preenchidos com `NULL`, evidenciando clientes cadastrados que ainda não agendaram sessões.
- **Q4 (Cálculo de Subtotal `quantidade * valor_unitario_cobrado`):** Retorna os 7 registros de locação de equipamentos vinculados às reservas, calculando o subtotal financeiro de cada item (por exemplo, 3 microfones Shure SM58 a R$ 40,00 na reserva 1 resultando em subtotal de R$ 120,00; e 2 microfones Neumann U87 a R$ 180,00 na reserva 2 resultando em R$ 360,00).
