#!/system/bin/sh
# Passkey Google Fix (HyperOS) — action.sh
# Botao "Action" no gerenciador: status rapido (a WebUI tem o painel completo).

echo "== Passkey Google Fix =="
echo
echo "Provedor de passkey ATIVO no sistema:"
cmd package query-services -a android.service.credentials.CredentialProviderService 2>/dev/null | grep -iE "name=.*(PasswordAndPasskey|XiaomiCredential)" | sed "s/.*name=/  /"
echo
echo -n "Google habilitado (credential_service): "
settings get secure credential_service | grep -q PasswordAndPasskeyService && echo "SIM" || echo "NAO"
echo -n "Provedor Xiaomi: "
dumpsys package com.miui.passwords 2>/dev/null | grep -A3 disabledComponents | grep -q XiaomiCredential && echo "desabilitado (correto)" || echo "ATIVO"
echo
echo "Abra a WebUI do modulo para status detalhado e teste de passkey."
