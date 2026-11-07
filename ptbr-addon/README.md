# Lead 2.0.2 — complemento Português (Brasil), revisão 2

**Escopo:** compilação independente de \`LeadPTBR.dylib\` para ser usada
**junto** da \`Lead.dylib\` oficial da versão 2.0.2. O hotfix não é modificado.

## Traduções

O projeto reutiliza as 227 traduções validadas na branch \`pt-br\`, em:
- \`Sources/tgapi/UI/LeadPTBRFeatureStrings.h\` — recursos;
- \`Sources/tgapi/UI/LeadPTBRUIStrings.h\` — menus;
- \`ptbr-addon/src/LeadPTBR202Strings.h\` — **39 chaves novas** da 2.0.2.

Chaves sem tradução retornam à implementação original do Lead,
preservando o texto original e evitando interferir em funcionalidades.

## Idioma — corrigido na revisão 2

A revisão inicial usava \`LeadPTBRAddonEnabled\`, separado da preferência
\`LeadLanguage\` do Lead. Isso fazia Português aparecer mesmo com English
selecionado e mostrava "English" na tela principal.

A revisão 2 utiliza exclusivamente a preferência **nativa** \`LeadLanguage\`:
- \`pt-BR\`: aplica os textos traduzidos, inclusive no seletor;
- \`en\`, \`es\`, \`ru\` e demais idiomas: mantém a implementação e os
  textos oficiais do desenvolvedor, **sem** aplicar a tradução portuguesa;
- seleciona idiomas pela implementação original da Lead;
- preserva \`pt-BR\` durante \`-[LeadLocalization loadDefault]\`, evitando
  que a versão 2.0.2 restaure o idioma desconhecido para \`en\`;
- substitui o código \`pt-BR\` pelo nome \`Português (Brasil)\` no resumo
  da seleção no menu principal.

Há uma **migração única**: quem utilizava a revisão anterior com o
português ativado e \`LeadLanguage=en\` passa a \`pt-BR\`. Preferências
originais para outros idiomas são preservadas. Seleções futuras ficam
armazenadas apenas na preferência original.

## Compilação

GitHub Actions → **Build Lead 2.0.2 PT-BR companion** → Run workflow.
O workflow na branch principal faz checkout do código atualizado em \`pt-br\`
e disponibiliza o artefato \`Lead-2.0.2-PTBR-companion\`.

Para compilar localmente com Theos:
\`\`\`sh
make -C ptbr-addon clean all FINALPACKAGE=1
\`\`\`

## Testes

Injetar a Lead oficial e o complemento na aplicação principal,
em \`Frameworks/\`, com a Lead oficial carregada antes da
\`LeadPTBR.dylib\`. Não injetar o complemento nas extensões.

1. Abrir Lead → Idioma; confirmar **Português (Brasil)**.
2. Alternar para **English** e reiniciar: verificar que não há textos PT-BR.
3. Alternar para Español/Russian e reiniciar: idioma oficial deve voltar.
4. Retornar a Português (Brasil): tradução e menu devem combinar.
5. Conferir **Verificação de compatibilidade** e outras 39 novas chaves.
6. Verificar notificações com texto e funções da Lead oficial.

**Ainda é um protótipo:** a compilação verifica sintaxe/arquitetura,
mas precisa de validação em runtime no iPhone. Até lá não atualizar
o injector ou Core automaticamente.
