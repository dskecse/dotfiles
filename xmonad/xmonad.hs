import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.FloatKeys
import XMonad.Actions.NoBorders
import XMonad.Actions.CopyWindow
import XMonad.Actions.SpawnOn
import XMonad.Config.Gnome
import XMonad.Layout.Gaps
import XMonad.ManageHook
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys, additionalMouseBindings)

import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Layout.Spacing

import qualified XMonad.StackSet as W

button6     =  6 :: Button
button7     =  7 :: Button
button8     =  8 :: Button
button9     =  9 :: Button
button10    = 10 :: Button
button11    = 11 :: Button
button12    = 12 :: Button
button13    = 13 :: Button
button14    = 14 :: Button
button15    = 15 :: Button

myStartupHook :: X ()
myStartupHook = do
  spawn "xsetroot -cursor_name left_ptr"
  spawn "xset s off"
  spawnOn "2" "xfce4-terminal"

myManageHook :: [ManageHook]
myManageHook =
    [ appName   =? "Do"                                  --> doIgnore
    , appName   =? "matlab"                              --> doFloat
    , className =? "Google-chrome"                       --> doShift "1"
    , className =? "Skype"                               --> doShift "3"
    , appName   =? "vmware"                              --> doShift "4"
    , className =? "Claws-mail"                          --> doShift "9"
    , className =? "Mail"                                --> doShift "9"
    , className =? "MPlayer"                             --> doFloat
    , className =? "Vmware-modconfig"                    --> doCenterFloat
    , className =? "Gnome-mount"                         --> doCenterFloat
    , className =? "Gnome-desktop-item-edit"             --> doCenterFloat
    , className =? "."                                   --> doCenterFloat
    , className =? "Gtg"                                 --> doCenterFloat
    , className =? "sun-awt-X11-XFramePeer"              --> doCenterFloat
    , className =? "sun-awt-X11-XDialogPeer"             --> doCenterFloat
    , className =? "java-lang-Thread"                    --> doCenterFloat
    , className =? "java"                                --> doCenterFloat
    , title     =? "Adding Owner..."                     --> doCenterFloat
    , title     =? "Authorize Passphrase Access"         --> doCenterFloat
    , title     =? "Downloading Package Files"           --> doCenterFloat
    , title     =? "Applying Changes"                    --> doCenterFloat
    , title     =? "Adding option to alternative"        --> doCenterFloat
    , isFullscreen                                       --> doFullFloat
    , isDialog                                           --> doCenterFloat
    , className =? "Xfce4-appfinder"                     --> doCenterFloat
    , className =? "Xfrun4"                              --> doCenterFloat
    , className =? "xfce4-panel"                         --> doIgnore
    , className =? "Xfce4-panel"                         --> doIgnore
    ]

myConfig = gnomeConfig
    { manageHook = manageSpawn <+> manageHook gnomeConfig <+> composeAll myManageHook
    , startupHook = myStartupHook
    , workspaces = map show [1 .. 10 :: Int]
    , modMask = mod4Mask
    , terminal = "xfce4-terminal"
    } `additionalKeys`

        [ ((modMask(myConfig)              , xK_s ),            prevWS                                )
        , ((modMask(myConfig)              , xK_d ),            nextWS                                )
        , ((modMask(myConfig)              , xK_Right ),        nextWS                                )
        , ((modMask(myConfig)              , xK_Left ),         prevWS                                )
        , ((modMask(myConfig)              , xK_u),             withFocused toggleBorder              )
        , ((modMask(myConfig)              , xK_b),             withFocused toggleBorder >>
                                                                sendMessage ToggleStruts              )
        , ((modMask(myConfig)              , xK_v),             windows copyToAll                     ) -- @@ Make focused window always visible
        , ((modMask(myConfig) .|. shiftMask, xK_v),             killAllOtherCopies                    ) -- @@ Toggle window state back
        , ((modMask(myConfig)              , xK_Escape),        kill                                  ) -- @@ Kill current window with mod + Esc
        , ((0                              , xK_Cancel),        kill                                  ) -- @@ Kill current window with special key Cancel
        , ((0                              , xK_Print),         spawn "xfce4-screenshooter -f"        )
        , ((modMask(myConfig)              , xK_L),             spawn "xflock4"                       ) -- @@ Lock screen
        , ((modMask(myConfig)              , xK_j),             setWMName "LG3D"                      ) -- @@ Java hack
        , ((modMask(myConfig)              , xK_r),             withFocused $
                                                                keysMoveWindowTo (-1, -1) (0, 0)      )
        ]

      `additionalMouseBindings`

        [ ((0                              , button13),          (\w -> focus w >> mouseMoveWindow w
                                                                               >> windows W.shiftMaster)) -- @@ button8 %! set the window to floating mode and move by dragging
        , ((0                              , button9),          (\w -> focus w >> mouseMoveWindow w
                                                                               >> windows W.shiftMaster)) -- @@ button8 %! set the window to floating mode and move by dragging
        , ((0                              , button8),          (\w -> focus w >> mouseResizeWindow w
                                                                               >> windows W.shiftMaster)) -- @@ button9 %! set the window to floating mode and resize by dragging
        , ((modMask(myConfig)              , button5),          (\w -> windows W.swapDown              )) -- @@ Mouse scroll wheel to raise/lower windows
        , ((modMask(myConfig)              , button4),          (\w -> windows W.swapUp                ))
        ]

main = xmonad $ ewmh myConfig