WinAceUpdater - An update tool for the Ace community of addons.

License: zlib/libpng - see included License.txt
  
Requirements:
    * Windows 98 or later
    * .NET 2.0 Runtime - available from 
       http://msdn.microsoft.com/netframework/downloads/updates/default.aspx

Description:
    This tool provides an easy way for you to keep your Ace addons up to date.
    When it first launches, it will download a list of available addons from
    http://www.wowace.com/files. If it can determine your local World of
    Warcraft installation folder, it will also compare that list with the 
    addons you currently have installed and pre-check them.
    
    Check the boxes of any addons you want to update/download and choose
    "Update Checked Addons" from the File menu (or press F12). The status of
    the download will be presented in the lower pane.
    
    Source code and updates for this will be made available on sourceforge.net
    as soon as the project site becomes available.
    
Options:
    By choosing Preferences from the Edit menu, you can fine-tune the behavior
    of WinAceUpdater. The following options are available:
    
    AceFilesPath: The location of the Ace files repository. Do not change this
        value unless you are instructed to do so.
        Default: http://www.wowace.com/files/
    ConfirmSync: Confirm before downloading and installing.
        Default: True
    DeleteBeforeExtracting: Delete local files before installing. This can be
        used to clean up any old files that don't belong any more.
        Default: False
    DisplayBackupWarningAtStartup: Displays a warning at startup reminding you
        to backup your addons folder.
        Default: True
    LoadIndexOnStartup: If set to true, the list of available addons will be 
        loaded at startup.
        Default: True
    ShowInstalledAddons: If set to true, the system will attempt to determine
        whether an addon is installed when the list is loaded from the server
        and will check the box for that addon.
        Default: True
    SkipExternals: If set to true, the addon will be downloaded without
        "externals". Externals are shared libraries that are embedded with Ace2
        addons. This is an advanced setting that should only be set to true
        if you know how to troubleshoot and identify missing libraries!
        Default: False
    SkipSvnWorkingCopies:
        If set to true, it will skip any installed addon that has a .svn 
        folder in the root. Good for developers who don't want their working 
        copies lost, but also useful if you want an addon to be ignored because
        you have private changes or custom files.
        Default: True
    SkipVersionCheck: If set to true, all checked addons will be downloaded and
        installed and no version comparison will be performed. If set to false,
        an addon will only be downloaded and installed if there is a newer 
        version on the server.
        Default: False
    UseRecycleBin:
        When true, it will move things it deletes to the Windows Recycle Bin instead of deleting them. 
        Default: True
    WowInstallDirectory:
        Default: <auto-populated>
        
Todo List:
    * Better options dialog
    * Extract into a safe place and copy over if extract successful
    * Figure out what's wrong with TinyTooltipOptions zip file