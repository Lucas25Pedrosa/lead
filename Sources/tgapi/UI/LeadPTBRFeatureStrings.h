#import <Foundation/Foundation.h>

static inline NSDictionary *LeadPTBRFeatureStrings(void) {
  return @{
      @"GHOST_MODE_SECTION_HEADER" : @"Modo Fantasma",
      @"READ_RECEIPT_SECTION_HEADER" : @"Confirmações de leitura",
      @"MISC_SECTION_HEADER" : @"Privacidade e extras",
      @"FILE_FIXER_SECTION_HEADER" : @"Correção do seletor de arquivos",
      @"FAKE_LOCATION_SECTION_HEADER" : @"Localização falsa",
      @"LANGUAGE_SECTION_HEADER" : @"Idioma",
      @"CREDITS_SECTION_HEADER" : @"Créditos",

      @"DISABLE_ONLINE_STATUS_TITLE" : @"Ocultar status online",
      @"DISABLE_ONLINE_STATUS_SUBTITLE" : @"Impede que outras pessoas vejam quando você está online.",

      @"DISABLE_TYPING_STATUS_TITLE" : @"Ocultar status de digitação",
      @"DISABLE_TYPING_STATUS_SUBTITLE" : @"Oculta o indicador de “digitando…” enquanto você escreve uma mensagem.",

      @"DISABLE_RECORDING_VIDEO_STATUS_TITLE" : @"Ocultar status de gravação de vídeo",
      @"DISABLE_RECORDING_VIDEO_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você grava um vídeo.",

      @"DISABLE_UPLOADING_VIDEO_STATUS_TITLE" : @"Ocultar status de envio de vídeo",
      @"DISABLE_UPLOADING_VIDEO_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você envia um vídeo.",

      @"DISABLE_VC_MESSAGE_RECORDING_STATUS_TITLE" : @"Ocultar status de gravação de voz",
      @"DISABLE_VC_MESSAGE_RECORDING_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você grava uma mensagem de voz.",

      @"DISABLE_VC_MESSAGE_UPLOADING_STATUS_TITLE" : @"Ocultar status de envio de voz",
      @"DISABLE_VC_MESSAGE_UPLOADING_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você envia uma mensagem de voz.",

      @"DISABLE_UPLOADING_PHOTO_STATUS_TITLE" : @"Ocultar status de envio de foto",
      @"DISABLE_UPLOADING_PHOTO_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você envia uma foto.",

      @"DISABLE_UPLOADING_FILE_STATUS_TITLE" : @"Ocultar status de envio de arquivo",
      @"DISABLE_UPLOADING_FILE_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você envia um arquivo.",

      @"DISABLE_CHOOSING_LOCATION_STATUS_TITLE" : @"Ocultar status de escolha de localização",
      @"DISABLE_CHOOSING_LOCATION_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você escolhe uma localização para compartilhar.",

      @"DISABLE_CHOOSING_CONTACT_TITLE" : @"Ocultar status de escolha de contato",
      @"DISABLE_CHOOSING_CONTACT_SUBTITLE" : @"Oculta o indicador enquanto você escolhe um contato para compartilhar.",

      @"DISABLE_PLAYING_GAME_STATUS_TITLE" : @"Ocultar status de jogo",
      @"DISABLE_PLAYING_GAME_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você joga um jogo inline.",

      @"DISABLE_RECORDING_ROUND_VIDEO_STATUS_TITLE" : @"Ocultar status de gravação de vídeo circular",
      @"DISABLE_RECORDING_ROUND_VIDEO_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você grava uma mensagem de vídeo circular.",

      @"DISABLE_UPLOADING_ROUND_VIDEO_STATUS_TITLE" : @"Ocultar status de envio de vídeo circular",
      @"DISABLE_UPLOADING_ROUND_VIDEO_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você envia uma mensagem de vídeo circular.",

      @"DISABLE_SPEAKING_IN_GROUP_CALL_STATUS_TITLE" : @"Ocultar status de fala em chamada em grupo",
      @"DISABLE_SPEAKING_IN_GROUP_CALL_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você fala em uma chamada em grupo.",

      @"DISABLE_CHOOSING_STICKER_STATUS_TITLE" : @"Ocultar status de escolha de figurinha",
      @"DISABLE_CHOOSING_STICKER_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você escolhe uma figurinha.",

      @"DISABLE_EMOJI_INTERACTION_STATUS_TITLE" : @"Ocultar status de interação com emoji",
      @"DISABLE_EMOJI_INTERACTION_STATUS_SUBTITLE" : @"Oculta o indicador enquanto você interage com um emoji.",

      @"DISABLE_EMOJI_ACKNOWLEDGEMENT_STATUS_TITLE" : @"Ocultar status de reação com emoji",
      @"DISABLE_EMOJI_ACKNOWLEDGEMENT_STATUS_SUBTITLE" : @"Oculta o indicador quando você reage a uma mensagem com emoji.",

      @"READ_RECEIPTS" : @"Confirmações de leitura",
      @"DISABLE_MESSAGE_READ_RECEIPT_TITLE" : @"Desativar confirmação de leitura de mensagens",
      @"DISABLE_MESSAGE_READ_RECEIPT_SUBTITLE" : @"Outras pessoas não verão que você leu as mensagens delas.",

      @"DISABLE_STORY_READ_RECEIPT_TITLE" : @"Desativar confirmação de visualização de Stories",
      @"DISABLE_STORY_READ_RECEIPT_SUBTITLE" : @"Outras pessoas não verão que você visualizou os Stories delas.",

      @"MISC" : @"Privacidade e extras",
      @"DISABLE_ALL_ADS_TITLE" : @"Desativar todos os anúncios",
      @"DISABLE_ALL_ADS_SUBTITLE" : @"Remove mensagens patrocinadas e conteúdo promocional do aplicativo.",

      @"ENABLE_SAVING_PROTECTED_CONTENT_TITLE" : @"Salvar mídia restrita",
      @"ENABLE_SAVING_PROTECTED_CONTENT_SUBTITLE" : @"Ignora restrições de encaminhamento para salvar e encaminhar mídia de chats e canais protegidos.",

      @"ANTI_REVOKE_TITLE" : @"Salvar mensagens apagadas",
      @"ANTI_REVOKE_SUBTITLE" : @"Mantém as mensagens no chat mesmo depois que o remetente as apaga. As mensagens apagadas continuam visíveis para você.",

      @"ANTI_EDIT_TITLE" : @"Histórico de edições",
      @"ANTI_EDIT_SUBTITLE" : @"Mantém visível o texto editado mais recente e salva as versões anteriores. Toque no ícone de lápis das mensagens editadas para ver o histórico.",

      @"ANTI_SCREENSHOT_TITLE" : @"Desativar notificações de captura de tela",
      @"ANTI_SCREENSHOT_SUBTITLE" : @"Faça capturas de tela em chats secretos e canais protegidos sem enviar uma notificação para a outra pessoa.",

      @"ANTI_SELF_DESTRUCT_TITLE" : @"Ver mídia temporária livremente",
      @"ANTI_SELF_DESTRUCT_SUBTITLE" : @"Abra fotos e vídeos de visualização única ou temporários sem acionar o temporizador de autodestruição. A mídia permanece visível localmente.",

      @"ANTI_AUTO_DELETE_TITLE" : @"Salvar mensagens com exclusão automática",
      @"ANTI_AUTO_DELETE_SUBTITLE" : @"Impede que mensagens em chats com exclusão automática (1 dia, 7 dias etc.) sejam apagadas. Elas continuam visíveis mesmo após o tempo expirar.",

      @"DOWNLOAD_BOOST_SECTION_HEADER" : @"Velocidade de download",
      @"DOWNLOAD_BOOST_TITLE" : @"Acelerar downloads (experimental)",
      @"DOWNLOAD_BOOST_SUBTITLE" : @"Tenta aumentar o tamanho dos blocos e o número de partes paralelas para acelerar downloads. Isso não contorna limites impostos pelos servidores do Telegram.",
      @"DOWNLOAD_BOOST_OFF" : @"Desativado (padrão)",
      @"DOWNLOAD_BOOST_MEDIUM" : @"Médio (512 KB / 8 partes)",
      @"DOWNLOAD_BOOST_MAX" : @"Máximo (1 MB / 12 partes)",

      @"CONFIRM_CALLS_TITLE" : @"Confirmar chamadas",
      @"CONFIRM_CALLS_SUBTITLE" : @"Mostra uma confirmação antes de atender chamadas recebidas.",

      @"SHOW_IOS_RESTRICTED_TITLE" : @"Mostrar chats bloqueados pela App Store",
      @"SHOW_IOS_RESTRICTED_SUBTITLE" : @"Abre canais e publicações ocultos apenas no iPhone por regras da App Store. Reinicie o aplicativo depois de ativar.",

      @"SEND_AS_VOICE_TITLE" : @"Enviar áudio como mensagem de voz",
      @"SEND_AS_VOICE_SUBTITLE" : @"Arquivos de áudio enviados por você aparecerão como mensagens de voz em vez de anexos.",

      @"DOWNLOAD_STORIES_TITLE" : @"Salvar Stories automaticamente",
      @"DOWNLOAD_STORIES_SUBTITLE" : @"Salva automaticamente os Stories no app Fotos quando você os abre.",

      @"HIDE_STORIES_TITLE" : @"Ocultar barra de Stories",
      @"HIDE_STORIES_SUBTITLE" : @"Remove a fileira de Stories do topo da lista de chats.",

      @"FIX_FILE_PICKER_TITLE" : @"Corrigir seletor de arquivos",
      @"FIX_FILE_PICKER_SUBTITLE" : @"Corrige o problema que impede selecionar arquivos no app Arquivos em versões instaladas por sideload.",

      @"CLEAR_FILE_PICKER_CACHE_TITLE" : @"Limpar cache do seletor de arquivos",
      @"CLEAR_FILE_PICKER_CACHE_SUBTITLE" : @"O seletor de arquivos copia arquivos para uma pasta temporária. Toque aqui para limpar o cache e liberar espaço.",

      @"CACHE_CLEAR_WARNING_TITLE" : @"Confirmar",
      @"CACHE_CLEAR_WARNING_MESSAGE" : @"Tem certeza de que deseja limpar o cache do seletor de arquivos?",

      @"ENABLE_FAKE_LOCATION_TITLE" : @"Ativar localização falsa",
      @"ENABLE_FAKE_LOCATION_SUBTITLE" : @"Substitui a localização GPS do dispositivo e permite compartilhar uma localização personalizada.",
      @"SELECT_FAKE_LOCATION_TITLE" : @"Selecionar localização falsa",

      @"APPLY" : @"Aplicar",
      @"APPLY_CHANGES" : @"O aplicativo será fechado e reiniciado para aplicar as alterações. Continuar?",
      @"OK" : @"OK",
      @"CANCEL" : @"Cancelar",
      @"DISCLAIMER" : @"Aviso legal",
      @"AUTHOR_MESSAGE" : @"Este tweak para Telegram destina-se apenas a uso pessoal e educacional. Não somos afiliados ao Telegram de nenhuma forma. Todas as marcas registradas, incluindo o nome e o logotipo do Telegram, pertencem aos seus respectivos proprietários. Não use isto para violar regras ou os termos do Telegram — não nos responsabilizamos por eventuais consequências. Use por sua conta e risco.\n\nE, se você gostar, diga alguma coisa. O desenvolvedor realmente aprecia o feedback.\n\nSe quiser apoiar o projeto, entre em contato pelo Telegram.",
  };
}
