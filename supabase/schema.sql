create table casa (
  id bigint primary key generated always as identity,
  nome text not null,
  alert_dias_baixo integer,
  alert_dias_medio integer,
  timezone text
);

create table pessoa (
  id bigint primary key generated always as identity,
  casa_id bigint references casa(id) on delete cascade,
  nome text not null
);

create table medicamento (
  id bigint primary key generated always as identity,
  nome_comercial text not null,
  principio_ativo text,
  forma text,
  unidade_dose text
);

create table casa_medicamento (
  id bigint primary key generated always as identity,
  casa_id bigint references casa(id) on delete cascade,
  medicamento_id bigint references medicamento(id) on delete cascade,
  tipo_uso text check (tipo_uso in ('CONTINUO','ESPORADICO')) not null
);

create table receita (
  id bigint primary key generated always as identity,
  pessoa_id bigint references pessoa(id) on delete cascade,
  casa_medicamento_id bigint references casa_medicamento(id) on delete cascade,
  dose_por_vez numeric,
  vezes_dia integer,
  dosagem_prescrita_unid_base numeric,
  unidade_base text
);

create table estoque_entrada (
  id bigint primary key generated always as identity,
  casa_medicamento_id bigint references casa_medicamento(id) on delete cascade,
  dosagem_caixa_unid_base numeric,
  unidade_base text,
  unidades_por_caixa integer,
  qtd_caixas integer,
  data_compra date
);

create table esporadico_config (
  id bigint primary key generated always as identity,
  casa_medicamento_id bigint references casa_medicamento(id) on delete cascade,
  qtd_caixas_padrao integer
);

-- seeds
insert into casa (id, nome, alert_dias_baixo, alert_dias_medio, timezone) values
  (1, 'Casa da Fulana', 5, 10, 'UTC');

insert into pessoa (id, casa_id, nome) values
  (1, 1, 'Paulo'),
  (2, 1, 'Iara');

insert into medicamento (id, nome_comercial, principio_ativo, forma, unidade_dose) values
  (1, 'Ômega 3', 'Ômega 3', 'comprimido', 'mg'),
  (2, 'Dipirona', 'Dipirona', 'comprimido', 'mg');

insert into casa_medicamento (id, casa_id, medicamento_id, tipo_uso) values
  (1, 1, 1, 'CONTINUO'),
  (2, 1, 2, 'ESPORADICO');

insert into receita (id, pessoa_id, casa_medicamento_id, dose_por_vez, vezes_dia, dosagem_prescrita_unid_base, unidade_base) values
  (1, 1, 1, 1, 1, 1000, 'mg'),
  (2, 2, 1, 2, 1, 1000, 'mg');

insert into estoque_entrada (id, casa_medicamento_id, dosagem_caixa_unid_base, unidade_base, unidades_por_caixa, qtd_caixas, data_compra) values
  (1, 1, 1000, 'mg', 90, 1, '2024-01-01'),
  (2, 2, 500, 'mg', 20, 1, '2024-01-02');

insert into esporadico_config (id, casa_medicamento_id, qtd_caixas_padrao) values
  (1, 2, 2);
