---@meta

--- Interface to Win32 SHGetFolderPath api
---@param name 
---| "COMMON_VIDEO" 
---| "COMMON_PICTURES"
---| "COMMON_MUSIC"
---| "COMMON_DOCUMENTS"
---| "COMMON_TEMPLATES"
---| "PROGRAM_FILES_COMMONX86"
---| "PROGRAM_FILES_COMMON"
---| "PROGRAM_FILESX86"
---| "SYSTEMX86"
---| "PROFILE"
---| "MYPICTURES"
---| "PROGRAM_FILES"
---| "COMMON_APPDATA"
---| "COMMON_FAVORITES"
---| "LOCAL_APPDATA"
---| "APPDATA"
---| "COMMON_DESKTOPDIRECTORY"
---| "COMMON_STARTUP"
---| "COMMON_PROGRAMS"
---| "COMMON_STARTMENU"
---| "TEMPLATES"
---| "FONTS"
---| "DESKTOPDIRECTORY"
---| "MYVIDEO"
---| "MYMUSIC"
---| "MYDOCUMENTS"
---| "STARTMENU"
---| "BITBUCKET"
---| "SENDTO"
---| "CSIDL_RECENT"
---| "CSIDL_STARTUP"
---| "CSIDL_FAVORITES"
---| "PERSONAL"
---| "DESKTOP"
---@param create? boolean
---@return string
function SHGetFolderPath(name, create)
end