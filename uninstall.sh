#!/system/bin/sh
# Passkey Google Fix (HyperOS) — uninstall.sh
# Reverte tudo ao remover o modulo.
pm enable com.miui.passwords >/dev/null 2>&1
pm enable com.miui.passwords/.credential.provider.XiaomiCredentialProviderService >/dev/null 2>&1
# Limpa a lista de provedores (volta ao estado original vazio)
settings put secure credential_service "" >/dev/null 2>&1
