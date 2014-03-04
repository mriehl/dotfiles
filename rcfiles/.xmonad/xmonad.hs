import XMonad
import XMonad.Config.Gnome
import XMonad.Actions.SpawnOn
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"

    xmonad $ gnomeConfig
        { modMask = mod4Mask
        , manageHook = manageDocks <+> manageSpawn <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
        	{ ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        , terminal = "lxterminal"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawnHere "gnome-screensaver-command -l")
        , ((controlMask, xK_Print), spawnHere "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawnHere "scrot")
        , ((mod4Mask .|. shiftMask, xK_s), spawnHere "synapse")
        , ((mod4Mask .|. shiftMask, xK_p), spawnHere "dmenu_run")
        ]
