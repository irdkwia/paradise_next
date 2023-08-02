function OpenMultiPlaySynchronizeMenu_Dungeon(startFlowFunc, backFlowFunc, cancelFlowFunc, errorFlowFunc)
  OpenMultiPlaySynchronizeMenu(startFlowFunc, backFlowFunc, cancelFlowFunc, errorFlowFunc, {symbol = "dungeon", isMinigame = false})
end
function OpenMultiPlaySynchronizeMenu_Salvage(startFlowFunc, backFlowFunc, cancelFlowFunc, errorFlowFunc)
  OpenMultiPlaySynchronizeMenu(startFlowFunc, backFlowFunc, cancelFlowFunc, errorFlowFunc, {symbol = "salvage", isMinigame = true})
end
function OpenMultiPlaySynchronizeMenu_Hockey(startFlowFunc, backFlowFunc, cancelFlowFunc, errorFlowFunc)
  OpenMultiPlaySynchronizeMenu(startFlowFunc, backFlowFunc, cancelFlowFunc, errorFlowFunc, {symbol = "hockey", isMinigame = true})
end
function OpenMultiPlaySynchronizeMenu(startFlowFunc, backFlowFunc, cancelFlowFunc, errorFlowFunc, optTbl)
  local flowFuncCall
  MULTI_PLAY:ClearWaiting()
  MENU:LoadMenuTextPool("message/menu_multiplay_synchronize.bin")
  MENU:LoadMenuTextPool("message/paradise_next_common.bin")
  local OpenMultiPlayHostEntryMenu = function(startAct, cancelAct, errorAct)
    WINDOW:CloseMessage()
    local matchingMenu = MENU:CreateMultiPlayMatchingMenu()
    matchingMenu:SetHostMode()
    function matchingMenu:startAction()
      self:Close()
      startAct()
    end
    function matchingMenu:cancelAction()
      self:Close()
      cancelAct()
    end
    function matchingMenu:errorAction()
      self:Close()
      errorAct()
    end
    ShopSys:SysMsg(-1958034125)
    NestMenu_OpenAndCloseWait(matchingMenu)
    WINDOW:ForceCloseMessage()
  end
  FlowSys:Start()
  function FlowSys.Proc.errorCheck(nextFlow)
    local error = false
    if error then
      FlowSys:Next("error")
      return
    else
      FlowSys:Next(nextFlow)
      return
    end
  end
  function FlowSys.Proc.error()
    flowFuncCall = errorFlowFunc
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.dungeon()
    ShopSys:SysMsg(-1732727861)
    TASK:Sleep(TimeSec(3))
    WINDOW:ForceCloseMessage()
    if MULTI_PLAY:GameMatching_Start(MatchingType.DUNGEON) then
      FlowSys:Next("appoint")
    else
      FlowSys:Next("alreadyReservedQuest")
    end
  end
  function FlowSys.Proc.salvage()
    ShopSys:SysMsg(4)
    WINDOW:CloseMessage()
    if MULTI_PLAY:GameMatching_Start(MatchingType.SALVAGE) then
      FlowSys:Next("appoint")
    else
      FlowSys:Next("alreadyReservedMinigame")
    end
  end
  function FlowSys.Proc.hockey()
    ShopSys:SysMsg(5)
    WINDOW:CloseMessage()
    if MULTI_PLAY:GameMatching_Start(MatchingType.HOCKEY) then
      FlowSys:Next("appoint")
    else
      FlowSys:Next("alreadyReservedMinigame")
    end
  end
  function FlowSys.Proc.alreadyReservedMinigame()
    FlowSys:Next("appointNgMinigame")
  end
  function FlowSys.Proc.alreadyReservedQuest()
    FlowSys:Next("appointNgQuest")
  end
  function FlowSys.Proc.appointNgMinigame()
    ShopSys:SysMsg(6)
    flowFuncCall = backFlowFunc
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.appointNgQuest()
    ShopSys:SysMsg(2135407094)
    flowFuncCall = backFlowFunc
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.appoint()
    if optTbl.isMinigame == true then
      FlowSys:Next("appointMinigame")
      return
    else
      FlowSys:Next("appointQuest")
      return
    end
  end
  function FlowSys.Proc.appointMinigame()
    OpenMultiPlayHostEntryMenu(function()
      FlowSys:Next("startMinigame")
    end, function()
      FlowSys:Next("cancelEntry")
    end, function()
      FlowSys:Next("error")
    end)
  end
  function FlowSys.Proc.appointQuest()
    OpenMultiPlayHostEntryMenu(function()
      FlowSys:Next("startQuest")
    end, function()
      FlowSys:Next("cancelEntry")
    end, function()
      FlowSys:Next("error")
    end)
  end
  function FlowSys.Proc.cancelEntry()
    if MULTI_PLAY:GameMatching_CancelNow() then
      ShopSys:SysMsg(2120971839)
      flowFuncCall = cancelFlowFunc
      FlowSys:Next("exit")
      return
    else
      FlowSys:Next("error")
      return
    end
  end
  function FlowSys.Proc.startMinigame()
    if MULTI_PLAY:GameMatching_Finish() then
      ShopSys:SysMsg(7)
      flowFuncCall = startFlowFunc
      FlowSys:Next("exit")
      return
    else
      FlowSys:Next("error")
      return
    end
  end
  function FlowSys.Proc.startQuest()
    if MULTI_PLAY:GameMatching_Finish() then
      flowFuncCall = startFlowFunc
      FlowSys:Next("exit")
      return
    else
      FlowSys:Next("error")
      return
    end
  end
  function FlowSys.Proc.exit()
    FlowSys:Return()
  end
  FlowSys:Call(optTbl.symbol)
  FlowSys:Finish()
  if flowFuncCall then
    flowFuncCall()
  end
