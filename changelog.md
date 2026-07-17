# Changelog

## v1.2.0
- Premium **multilingual WebUI** (English / Русский / Português-BR) with automatic
  language detection (defaults to English) and an in-app language switcher.
- Glassmorphism redesign, inline SVG icons, module banner and button icons.
- OTA updates via `updateJson`.

## v1.1.0
- Root cause fixed: also **enables Google** in `credential_service` (not just
  disabling Xiaomi). HyperOS clears this once during post-boot, so `service.sh`
  reapplies it in a post-boot window plus a light watcher.
- Added WebUI with live status and a neutral passkey test (webauthn.io).

## v1.0.0
- Initial release: disables the Xiaomi passkey provider
  (`com.miui.passwords/.credential.provider.XiaomiCredentialProviderService`).
