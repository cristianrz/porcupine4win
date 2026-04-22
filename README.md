# Porcupine4Win

A "browser" that copies URLs to your clipboard instead of opening them.

Click a link anywhere in Windows — Slack, Teams, email, wherever — and
it lands in your clipboard. You choose when and where to open it.

Inspired by [porcupine](https://github.com/micahflee/porcupine) by Micah Lee.

## How it works

Porcupine4Win registers itself as Microsoft Edge. When Windows routes a
link click to "Edge", Porcupine intercepts it, copies the URL to your
clipboard, and shows a notification. No browser opens.

## Installation

Run PowerShell as Administrator, then:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
.\install.ps1
```

Then go to **Settings → Apps → Default apps** and set Microsoft Edge as
your default browser if it isn't already.

## Uninstallation

```powershell
.\uninstall.ps1
```

This restores the original `msedge.exe` from the backup created during
install.

## Requirements

- Windows 10 or 11
- Microsoft Edge installed (does not need to be used)
- PowerShell (included in Windows)

## FAQ

**Will this break Edge?**
No. The installer backs up `msedge.exe` before replacing it.
Run `uninstall.ps1` at any time to restore it fully.

**Will antivirus flag it?**
Possibly. Replacing a system executable is unusual behaviour. If your
AV complains, add the Edge Application directory to its exclusion list,
or build the binary yourself from source.

**Does it work with browsers other than Edge?**
Yes. Porcupine copies the URL — you paste it into any browser you like.

## License

BSD 3-Clause
