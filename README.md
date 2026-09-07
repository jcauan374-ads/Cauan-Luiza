# Cauan & Luiza

## Crônicas do nosso amor

> Uma experiência digital autoral para transformar capítulos, sentimentos e memórias em uma história interativa.

[![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)](https://developer.mozilla.org/pt-BR/docs/Web/HTML) [![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)](https://developer.mozilla.org/pt-BR/docs/Web/CSS) [![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript) [![GitHub Pages](https://img.shields.io/badge/Publicado%20com-GitHub%20Pages-222222?style=for-the-badge&logo=github)](https://pages.github.com/)

## Sobre o projeto

**Cauan & Luiza** é uma página web criada para registrar uma história de amor em formato de experiência digital. A aplicação combina narrativa em capítulos, galeria de imagens, música ambiente, cartas, promessas, códigos secretos, animações e recursos interativos em uma única página responsiva.

A identidade visual segue uma direção **dark romantic**, com fundo escuro, vermelho profundo, cartões translúcidos, brilhos discretos e uma navegação vertical que conduz o visitante pela história.

A versão publicada pode ser acessada em [jcauan374-ads.github.io/Cauan-Luiza](https://jcauan374-ads.github.io/Cauan-Luiza/?hero=original).

## Funcionalidades

| Recurso | Descrição |
|---|---|
| **Manifesto e carta** | Seções textuais para registrar sentimentos, declarações e pensamentos pessoais. |
| **Capítulos** | Linha narrativa com acontecimentos importantes da história do casal. |
| **Galeria** | Imagens com efeito de zoom, lightbox e interação de coração ao clicar duas vezes. |
| **Contador do relacionamento** | Exibe o tempo transcorrido desde 15 de setembro de 2023. |
| **Contador de tempo restante** | Mostra em tempo real quanto falta para o próximo aniversário de namoro. |
| **Playlist** | Links para músicas que fazem parte da trilha sonora da história. |
| **Mural de recados** | Visitantes autenticados anonimamente podem publicar, editar e apagar recados. Cada recado permanece visível por 24 horas. |
| **Expiração dos recados** | Cada mensagem exibe um contador regressivo com dias, horas, minutos e segundos restantes. |
| **Mural de memórias** | Permite anexar uma foto, informar o nome do autor e escrever uma legenda. |
| **Notificações visuais** | Confirmações e avisos aparecem em um toast visual sem interromper a navegação. |
| **Linha do futuro** | Cartões de planos e sonhos podem ser marcados como conquistados e ficam persistidos no navegador. |
| **Códigos secretos** | Três códigos revelam frases especiais associadas a datas importantes. |
| **Responsividade** | A interface se adapta a computadores, tablets e celulares. |

## Tecnologias

| Tecnologia | Uso no projeto |
|---|---|
| **HTML5** | Estrutura semântica da página. |
| **CSS3** | Layout, identidade visual, responsividade, animações e efeitos de interação. |
| **JavaScript** | Contadores, navegação, lightbox, partículas, formulário de recados, mural de memórias e notificações. |
| **Supabase** | Autenticação anônima e persistência dos recados e das memórias compartilhadas. |
| **GitHub Pages** | Hospedagem da versão pública e publicação automática a partir da branch `main`. |

## Estrutura do repositório

```text
Cauan-Luiza/
├── index.html
├── musica.m4a
├── README.md
├── todo.md
├── images/
│   ├── header.jpg
│   ├── manifesto.jpg
│   ├── intensity.jpg
│   ├── chapter1.jpg
│   ├── chapter2.jpg
│   ├── chapter3.jpg
│   └── gallery1.jpg ... gallery6.jpg
└── supabase/
    └── cauan-luiza-mural.sql
```

O arquivo `index.html` concentra a estrutura HTML, os estilos CSS e os scripts JavaScript da aplicação. A pasta `images/` contém as imagens usadas na narrativa e na galeria. O arquivo `musica.m4a` é utilizado pelo player de música ambiente. O diretório `supabase/` contém o esquema SQL necessário para ativar a persistência dos murais.

## Como executar localmente

Clone o repositório e entre no diretório do projeto:

```bash
git clone https://github.com/jcauan374-ads/Cauan-Luiza.git
cd Cauan-Luiza
```

Como o projeto é uma página estática, é possível abrir o `index.html` diretamente no navegador. Para garantir que todos os recursos locais sejam carregados corretamente, recomenda-se iniciar um servidor HTTP simples:

```bash
python3 -m http.server 8000
```

Depois, acesse [http://localhost:8000](http://localhost:8000).

## Configuração do Supabase

O projeto utiliza uma sessão anônima do Supabase para permitir que cada visitante publique e gerencie os próprios recados e memórias sem precisar criar uma conta tradicional.

Para ativar o armazenamento compartilhado do **Mural de Recados** e do **Mural de Memórias**, abra o SQL Editor do projeto Supabase e execute o conteúdo completo de [`supabase/cauan-luiza-mural.sql`](supabase/cauan-luiza-mural.sql). Esse script cria as tabelas, índices, gatilhos e políticas de segurança necessárias.

O esquema inclui as seguintes estruturas principais:

| Estrutura | Finalidade |
|---|---|
| `cauan_luiza_messages` | Armazena nome, texto, autoria, data de criação e data de expiração dos recados. |
| `cauan_luiza_memories` | Armazena nome, legenda, autoria, data e a foto anexada em formato de dados. |
| Políticas RLS | Permitem leitura pública dos conteúdos e restringem edição ou exclusão ao autor da sessão anônima. |

Caso a tabela de memórias ainda não tenha sido criada no Supabase, a aplicação utiliza um fallback com `localStorage`. Nesse modo, as memórias ficam disponíveis apenas no navegador em que foram adicionadas até que a migração seja aplicada.

> **Importante:** nunca substitua a chave pública do Supabase por uma chave secreta no código do navegador. Chaves administrativas devem permanecer fora do frontend.

## Fluxo de publicação

As alterações da página são publicadas pela branch `main`. O GitHub Pages gera a versão pública automaticamente após cada push aceito pelo repositório.

Para publicar uma alteração:

```bash
git add .
git commit -m " descreva a alteração aqui "
git push origin main
```

Depois do push, o deploy pode levar alguns instantes para aparecer devido ao processo de build e ao cache do GitHub Pages.

## Direção visual e experiência

A interface foi concebida como uma narrativa contínua. A navegação fixa facilita o acesso às seções, enquanto o fundo escuro e os detalhes em vermelho reforçam a atmosfera íntima. Os cartões translúcidos organizam o conteúdo sem retirar o foco dos textos e das imagens.

As animações são usadas como microinterações: partículas no fundo, entrada suave de seções, brilho dos divisores, toast de confirmação, contador em tempo real e lightbox para a galeria. A estrutura também inclui estados vazios, mensagens de erro e feedback de sucesso para tornar os formulários mais claros.

## Status do projeto

O projeto está publicado e funcional como uma página estática pessoal. As principais funcionalidades de narrativa, galeria, contador, recados e memórias já estão implementadas. Novos capítulos, imagens, códigos e melhorias de acessibilidade podem ser adicionados futuramente.

## Referências

- [Documentação de HTML — MDN](https://developer.mozilla.org/pt-BR/docs/Web/HTML)
- [Documentação de CSS — MDN](https://developer.mozilla.org/pt-BR/docs/Web/CSS)
- [Documentação de JavaScript — MDN](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript)
- [Documentação do Supabase](https://supabase.com/docs)
- [Documentação do GitHub Pages](https://docs.github.com/pt/pages)

---

<div align="center">

**Algumas memórias merecem uma página inteira.**

[Cauan & Luiza](https://jcauan374-ads.github.io/Cauan-Luiza/?hero=original)

</div>
