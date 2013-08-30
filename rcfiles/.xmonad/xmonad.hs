import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"

    xmonad $ gnomeConfig
        { modMask = mod4Mask
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
        	{ ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 100
            }
        , terminal = "lxterminal"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "gnome-screensaver-command -l")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((mod4Mask .|. shiftMask, xK_p), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
        ]
