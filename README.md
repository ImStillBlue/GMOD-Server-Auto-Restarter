# Gmod Server Auto Restarter

Gmod Server Auto Restarter is a user-friendly PowerShell script that simplifies the process of managing a Garry's Mod dedicated server. It provides a sleek graphical interface for starting and monitoring the server, with the added functionality of automatically restarting the server if it crashes or stops.

## Features
 - Intuitive graphical user interface (GUI) built with Windows Presentation Foundation (WPF)
 - Automatically saves and loads the last used srcds.exe path and additional arguments for convenience
 - Supports specifying custom command-line arguments for the server
 - Automatically restarts the server if it crashes or stops, ensuring minimal downtime
 - Sleek and visually appealing design for a pleasant user experience

## Prerequisites
 - Windows operating system
 - PowerShell 5.1 or later
 - Garry's Mod dedicated server files

 ## Installation / Usage Method 1 (Preferred)
 - Go to [Releases](https://github.com/ImStillBlue/GMOD-Server-Auto-Restarter/releases) and download the latest (`.exe`)
 - Place the script in a convenient location on your computer.
 - Open (`.exe`)
 - The Gmod Server Auto Restarter GUI will appear.
 - Click the "Browse" button to select the path to your srcds.exe file (usually located in your Garry's Mod dedicated server directory).
 - The script will remember the last used path for future sessions.
 > [!CAUTION]
 > Modify the additional command-line arguments in the "Additional Arguments" text box.

 ## Installation / Usage Method 2 (Not Preferred)
 - Download the (`GMODServerAutoRestarter.ps1`) script from this repository.
 - Place the script in a convenient location on your computer.

 - Right-click on the (`GMODServerAutoRestarter.ps1`) script and select "Run with PowerShell".
***If you encounter a security warning, you may need to adjust your PowerShell execution policy to allow running scripts.***
 - The Gmod Server Auto Restarter GUI will appear.
 - Click the "Browse" button to select the path to your srcds.exe file (usually located in your Garry's Mod dedicated server directory).
 - The script will remember the last used path for future sessions.
 > [!CAUTION]
 > Modify the additional command-line arguments in the "Additional Arguments" text box.
 ### Example
 ```
-console -game garrysmod +exec server.cfg +gamemode darkrp +host_workshop_collection 0000000000 +map gm_construct +maxplayers 16
 ```
 - The script will save and load the last used additional arguments for convenience.
 - Click the "Start" button to start the Garry's Mod server.
 - The server will automatically restart if it crashes or stops.
 - To stop the server, simply close the Gmod Server Auto Restarter window.

## Configuration
 - The script automatically saves and loads the server configuration from a file named (`settings.txt`) in the same directory as the script. You can manually edit the (`settings.txt`) file to modify the server configuration if needed. The configuration file stores the following information:
### ('Settings.txt') Example
```
{
    "srcdsPath":  "C:\\gmod\\srcds.exe",
    "additionalArgs":  "-console -game garrysmod +exec server.cfg +gamemode darkrp +host_workshop_collection 0000000000 +map gm_construct +maxplayers 16"
}
```

## Customization
 - Adjust the window size and layout by modifying the XAML code in the script.
 - Customize the styles and colors of the GUI elements by modifying the styles defined in the Window.Resources section of the XAML code.

## Acknowledgements
 - The script utilizes the Windows Presentation Foundation (WPF) for creating the graphical user interface.
 - The Garry's Mod dedicated server is the property of Facepunch Studios.

## Disclaimer
This script is provided as-is without any warranty. Use it at your own risk. The author is not responsible for any damage or loss caused by the use of this script.

## License

This script is open-source and available under the [MIT License](LICENSE).
   
