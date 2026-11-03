# Lead — Português (Brasil)

Esta branch contém a integração experimental de Português (Brasil) para o Lead 2.0.

- Código do idioma: `pt-BR`
- Nome exibido: `Português (Brasil)`
- Bandeira: `🇧🇷`
- Traduções funcionais: `Sources/tgapi/UI/LeadPTBRFeatureStrings.h`
- Traduções da interface: `Sources/tgapi/UI/LeadPTBRUIStrings.h`
- Integração com o seletor/localização: `Sources/tgapi/UI/PTBRLocalization.xm`

A implementação fica isolada dos arquivos de tradução upstream para facilitar rebases e testes antes de preparar um PR para o projeto original.
