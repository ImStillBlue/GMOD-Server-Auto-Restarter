Add-Type -AssemblyName PresentationFramework

[xml]$XAML = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Gmod Server Auto Restarter" Height="300" Width="500"
    WindowStartupLocation="CenterScreen">
    <Window.Resources>
        <Style TargetType="Button">
            <Setter Property="Margin" Value="5"/>
            <Setter Property="Padding" Value="10,5"/>
            <Setter Property="Background" Value="#FF4CAF50"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="BorderThickness" Value="0"/>
        </Style>
        <Style TargetType="TextBox">
            <Setter Property="Margin" Value="5"/>
            <Setter Property="Padding" Value="5"/>
        </Style>
        <Style TargetType="Label">
            <Setter Property="Margin" Value="5"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
        </Style>
    </Window.Resources>
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <StackPanel Grid.Row="0" Orientation="Horizontal" Margin="10">
            <Label Content="srcds.exe Path:"/>
            <TextBox x:Name="SrcdsPathTextBox" Width="300"/>
            <Button x:Name="BrowseButton" Content="Browse"/>
        </StackPanel>
        <StackPanel Grid.Row="1" Margin="10">
            <Label Content="Additional Arguments:"/>
            <TextBox x:Name="AdditionalArgsTextBox" Height="80" TextWrapping="Wrap" VerticalScrollBarVisibility="Auto"/>
        </StackPanel>
        <StackPanel Grid.Row="2" Orientation="Horizontal" HorizontalAlignment="Center">
            <Button x:Name="StartButton" Content="Start"/>
        </StackPanel>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$window = [Windows.Markup.XamlReader]::Load($reader)

$SrcdsPathTextBox = $window.FindName("SrcdsPathTextBox")
$AdditionalArgsTextBox = $window.FindName("AdditionalArgsTextBox")
$BrowseButton = $window.FindName("BrowseButton")
$StartButton = $window.FindName("StartButton")

$configFile = "settings.txt"

# Load the configuration from the file if it exists
if (Test-Path $configFile) {
    $config = Get-Content $configFile | ConvertFrom-Json
    $SrcdsPathTextBox.Text = $config.srcdsPath
    $AdditionalArgsTextBox.Text = $config.additionalArgs
}

$BrowseButton.Add_Click({
    $openFileDialog = New-Object Microsoft.Win32.OpenFileDialog
    $openFileDialog.Filter = "Executable Files (*.exe)|*.exe"
    if ($openFileDialog.ShowDialog() -eq $true) {
        $SrcdsPathTextBox.Text = $openFileDialog.FileName
    }
})

$StartButton.Add_Click({
    $srcdsPath = $SrcdsPathTextBox.Text
    $additionalArgs = $AdditionalArgsTextBox.Text

    if ($srcdsPath) {
        $StartButton.IsEnabled = $false
        $global:runspaceHandle = $null

        $runspace = [runspacefactory]::CreateRunspace()
        $runspace.Open()
        $runspace.SessionStateProxy.SetVariable("srcdsPath", $srcdsPath)
        $runspace.SessionStateProxy.SetVariable("additionalArgs", $additionalArgs)

        $powershell = [powershell]::Create()
        $powershell.Runspace = $runspace

        $script = {
            while (!$stopServer) {
                $srcdsProcess = Start-Process -FilePath $srcdsPath -ArgumentList $additionalArgs -PassThru
                $srcdsProcess.WaitForExit()
            }
        }

        $powershell.AddScript($script) | Out-Null
        $global:runspaceHandle = $powershell.BeginInvoke()
    }
})

$window.Add_Closed({
    # Save the configuration to the file when the window is closed
    $config = @{
        srcdsPath = $SrcdsPathTextBox.Text
        additionalArgs = $AdditionalArgsTextBox.Text
    }
    $config | ConvertTo-Json | Set-Content $configFile
})

$window.ShowDialog() | Out-Null