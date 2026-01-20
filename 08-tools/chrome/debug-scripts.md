# Chrome Debugging Scripts

## Run Chrome without CORS

Useful for local development when you need to bypass CORS policies or SSL errors.

```powershell
chrome.exe --disable-web-security --disable-gpu --user-data-dir="./chromeTemp"
```

## Chrome WebPush Notifications

Access notification settings directly:

```
chrome://settings/content/notifications
```

## Experimental Flags

Access experimental features:

```
chrome://flags
```

## Additional Insecure Options

Run with ignored certificate errors and XSS auditor disabled (use with caution!):

```powershell
chrome --user-data-dir="./tmp" --ignore-certificate-errors --disable-xss-auditor --unsafely-treat-insecure-origin-as-secure=https://localhost:4200
```
