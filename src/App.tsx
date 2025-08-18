import { QueryClient, QueryClientProvider, useQuery } from '@tanstack/react-query';
import { supabase } from '@/lib/supabaseClient';

const queryClient = new QueryClient();

interface Casa { id: number; nome: string; }
interface Pessoa { id: number; nome: string; }
interface MedicamentoItem { id: number; tipo_uso: string; medicamento: { nome_comercial: string } }

function Home() {
  const { data: casa } = useQuery<Casa | null>({
    queryKey: ['casa'],
    queryFn: async () => {
      const { data } = await supabase.from('casa').select('id,nome').single();
      return data;
    },
  });

  const { data: pessoas } = useQuery<Pessoa[]>({
    queryKey: ['pessoas'],
    queryFn: async () => {
      const { data } = await supabase.from('pessoa').select('id,nome');
      return data ?? [];
    },
  });

  const { data: medicamentos } = useQuery<MedicamentoItem[]>({
    queryKey: ['medicamentos'],
    queryFn: async () => {
      const { data } = await supabase
        .from('casa_medicamento')
        .select('id,tipo_uso,medicamento:medicamento_id (nome_comercial)');
      return data ?? [];
    },
  });

  return (
    <div>
      <h1>{casa?.nome}</h1>
      <h2>Pessoas</h2>
      <ul>
        {pessoas?.map((p) => (
          <li key={p.id}>{p.nome}</li>
        ))}
      </ul>
      <h2>Medicamentos</h2>
      <ul>
        {medicamentos?.map((m) => (
          <li key={m.id}>
            {m.medicamento?.nome_comercial} - {m.tipo_uso}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <Home />
    </QueryClientProvider>
  );
}