end
function OpenMultiPlaySynchronizeGuestMenu_Dungeon(startFlowFunc, cancelFlowFunc, errorFlowFunc)
  OpenMultiPlaySynchronizeGuestMenu(startFlowFunc, cancelFlowFunc, errorFlowFunc, {symbol = "dungeon", isMinigame = false})
end
function OpenMultiPlaySynchronizeGuestMenu(startFlowFunc, cancelFlowFunc, errorFlowFunc, optTbl)
  if optTbl == nil then
    optTbl = {}
  end
  if optTbl.symbol == nil then
    optTbl.symbol = "dungeon"
  end
  if optTbl.isMinigame == nil then
    optTbl.isMinigame = false
  end
  local flowFuncCall
  MULTI_PLAY:ClearWaiting()
  MENU:LoadMenuTextPool("message/menu_multiplay_synchronize.bin")
  MENU:LoadMenuTextPool("message/paradise_next_common.bin")
  local OpenMultiPlayGuestEntryMenu = function(startAct, cancelAct, errorAct)
    WINDOW:CloseMessage()
    local matchingMenu = MENU:CreateMultiPlayMatchingMenu()
    matchingMenu:SetGuestMode()
    function matchingMenu:startAction()
      self:Close()
      startAct()
    end
    function matchingMenu:cancelAction()
      self:Close()
      cancelAct()
    end
    function matchingMenu:errorAction()
      self:Close()
      errorAct()
    end
    ShopSys:SysMsg(-1837444890)
    NestMenu_OpenAndCloseWait(matchingMenu)
    WINDOW:ForceCloseMessage()
  end
  FlowSys:Start()
  function FlowSys.Proc.entry()
    -- ShopSys:SysMsg("FLAG.MapFlags=" .. FLAG.MapFlags:getDebugValueName())
    if optTbl.isMinigame==true and (FLAG.MapFlags==CONST.MAP_PARA_CENTER or FLAG.MapFlags==CONST.MAP_PARA_HOME_OUT or FLAG.MapFlags==CONST.MAP_PARA_HOME_IN) then
      ShopSys:SysMsg(8)
      FlowSys:Next("error")
    else
      if MULTI_PLAY:GameMatching_EntryNow() then
        FlowSys:Next("menu")
      else
        FlowSys:Next("error")
      end
    end
  end
  function FlowSys.Proc.menu()
    OpenMultiPlayGuestEntryMenu(function()
      FlowSys:Next("start")
    end, function()
      FlowSys:Next("cancel")
    end, function()
      FlowSys:Next("error")
    end)
  end
  function FlowSys.Proc.start()
    MULTI_PLAY:GameMatching_Finish()
    flowFuncCall = startFlowFunc
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.cancel()
    MULTI_PLAY:GameMatching_Finish()
    flowFuncCall = cancelFlowFunc
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.error()
    MULTI_PLAY:GameMatching_Finish()
    flowFuncCall = errorFlowFunc
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.exit()
    FlowSys:Return()
  end
  FlowSys:Call("entry")
  FlowSys:Finish()
  if flowFuncCall then
    flowFuncCall()
  end
end
function MultiPlaySynchronizeGuestMatchingStart()
  SIMPLE_STATUS:WindowClose()
  SIMPLE_STATUS:Suspend()
  if MULTI_PLAY:GameMatching_GetType() == MatchingType.NONE then
  elseif MULTI_PLAY:GameMatching_GetType() == MatchingType.DUNGEON then
    OpenQuestCounterMenu_Guest()
  elseif MULTI_PLAY:GameMatching_GetType() == MatchingType.SALVAGE then
    OpenMinigameSalvageMenu()
  elseif MULTI_PLAY:GameMatching_GetType() == MatchingType.HOCKEY then
    OpenMinigameHockeyMenu()
  end
  SIMPLE_STATUS:Resume()
end
