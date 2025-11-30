import XMonad
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Actions.PhysicalScreens (viewScreen)
import XMonad.Actions.CycleWS (nextWS, prevWS)
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing (spacingWithEdge)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks (avoidStruts, docks, ToggleStruts(..))
import qualified XMonad.StackSet as W
import Graphics.X11.ExtraTypes.XF86

-- Main Configuration
main :: IO ()
main = xmonad . ewmhFullscreen . ewmh . docks . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) toggleStrutsKey $ myConfig

-- Custom toggle struts key
toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig =
    def
        { terminal           = myTerminal
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook
        , manageHook         = myManageHook
        , borderWidth        = myBorderWidth
        , focusFollowsMouse  = True
        , clickJustFocuses   = False
        }
        `additionalKeys` myKeys

-- Settings
myTerminal :: String
myTerminal = "ghostty"

myModMask :: KeyMask
myModMask = mod4Mask

myBorderWidth :: Dimension
myBorderWidth = 0

myGapSize :: Int
myGapSize = 5

-- Workspaces
myWorkspaces :: [String]
myWorkspaces = ["一","二","三","四","五","六","七","八","九"]
-- You can customize with names like: ["web", "code", "term", "4", "5", "6", "7", "8", "9"]

-- Layout Configuration (gaps + no borders)
myLayoutHook =
    avoidStruts $
    noBorders $
    spacingWithEdge myGapSize $
    layoutHook def

-- Manage Hook
myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? c --> doFloat | c <- myFloatClasses ]
  where
    myFloatClasses = []  -- add class names here if you want auto-floats

-- Xmobar Configuration
myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = " | "
    , ppCurrent         = xmobarColor "#98be65" "" . wrap "[" "]"   -- Current workspace
    , ppVisible         = xmobarColor "#51afef" ""                  -- Visible but not current workspace
    , ppHidden          = xmobarColor "#c678dd" ""                  -- Workspaces with windows
    , ppHiddenNoWindows = xmobarColor "#5b6268" ""                  -- Empty workspaces
    , ppTitle           = xmobarColor "#ecbe7b" "" . shorten 60     -- Window title
    , ppUrgent          = xmobarColor "#ff6c6b" "" . wrap "!" "!"   -- Urgent workspace
    , ppLayout          = const ""                                    -- Hide layout name
    }

-- Keybindings
myKeys :: [((KeyMask, KeySym), X ())]
myKeys =
    [ ((myModMask, xK_q)                    , kill)
    , ((myModMask, xK_d)                    , spawn "rofi -show drun")
    , ((myModMask, xK_Return)               , spawn myTerminal)
    , ((myModMask .|. shiftMask, xK_Return) , spawn "thunar")
    , ((myModMask, xK_t)                    , withFocused $ windows . W.sink)
    , ((myModMask, xK_f)                    , withFocused fullscreenFloat)
    -- Workspace navigation with arrow keys
    , ((myModMask .|. shiftMask, xK_Right)  , nextWS)
    , ((myModMask .|. shiftMask, xK_Left)   , prevWS)
    ]
    -- Workspace switching: Mod + [1..9] to switch to workspace with animation
    ++ [((myModMask, k), spawn $ "/home/lain/.local/bin/workspace-switch.sh " ++ show n)
        | (n, k) <- zip [0..8] [xK_1 .. xK_9]]
    -- Move window to workspace: Mod + Shift + [1..9]
    ++ [((myModMask .|. shiftMask, k), windows $ W.shift i)
        | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]]

-- Window Actions
fullscreenFloat :: Window -> X ()
fullscreenFloat w =
    windows $ W.float w (W.RationalRect 0 0 1 1)

-- Startup Hook
myStartupHook :: X ()
myStartupHook = do
    viewScreen def 1
    spawn "xdotool mousemove 2890 560"
    spawn "feh --bg-scale /home/lain/Pictures/Wallpaper-Left /home/lain/Pictures/Wallpaper-Right"
    spawnOnce "picom -b --config ~/.config/picom/picom.conf"
    spawnOnce "steam"