# iOS Web Debugging

## Remote Debugging WebKit Adapter

To debug iOS Safari or WebViews from Chrome DevTools on Windows/Linux:

1. Install the adapter:

```bash
npm install remotedebug-ios-webkit-adapter -g
```

2. Run the adapter:

```bash
remotedebug_ios_webkit_adapter --port=9000
```

3. Open Chrome and inspect `localhost:9000` (or configure network targets).
