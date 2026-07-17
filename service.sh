#!/system/bin/sh
# Passkey Google Fix (HyperOS) — service.sh
# O HyperOS limpa "credential_service" UMA vez durante o pos-boot, DEPOIS do
# estagio service. Nao ha vigia continuo (valor fica cravado quando o sistema
# assenta). Entao: reaplicamos numa janela pos-boot e mantemos um vigia leve.

XIAOMI_PKG="com.miui.passwords"
XIAOMI_PROVIDER="com.miui.passwords/.credential.provider.XiaomiCredentialProviderService"
GOOGLE_CRED="com.google.android.gms/com.google.android.gms.auth.api.credentials.credman.service.PasswordAndPasskeyService"

ensure_google() {
  case "$(settings get secure credential_service 2>/dev/null)" in
    *PasswordAndPasskeyService*) return 1 ;;                 # ja ok
    *) settings put secure credential_service "$GOOGLE_CRED" >/dev/null 2>&1; return 0 ;;
  esac
}

# Espera o boot completar
until [ "$(getprop sys.boot_completed)" = "1" ]; do sleep 2; done
sleep 5

# Provedor Xiaomi desabilitado (persiste entre reboots -> uma vez basta)
if pm path "$XIAOMI_PKG" >/dev/null 2>&1; then
  pm disable "$XIAOMI_PROVIDER" >/dev/null 2>&1
fi

# Fase 1: janela de reset do MIUI — reaplica a cada 8s por ~4 min
i=0
while [ $i -lt 30 ]; do
  ensure_google
  i=$((i + 1))
  sleep 8
done

# Fase 2: vigia leve — reaplica se algo limpar durante o uso (barato; sleep nao
# segura wakelock, so roda com a CPU acordada)
while true; do
  ensure_google
  sleep 120
done
