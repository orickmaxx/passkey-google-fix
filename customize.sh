# Passkey Google Fix (HyperOS) — customize.sh
# Instalador faz "source" deste script como root apos extrair os arquivos.
SKIPUNZIP=0

XIAOMI_PKG="com.miui.passwords"
XIAOMI_PROVIDER="com.miui.passwords/.credential.provider.XiaomiCredentialProviderService"
GOOGLE_CRED="com.google.android.gms/com.google.android.gms.auth.api.credentials.credman.service.PasswordAndPasskeyService"

ui_print "- Passkey Google Fix v1.1"
ui_print "- Alvo: KSU=$KSU_VER | arch=$ARCH | API=$API"

# Validacao de ambiente
[ "$KSU" = "true" ] || abort "! Este modulo requer KernelSU / KSU Next."
[ "$API" -lt 34 ] && abort "! Android Credential Manager requer API 34+ (Android 14). Detectado: $API"

# 1) Desabilita o provedor de passkey da Xiaomi (se o app existir)
if pm path "$XIAOMI_PKG" >/dev/null 2>&1; then
  ui_print "- Desabilitando provedor de passkey da Xiaomi..."
  pm disable "$XIAOMI_PROVIDER" >/dev/null 2>&1 \
    && ui_print "  OK: provedor Xiaomi desabilitado." \
    || ui_print "  ! Falha agora; sera tentado no boot."
else
  ui_print "! $XIAOMI_PKG nao encontrado (segue mesmo assim)."
fi

# 2) Habilita o Google na lista de provedores do Credential Manager
#    (essencial: sem isso o HyperOS cai no provedor padrao/Xiaomi)
ui_print "- Habilitando o Google como provedor de passkey..."
settings put secure credential_service "$GOOGLE_CRED" >/dev/null 2>&1 \
  && ui_print "  OK: Google habilitado." \
  || ui_print "  ! Falha ao setar credential_service."

ui_print "- Pronto. Use a WebUI (botao do modulo) p/ status e teste."
ui_print "- Reverter: remova o modulo."
