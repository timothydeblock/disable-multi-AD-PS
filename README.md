# Disable-multi-AD-PS

http://www.timothydeblock.com/blog/2014/6/9/disable-multiple-active-directory-accounts-using-powershell

Disable multiple Active Directory accounts using PowerShell

Two weeks ago I created my first PowerShell script. It’s nothing special, just a script to disable multiple Active Directory accounts from a .csv file. Still, I’m quite proud of it considering I’ve never created a PowerShell script before and that I was able to do it on my own (Google searches notwithstanding).

Preparation

First, I grabbed PowerGUI Script Editor to create my PowerShell script (http://en.community.dell.com/techcenter/powergui/m/bits/20439049.aspx). Next I put all the accounts that need to be disabled in single column on a new spreadsheet. At the top of the column I put ‘samaccount.’ This is needed for part of the script to work. I then saved the spreadsheet as a .csv file.

Building the script

I opened PowerGUI Script Editor and started a new script. A Google search found me these lines of code::

$namelist=Import-Csv C:\DisableADAccounts.csv

foreach($name in $namelist){Disable-ADAccount -Identity $name.samaccount }

With ‘$namelist’ you are defining where your .csv file will import from. The ‘C:\DisableADAccounts.csv’ will be wherever you place the file you want the script to use. I placed the script and the .csv file right onto the C drive. If you prefer a little more organization you can put it in a folder on the C drive, just make sure the location reflects that, example: ‘C:\Scripts\DisableADAccounts.csv’

‘foreach’ is a looping statement (http://www.powershellpro.com/powershell-tutorial-introduction/logic-using-loops/). It will execute a command for each item or ‘$name’ in your .csv file. The statements inside the { } are the command you want to execute. In this case I am disabling the AD Account (Disable-ADAccount) for the names under (-Identity) the samaccount column ($name.samaccount).

Before you execute the script you can use the ‘-whatif’ command after ‘$name.samaccount’ and see what the script will do. I ran this from PowerGUI by hitting the green play triangle button on the toolbar.

Now, if you try to run this script as is (like I did), error messages will pop up indicating bad commands and syntax. In my case I was missing Import-Module activedirectory, which opens up all the commands to run a PowerShell script in Active Directory.

The final script should look like this:

Import-Module activedirectory

$namelist=Import-Csv C:\PortalDisableFinal.csv

foreach($name in $namelist){Disable-ADAccount -Identity $name.samaccount }

Running the script

Once you have the .csv file and the PowerShell script put together, both need to be transferred to the server that Active Directory is on. Make sure Active Directory Module for Windows PowerShell is installed on the server (http://technet.microsoft.com/en-us/library/hh847837.aspx; http://blogs.msdn.com/b/rkramesh/archive/2012/01/17/how-to-add-active-directory-module-in-powershell-in-windows-7.aspx). That will be needed to run the script.

Open the Active Directory Module for Windows PowerShell. Change to the directory that the files are saved. To get back to C drive use “cd ../..” or if the files are in a different location use “cd c:\scripts\powershell.” Once you’re in the directory where the files are located begin typing the name of the script then hit the Tab key and PowerShell will autofill the script for you. Hit enter. Script should execute. Check to make sure the accounts or a handful of accounts (if you’re disabling hundreds or thousands of accounts) have been properly disabled and if they are you’ve successful run the script.

You can also run the script from PowerGUI on the box that the script needs to run.

Any questions or feedback can be left in the comment section.
