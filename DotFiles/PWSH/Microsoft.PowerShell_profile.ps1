# Default
$SC = 'SilentlyContinue'

# Default is SSLv3 for PowerShell web commands!
if ([Net.ServicePointManager]::SecurityProtocol -notmatch 'TLS12')
{
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS11
  [Net.ServicePointManager]::SecurityProtocol += [Net.SecurityProtocolType]::TLS12
}

# Do we have Set-Culture
if (Get-Command -Name 'Set-Culture' -ErrorAction $SC)
{
  # Make the console talk English
  Set-Culture -CultureInfo en-US
}

if ($host.Name -eq 'ConsoleHost')
{
  [Console]::ResetColor()
  [Console]::Clear()

  #region SetDefaults
  # Get-Help in a new Window
  $PsDefaultParameterValues.add('Get-Help:ShowWindow',$True)

  # Auto Format Table Output
  $PsDefaultParameterValues.add('Format-Table:AutoSize',$True)
  #endregion SetDefaults

  # Set the OutputEncoding to Unicode
  [Console]::OutputEncoding = [Text.Encoding]::UTF8

  # Color
  $host.PrivateData.ErrorBackgroundColor = $host.UI.RawUI.BackgroundColor
  $host.PrivateData.WarningBackgroundColor = $host.UI.RawUI.BackgroundColor
  $host.PrivateData.VerboseBackgroundColor = $host.UI.RawUI.BackgroundColor

  if (Get-Command -Name 'Set-PSReadlineOption' -ErrorAction $SC)
  {
    # Reset
    if (!($PSVersionTable.PSEdition))
    {
      $null = (Set-PSReadLineOption -ResetTokenColors -ErrorAction $SC -WarningAction $SC)
    }

    # General
    $null = (Set-PSReadLineOption -EditMode Windows -ErrorAction $SC -WarningAction $SC)

    # Tab
    $null = (Set-PSReadLineKeyHandler -Key Tab -Function TabCompleteNext -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Key Ctrl+Tab -Function Complete -ErrorAction $SC -WarningAction $SC)

    # History
    $null = (Set-PSReadLineOption -HistorySearchCursorMovesToEnd -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward -ErrorAction $SC -WarningAction $SC)


    # History Settings #
    $null = (Set-PSReadLineOption -HistoryNoDuplicates:$True -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineOption -MaximumHistoryCount 8000 -ErrorAction $SC -WarningAction $SC)

    # Bell #
    $null = (Set-PSReadLineOption -BellStyle Visual -ErrorAction $SC -WarningAction $SC)

    # In Emacs mode - Tab acts like in bash, but the Windows style completion is still useful sometimes, so bind some keys so we can do both
    $null = (Set-PSReadLineKeyHandler -Key Ctrl+Q -Function TabCompleteNext -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Key Ctrl+D -Function TabCompletePrevious -ErrorAction $SC -WarningAction $SC)

    # Keys
    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+Shift+RightArrow -Function ShellForwardWord -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+Shift+LeftArrow -Function ShellBackwardWord -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+Backspace -Function ShellBackwardKillWord -ErrorAction $SC -WarningAction $SC)

    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+Z -Function Undo -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+Shift+Z -Function Redo -ErrorAction $SC -WarningAction $SC)

    #Set-PSReadlineKeyHandler -Chord Ctrl+v -Function Paste
    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+Shift+V -Function Paste -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+Shift+C -Function Copy -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+Shift+X -Function Cut -ErrorAction $SC -WarningAction $SC)

    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+a -Function BeginningOfLine -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+e -Function EndOfLine -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+w -Function BackwardKillWord -ErrorAction $SC -WarningAction $SC)
    $null = (Set-PSReadLineKeyHandler -Chord Ctrl+d -Function DeleteCharOrExit -ErrorAction $SC -WarningAction $SC)
  }

  #region Tweaks
  $PsDefaultParameterValues = @{
    '*-Csv:Delimiter'                      = ';'
    '*-Csv:NoTypeInformation'              = $True
    'Add-DnsServerResourceRecord*:CreatePtr' = $True
    'Get-AD*:Properties'                   = '*'
  }
  #endregion Tweaks

  #region Prompt
  if ((-not $IsLinux) -and (-not $IsMacOS))
  {
    function prompt
    {
      $path = $pwd.path.replace($HOME, '~')
      Write-Output -InputObject ('PS ' + $path + '> ')
      # Blank
      Return ' '
    }
  }
  #endregion Prompt

  #region Title
  $a = ((Get-Host).UI.RawUI)

  $localUser = $null
  $localUser = ([Environment]::UserName)

  if ($localUser)
  {
    $a.WindowTitle = "$localUser > [PowerShell]"
  }
  else
  {
    [PowerShell]
  }
  #endregion Title

  function Global:Invoke-VSCode
  {
    <#
        .SYNOPSIS
        Invoke VisualStudio Code

        .DESCRIPTION
        Invoke VisualStudio Code

        .PARAMETER File
        File to Edit

        .PARAMETER insider
        Use Insider Build if availible

        .EXAMPLE
        PS C:\> Invoke-VSCode

        .NOTES
        Additional information about the function.
    #>

    [CmdletBinding()]
    param
    (
      [Parameter(ValueFromPipeline,
      Position = 1)]
      [Alias('open')]
      [string]
      $File,
      [switch]
      $insider
    )

    Begin
    {
      # Variables
      $STP = 'Stop'
      $SC = 'SilentlyContinue'
      # Cleanup

      $VSCBIN = $null

      if ($IsMacOS)
      {
        # Running Core on macOS
        if ($insider)
        {
          if (Test-Path -Path '/Applications/Visual Studio Code - Insiders.app/Contents/MacOS/Electron' -ErrorAction $SC)
          {
            $VSCBIN = '/Applications/Visual Studio Code - Insiders.app/Contents/MacOS/Electron'
          }

          if (-not $VSCBIN)
          {
            if (Test-Path -Path '/Applications/Tools/Visual Studio Code - Insiders.app/Contents/MacOS/Electron' -ErrorAction $SC)
            {
              $VSCBIN = '/Applications/Tools/Visual Studio Code - Insiders.app/Contents/MacOS/Electron'
            }
          }

          if (-not $VSCBIN)
          {
            # Whoopsie!
            Write-Error -Message 'We are unable to find an Visual Studio Core Insider Build on your system' -Category ObjectNotFound -RecommendedAction 'Check your system' -ErrorAction $STP

            # Point of no return
            break
          }
        }
        else
        {
          if (Test-Path -Path '/Applications/Visual Studio Code.app/Contents/MacOS/Electron' -ErrorAction $SC)
          {
            $VSCBIN = '/Applications/Visual Studio Code.app/Contents/MacOS/Electron'
          }
        }
      }
      elseif ($IsLinux)
      {
        # Running Core on Linux

        <#
            Not Supported yet!
        #>
        # Cleanup
        $VSCBIN = $null
      }
      elseif ($IsWindows)
      {
        # Running Core on Windows
        if (-not $VSCBIN)
        {
          if (Test-Path -Path "$env:ProgramFiles\Microsoft VS Code\Code.exe" -ErrorAction $SC)
          {
            $VSCBIN = "$env:ProgramFiles\Microsoft VS Code\Code.exe"
          }
        }
      }
      else
      {
        # Running Desktop on Windows
        if (-not $VSCBIN)
        {
          if (Test-Path -Path "$env:ProgramFiles\Microsoft VS Code\Code.exe" -ErrorAction $SC)
          {
            $VSCBIN = "$env:ProgramFiles\Microsoft VS Code\Code.exe"
          }
        }
      }

      if (-not $VSCBIN)
      {
        # Whoopsie!
        Write-Error -Message 'We are unable to find any Visual Studio Core installation on your system' -Category ObjectNotFound -RecommendedAction 'Check your system' -ErrorAction $STP

        # Point of no return
        break
      }
    }

    Process
    {
      $null = (Start-Process -FilePath $VSCBIN -ArgumentList $File -LoadUserProfile:$false -Wait:$false)
    }

    End
    {
      # Cleanup
      $VSCBIN = $null
    }
  }


  #region GetHome
  Push-Location -Path $HOME
  #endregion GetHome


  [Console]::Clear()
  [Console]::CursorLeft = 0
  [Console]::CursorTop = 0
  Return ' '
}
