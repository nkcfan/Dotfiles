#-- remember to run as Admin, and set PS execution policy
Set-ExecutionPolicy Unrestricted

#-- Chocolatey itself
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'));

#-- Install applications
cinst 7zip.install
cinst ConEmu
# cinst 7zip.commandline

#-- virtual file systems
cinst dropbox
# cinst onedrive
# cinst googledrive

#-- developer tools
# cinst TortoiseGit 
# cinst tortoisesvn
# cinst AnkhSvn 
# cinst githubforwindows 
cinst notepadplusplus.install
# cinst Atom
# cinst snoop 
# cinst diffmerge 
# cinst windirstat 
# cinst dotPeek
cinst git
cinst SourceTree
cinst git-credential-winstore
cinst java.jdk
cinst python2
cinst python
cinst vcredist2005
cinst winscp

#-- iso tools
# cinst VirtualCloneDrive 
# cinst imgburn 

#-- browsers
cinst GoogleChrome
# cinst Firefox 

#-- tools
# cinst 1password 
# cinst CutePDF 
cinst fiddler4
# cinst reshack

#-- applications
# cinst paint.net
# cinst libreoffice
# cinst SharpKeys
# cinst MarkdownPad

#-- no longer used
#cinst nsis 
#cinst thunderbird 
#cinst pidgin 

#-- Currently fail
# cinst IcoFx 
# cinst FoxitReader
# cinst ActivePerl 
