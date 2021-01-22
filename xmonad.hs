-- xmonad example config file for xmonad-0.9
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
-- NOTE: Those updating from earlier xmonad versions, who use
-- EwmhDesktops, safeSpawn, WindowGo, or the simple-status-bar
-- setup functions (dzen, xmobar) probably need to change
-- xmonad.hs, please see the notes below, or the following
-- link for more details:
--
-- http://www.haskell.org/haskellwiki/Xmonad/Notable_changes_since_0.8
--
{-# LANGUAGE PartialTypeSignatures #-}

import XMonad
import Data.Monoid
import System.Exit
import Data.Tree

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Actions.CycleRecentWS
--import XMonad.Actions.GridSelect
import XMonad.Actions.TreeSelect
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Util.TreeZipper

import System.IO
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 4

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod1Mask

-- NOTE: from 0.9.1 on numlock mask is set automatically. The numlockMask
-- setting should be removed from configs.
--
-- You can safely remove this even on earlier xmonad versions unless you
-- need to set it to something other than the default mod2Mask, (e.g. OSX).
--
-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
-- myNumlockMask   = mod2Mask -- deprecated in xmonad-0.9.1
------------------------------------------------------------


-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["web","editor","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

-- tree select stuff

myTreeConf = TSConfig { ts_hidechildren = True
                           , ts_background   = 0xc0c0c0c0
                           , ts_font         = "xft:Sans-16"
                           , ts_node         = (0xff000000, 0xff50d0db)
                           , ts_nodealt      = (0xff000000, 0xff10b8d6)
                           , ts_highlight    = (0xffffffff, 0xffff0000)
                           , ts_extra        = 0xff000000
                           , ts_node_width   = 200
                           , ts_node_height  = 30
                           , ts_originX      = 0
                           , ts_originY      = 0
                           , ts_indent       = 80
                           , ts_navigate     = colemakNav
                           }
--colemakNav :: M.Map (KeyMask, KeySym) (TreeSelect a (Maybe a))
colemakNav = M.fromList
    [ ((0, xK_Escape), cancel)
    , ((0, xK_Return), select)
    , ((0, xK_space),  select)
    , ((0, xK_Up),     movePrev)
    , ((0, xK_Down),   moveNext)
    , ((0, xK_Left),   moveParent)
    , ((0, xK_Right),  moveChild)
    , ((0, xK_e),      movePrev)
    , ((0, xK_n),      moveNext)
    , ((0, xK_h),      moveParent)
    , ((0, xK_i),      moveChild)
    , ((0, xK_y),      moveHistBack)
    , ((0, xK_u),      moveHistForward)
    ]
-- grid select stuff
--myNavigation :: TwoD a (Maybe a)
--myNavigation = makeXEventhandler $ shadowWithKeymap navKeyMap navDefaultHandler
 --where navKeyMap = M.fromList [
          --((0,xK_Escape), cancel)
         --,((0,xK_Return), select)
         --,((0,xK_slash) , substringSearch myNavigation)
         --,((0,xK_Left)  , move (-1,0)  >> myNavigation)
         --,((0,xK_h)     , move (-1,0)  >> myNavigation)
         --,((0,xK_Right) , move (1,0)   >> myNavigation)
         --,((0,xK_i)     , move (1,0)   >> myNavigation)
         --,((0,xK_Down)  , move (0,1)   >> myNavigation)
         --,((0,xK_n)     , move (0,1)   >> myNavigation)
         --,((0,xK_Up)    , move (0,-1)  >> myNavigation)
         --,((0,xK_e)    , move (0,-1)  >> myNavigation)
         ----,((0,xK_y)     , move (-1,-1) >> myNavigation)
         ----,((0,xK_i)     , move (1,-1)  >> myNavigation)
         ----,((0,xK_n)     , move (-1,1)  >> myNavigation)
         ----,((0,xK_m)     , move (1,-1)  >> myNavigation)
         --,((0,xK_space) , setPos (0,0) >> myNavigation)
         --]
       ---- The navigation handler ignores unknown key symbols
       --navDefaultHandler = const myNavigation
--gsconfig1 = defaultGSConfig { gs_cellheight = 100, gs_cellwidth = 200, gs_navigate = myNavigation }

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
--toWorkspaces1 :: Forest String -> [WorkspaceId]
--toWorkspaces1 = map snd . concatMap flatten . mkPaths


-- pseudocode
-- treeselect which gives a path
-- take that path, find all its siblings/children and put them in dynamic workspaces.
    -- question. hide the other workspaces? so they stay?
-- bind keys somehow...
  --OR
-- treeselect gives a path
-- change binds so that it selects the neighbors of our tree, not otherwise

-- each bind press: finds current node in tree.
-- finds all of those siblings
-- indexes by that,
-- is done

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_d   ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

    -- launch gmrun
    --, ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    -- , ((modm,               xK_n     ), refresh)
    -- @todo what do the other keys do?
    , ((modm, xK_Tab), cycleRecentWS [xK_Alt_L] xK_Tab xK_grave)
   --, ((modm, xK_g), goToSelected gsconfig1)
    --, ((modm, xK_g), gridselectWorkspace gsconfig1 W.view)


    -- Move focus to the next window
    -- , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_n     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_e     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    -- <todo> make this switch the master with first non-master master is selected (i.e. this bind would otherwise do nothing) </todo>
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_n     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_e     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_i     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    --, ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm .|. shiftMask, xK_q     ), kill)

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile && xmonad --restart")

    -- screenshot binds
    , ((0, xK_Print), spawn "scrot -e 'mv $f ~/Pictures/scrots/'")
    , ((modm, xK_Print), spawn "scrot -e 'mv $f ~/Pictures/scrots/' -s")

    , ((modm, xK_f), treeselectWorkspace myTreeConf myWorkspaces1 W.greedyView)
    , ((modm .|. shiftMask, xK_f), treeselectWorkspace myTreeConf myWorkspaces1 W.shift)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    --[((m .|. modm, k), windows $ f i)
        -- | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        --, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    [((modm, k), nthNeighbor conf i) | (i, k) <- zip [0..] [xK_1 .. xK_9]]



allneighbors :: TreeZipper (a) -> [a]
allneighbors a = rootLabel <$> (reverse $ tz_before a) ++ [tz_current a] ++ tz_after a

fromJust (Just a) = a
fromJust (Nothing) = error "u suck"

instance (Show a) => Show (TreeZipper a) where
    show zip = "Zipper {" ++ (show $ tz_current zip) ++ "}"

nthNeighbor :: _ -> Integer -> X ()
nthNeighbor conf idx = do
  ws <- gets (W.workspaces . windowset)
  if all (`elem` map W.tag ws) (toWorkspaces myWorkspaces1)
      then do
        -- get the current workspace path
        me <- gets (W.tag . W.workspace . W.current . windowset)
        -- follow our path in zipper
        selected <- return $ (followPath fst (splitPath me) (fromForest $ mkPaths $ myWorkspaces1))

        -- spawn ("echo \"" ++ (show $ selected >>= return . allneighbors) ++ "\" >> ~/watch")

        -- get the neighbors of current node, then index them by the key
        let window = (fromJust $ allneighbors <$> selected) !! fromInteger (idx)

        -- select that window
        windows (W.greedyView $ snd window)

      else liftIO $ do
        -- error!
        let msg = unlines $ [ "Please add:"
                            , "    workspaces = toWorkspaces myWorkspaces"
                            , "to your XMonad config!"
                            , ""
                            , "XConfig.workspaces: "
                            ] ++ map W.tag ws
        hPutStrLn stderr msg
        --_ <- forkProcess $ executeFile "xmessage" True [msg] Nothing
        return ()

splitPath :: WorkspaceId -> [String]
splitPath i = case break (== '.') i of
    (x,   []) -> [x]
    (x, _:xs) -> x : splitPath xs

mkPaths :: Forest String -> Forest (String, WorkspaceId)
mkPaths = map (\(Node n ns) -> Node (n, n) (map (f n) ns))
  where
    f pth (Node x xs) = let pth' = pth ++ '.' : x
                         in Node (x, pth') (map (f pth') xs)


   -- ++ 

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    --[((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --    | (key, sc) <- zip [xK_w, xK_f,j xK_r] [0..]
    --    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Mirror tiled ||| Full 
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 3/4

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
--myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
--myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
--myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main =
    --xmobarProcess <- spawnPipe "xmobar"
    --xmonad (defaults xmobarProcess)
    xmonad =<< dzen defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- numlockMask deprecated in 0.9.1
        -- numlockMask        = myNumlockMask,
        -- workspaces         = myWorkspaces,
         workspaces         = toWorkspaces myWorkspaces1,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = avoidStruts $ myLayout,
        manageHook         = manageDocks <+> myManageHook
        --handleEventHook    = myEventHook,
        --logHook            = dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn h },
        --logHook            = return (),
        --startupHook        = myStartupHook
    }

-- <todo> bar </todo>
-- <todo> tree config </todo>
-- <todo> workspace back and forth, M-` vs M-Tab ? </todo>

-- tree select todo:
   -- mod + 1234 goes to current neighbors in the worskspace tree.

standard = [Node "Browser" [], Node "Emacs" [], Node "Terminal" [], Node "OtherEditor" []]
myWorkspaces1 :: Forest String
myWorkspaces1 = [ Node "Main" [Node (show n ) [] | n <- [1..5]] -- a workspace for your browser
               , Node "Glue" standard
               , Node "Xmonad" standard
               , Node "Kotlin" standard
               , Node "Mindmap" standard
               ]
