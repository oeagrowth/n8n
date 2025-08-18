# Casa da Fulana

Aplicação React + Supabase para controle de medicamentos.

## Setup

1. Instale dependências:

```sh
npm install
```

2. Configure variáveis de ambiente em `.env` a partir de `.env.example`.

3. Execute em desenvolvimento:

```sh
npm run dev
```

## Banco de Dados

O arquivo `supabase/schema.sql` contém a estrutura e os seeds iniciais do banco.

## Alias

O alias `@` aponta para `src/` e é configurado em `tsconfig.json` e `vite.config.ts`.

## Consulta de dados

A aplicação usa [`@tanstack/react-query`](https://tanstack.com/query/latest) para buscar dados do Supabase. A tela inicial mostra o nome da casa, lista de pessoas e lista de medicamentos com o tipo (CONTÍNUO/ESPORÁDICO).
