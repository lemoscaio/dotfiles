# Caio's dotfiles

## How To Install (Windows):

1. ### Powershell 
   - Download Hack font from Nerd Fonts
   - Change the font on Windows Terminal configuration
   - Activate the acrilic background and set the opacity to 50%
   - Duplicate the One Half Dark theme on PowerShell settings.json (openning via terminal) and change the "background" to "#001B26".

1.  ### Scope:

        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser 
        # Optional: Needed to run a remote script the first time

        irm get.scoop.sh | iex

1.  ### VIM:

        scoop install neovim gcc

1.  ### Open Powershell Profile Config:

    - One of the following:
 
        nvim $PROFILE.CurrentUserCurrentHost
        notepad $PROFILE.CurrentUserCurrentHost

    - Inside the file, insert the exactly line:

        . $env:USERPROFILE\.config\powershell\user_profile.ps1

    - Close the file and save (:wqa for saving in VIM)
  
1. ### Oh My Posh:

        Install-Module posh-git -Scope CurrentUser -Force

        winget install JanDeDobbeleer.OhMyPosh -s winget
   - (different from the devasalife video but a new way to install oh-my-posh, further info: https://ohmyposh.dev/docs/migrating)

    Change the theme inside the user_profile.ps1 file or enable a custom theme by adding and removing the # on the correct lines.

1. ### Install Powershell Modules:

   - Terminal Icons: 

            Install-Module -Name Terminal-Icons -Repository PSGallery -Force
      - (This module is imported automatically on user_profile.ps1)

   - Z: 

           Install-Module -Name z -Force

   - PSReadLine - Autocomplete

           Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck

   - PSFzf:

     - First, install fzf with scoop:

           scoop install fzf

     - Then:
     
           Install-Module -Name PSFzf -Scope CurrentUser -Force

### Additional info

- To use the same repository folder after cloning, you need to create a symbolic link to each file/folder:

		new-item -itemtype symboliclink -path <to> -name powershell -value <from>

  - where: 

	-name : the name of the created folder

	-path : where the folder will be created

	-value : where the original folder is

  - Example: 

		new-item -itemtype symboliclink -path C:\Users\caio_\.config\ -name powershell -value   C:\Users\caio_\dotfiles\.config\powershell


- Some configuration lines, such as "Set-PSReadLineOption -PredictionSource History", is set inside user_profile.ps1 and loaded when Powershell opens.

 - [In case of fire, this is the video where I learned it all from](https://www.youtube.com/watch?v=5-aK2_WwrmM)

#

## How To Install (Linux):

Soon