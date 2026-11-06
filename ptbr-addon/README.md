# Lead 2.0.2 — Português (Brasil), complemento independente

Esta pasta compila apenas **LeadPTBR.dylib**, uma biblioteca Objective-C
complementar à **Lead 2.0.2 oficial**. Não recompila, altera nem incorpora o
binário oficial da Lead; preserva os hotfixes da versão 2.0.2.

## Localização dos arquivos

As traduções originais já revisadas do projeto são reutilizadas diretamente
da branch \`pt-br\` deste repositório, sem duplicação:

- \`Sources/tgapi/UI/LeadPTBRFeatureStrings.h\` — funcionalidades;
- \`Sources/tgapi/UI/LeadPTBRUIStrings.h\` — menus e interface.

O complemento redireciona exclusivamente o método
\`+[LeadLocalization localizedStringForKey:]\` para retornar texto em pt-BR
quando há uma tradução conhecida. Chaves novas/desconhecidas são encaminhadas
à implementação **original** da Lead 2.0.2.

Também tenta incluir \`Português (Brasil)\` no seletor \`LanguageSelector\`.
O complemento guarda sua escolha em \`LeadPTBRAddonEnabled\`. A preferência
interna \`LeadLanguage\` da Lead oficial fica em \`en\` quando pt-BR está ativo:
isso evita o reset de idioma desconhecido do hotfix. Mudanças de idioma exigem
fechar e abrir o aplicativo.

## Compilar pelo GitHub Actions

No repositório \`Lucas25Pedrosa/lead\`, abra **Actions → Build Lead 2.0.2 PT-BR
companion → Run workflow**. A ação usa um runner macOS com Theos e faz checkout
da branch \`pt-br\`, onde estão os arquivos de tradução. No fim, baixe o
artefato \`Lead-2.0.2-PTBR-companion\`.

Compilação local, se houver Theos e SDK iOS:

\`\`\`sh
make -C ptbr-addon clean all FINALPACKAGE=1
\`\`\`

## Uso e limites

1. Use a Lead **2.0.2 oficial** sem alterações no aplicativo.
2. Injete também \`LeadPTBR.dylib\` **somente no executável principal**,
   garantindo que as duas bibliotecas sejam carregadas.
3. **Não** adicione a biblioteca de tradução às extensões de notificação.
4. Teste idioma, menus, outros idiomas e reinício no dispositivo antes de
   qualquer implantação no Core ou injector.

**Protótipo:** os seletores da Lead 2.0.2 foram observados no IPA, mas a
compatibilidade em runtime e a ordem de inicialização ainda precisam ser
verificadas. A cobertura é a da tradução 2.0; novas chaves da 2.0.2 podem
aparecer em inglês até tradução posterior.

A implementação não substitui os hooks funcionais, código de rede,
licenciamento, infraestrutura de notificações ou correções do hotfix.
