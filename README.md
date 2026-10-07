# PowerShell World Clock Widget

A lightweight, borderless desktop clock widget written entirely in PowerShell using Windows Forms (WinForms). The application runs natively on Windows without requiring any third-party software, compiler, or heavy IDEs. It provides a clean, dark-mode heads-up display of UTC and Eastern Time, with a right-click context menu to dynamically toggle additional North American time zones.
![App Screenshot](https://github.com/rdmershon/PowerShell-Clock-App/blob/main/ClockApp.png)
## Features

* **Zero Dependencies:** Runs on built-in Windows PowerShell using native `.NET` WinForms assemblies.
* **Borderless & Draggable:** Stripped of the standard Windows title bar for a modern widget aesthetic. Can be dragged anywhere on the screen by clicking and holding the text.
* **Dynamic Auto-Sizing:** The widget seamlessly grows and shrinks as you toggle time zones on and off.
* **Context Menu Controls:** Clean UI with no visible buttons or checkboxes. All interactions are handled via a right-click menu.
* **Copy-Paste Resilient:** All script lines are explicitly terminated with semicolons (`;`) to prevent parser errors when copying code across different text editors or remote terminals.
* **Always-on-Top:** Stays visible over other windows for easy monitoring.

## Prerequisites

* Windows 10 or Windows 11
* PowerShell 5.1 or later (included by default in Windows)

## Installation & Usage

1. Save the script as a `.ps1` file (e.g., `ClockApp.ps1`).
2. **To run temporarily:** Right-click `ClockApp.ps1` and select **Run with PowerShell**.
3. **To run seamlessly (Background Mode):** Create a desktop shortcut to launch the app without leaving a black console window open on your taskbar.
* Right-click your Desktop > **New** > **Shortcut**.
* Paste the following into the target field (update the file path to match your system):
```cmd
powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Path\To\Your\ClockApp.ps1"

```


* Name it "World Clock" and click **Finish**.



## Controls

* **Move the Widget:** Click and hold anywhere on the clock text, then drag your mouse to reposition the widget on your screen.
* **Toggle Time Zones:** Right-click the widget to open the context menu. Click to toggle Central, Mountain, or Pacific time on or off.
* **Close the App:** Right-click the widget and select **Close Clock** from the bottom of the menu.

## Customization

You can easily modify the script's visual style by editing the Hex color codes and font settings at the top of the file:

* **Background Color:** `$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#181A1F");`
* **Text Color:** `$timeLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#56B6C2");`
* **Font Style & Size:** `$timeLabel.Font = New-Object System.Drawing.Font("Consolas", 14, [System.Drawing.FontStyle]::Bold);`
