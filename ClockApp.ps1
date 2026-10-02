Add-Type -AssemblyName System.Windows.Forms;
Add-Type -AssemblyName System.Drawing;

# Create the main borderless form
$form = New-Object System.Windows.Forms.Form;
$form.Text = "World Clock Widget";
$form.FormBorderStyle = 'None';$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#181A1F");
$form.TopMost =$true;
$form.ShowInTaskbar =$false;
$form.AutoSize =$true;
$form.AutoSizeMode = 'GrowAndShrink';$form.Padding = New-Object System.Windows.Forms.Padding(15);

# Single auto-sizing label for all times
$timeLabel = New-Object System.Windows.Forms.Label;
$timeLabel.AutoSize =$true;
$timeLabel.Font = New-Object System.Drawing.Font("Consolas", 14, [System.Drawing.FontStyle]::Bold);
$timeLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#56B6C2");
$form.Controls.Add($timeLabel);

# Allow dragging the borderless window anywhere
$script:drag =$false;
$script:xOffset = 0;
$script:yOffset = 0;

$dragStart = {$script:drag = $true; $script:xOffset = $_.X; $script:yOffset = $_.Y };$dragMove = { if ($script:drag) {$form.Left += $_.X -$script:xOffset; $form.Top +=$_.Y - $script:yOffset } };$dragStop = { $script:drag =$false };

$timeLabel.add_MouseDown($dragStart);
$timeLabel.add_MouseMove($dragMove);
$timeLabel.add_MouseUp($dragStop);

# Build the Right-Click Context Menu for ultra-compact toggling
$menu = New-Object System.Windows.Forms.ContextMenuStrip;
$menu.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#282C34");
$menu.ForeColor = [System.Drawing.Color]::White;

$itemCT =$menu.Items.Add("Show Central Time");
$itemCT.CheckOnClick =$true;
$itemMT =$menu.Items.Add("Show Mountain Time");
$itemMT.CheckOnClick =$true;
$itemPT =$menu.Items.Add("Show Pacific Time");
$itemPT.CheckOnClick =$true;
$menu.Items.Add("-") | Out-Null;
$itemExit =$menu.Items.Add("Close Clock");
$itemExit.add_Click({$form.Close() });

$timeLabel.ContextMenuStrip =$menu;
$form.ContextMenuStrip =$menu;

# Core update loop
$timer = New-Object System.Windows.Forms.Timer;
$timer.Interval = 1000;

function Update-Clock {
    $now = [DateTime]::UtcNow;
    
    # Build a single multiline string dynamically based on toggles
    $text = "UTC: " + $now.ToString("HH:mm:ss");
    
    $et = [TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($now, "UTC", "Eastern Standard Time");
    $text += "`nET:  " + $et.ToString("hh:mm:ss tt");

    if ($itemCT.Checked) {
        $ct = [TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($now, "UTC", "Central Standard Time");
        $text += "`nCT:  " + $ct.ToString("hh:mm:ss tt");
    }
    if ($itemMT.Checked) {
        $mt = [TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($now, "UTC", "Mountain Standard Time");
        $text += "`nMT:  " + $mt.ToString("hh:mm:ss tt");
    }
    if ($itemPT.Checked) {
        $pt = [TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($now, "UTC", "Pacific Standard Time");
        $text += "`nPT:  " + $pt.ToString("hh:mm:ss tt");
    }

    $timeLabel.Text =$text;
}

$timer.add_Tick({ Update-Clock });
Update-Clock;
$timer.Start();

$form.ShowDialog() | Out-Null;