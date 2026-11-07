#import <Foundation/Foundation.h>

// New localization keys introduced in the official Lead 2.0.2 build.
// The original 2.0 Portuguese tables remain in Sources/tgapi/UI/.
// Keep format placeholders compatible with upstream call sites.
static inline NSDictionary<NSString *, NSString *> *LeadPTBR202Strings(void) {
    return @{
        // Compatibility Check, Telegram / Swiftgram / Turrit
        @"UI_COMPAT_TITLE": @"Verificação de compatibilidade",
        @"UI_COMPAT_SUBTITLE": @"O que funciona do Lead neste aplicativo",
        @"UI_COMPAT_FOOTER": @"As verificações são feitas em tempo real. Alguns resultados podem aparecer após alguns minutos. Use o botão acima para copiar um relatório e enviá-lo ao desenvolvedor.",
        @"UI_COMPAT_SUMMARY_FAILED": @"Alguns recursos não estão funcionando",
        @"UI_COMPAT_SUMMARY_WARNING": @"Alguns recursos podem não funcionar",
        @"UI_COMPAT_SUMMARY_OK": @"Nenhum problema encontrado",

        @"UI_COMPAT_API": @"Versão da API",
        @"UI_COMPAT_API_UNKNOWN": @"Não foi possível identificar a API",
        @"UI_COMPAT_API_OLD": @"API mais antiga que a esperada",
        @"UI_COMPAT_API_NEW": @"API mais recente que a esperada",
        @"UI_COMPAT_API_OK": @"API %ld, compatível com o Lead.",

        @"UI_COMPAT_NETWORK": @"Interceptações de rede",
        @"UI_COMPAT_NETWORK_MISSING": @"Interceptações de rede indisponíveis",
        @"UI_COMPAT_NETWORK_OK": @"Funcionando, %lld solicitações até agora.",
        @"UI_COMPAT_WAIT": @"Aguarde um instante e abra esta página novamente.",

        @"UI_COMPAT_PARSER": @"Análise de respostas",
        @"UI_COMPAT_PARSER_IDLE": @"Nada para verificar ainda: ative um recurso em Mensagens ou Conteúdo.",
        @"UI_COMPAT_PARSER_OK": @"Sem erros, %ld respostas analisadas.",
        @"UI_COMPAT_PARSER_FAILED": @"Falha ao analisar respostas",

        @"UI_COMPAT_EXTENSION": @"Extensão de notificações",
        @"UI_COMPAT_EXTENSION_NOT_INJECTED": @"O Lead não está carregado na extensão de notificações.",
        @"UI_COMPAT_EXTENSION_NONE": @"Esta versão não possui extensão de notificações.",
        @"UI_COMPAT_EXTENSION_NO_GROUP": @"App Groups indisponíveis para a extensão de notificações.",
        @"UI_COMPAT_EXTENSION_OK": @"Funcionando: %ld respostas alteradas, última em %@.",
        @"UI_COMPAT_EXTENSION_READY": @"Pronto, ainda não foi necessário alterar nada.",

        @"UI_COMPAT_MESSAGES": @"Marcações de mensagens",
        @"UI_COMPAT_MESSAGES_IDLE": @"Abra uma conversa para preencher esta verificação.",
        @"UI_COMPAT_MESSAGES_OK": @"%ld mensagens reconhecidas.",
        @"UI_COMPAT_MESSAGES_PARTIAL": @"Algumas marcações de mensagens podem não funcionar",

        @"UI_COMPAT_SCREENS": @"Telas do Telegram",
        @"UI_COMPAT_SCREENS_OK": @"Telas compatíveis identificadas",
        @"UI_COMPAT_SCREENS_MISSING": @"Algumas telas esperadas não foram encontradas",

        // Settings added to Lead 2.0.2
        @"UI_SENSITIVE_TITLE": @"Mostrar conteúdo para maiores de 18 anos",
        @"UI_SENSITIVE_SUBTITLE": @"Configuração de conta que o Telegram oculta no iOS. O servidor decide se ela pode ser aplicada à conta atual.",
        @"UI_SENSITIVE_FAILED": @"Não foi possível alterar esta configuração da conta.",
        @"UI_FAKE_DEVICE_TITLE": @"Personalizar nome do dispositivo",
        @"UI_FAKE_DEVICE_SUBTITLE": @"Altera como o dispositivo aparece nas sessões do Telegram.",
        @"UI_DEVICE_NAME": @"Nome do dispositivo",
        @"UI_DEVICE_NAME_HINT": @"Como este dispositivo aparece nas sessões. Aplicado após reiniciar."
    };
}
