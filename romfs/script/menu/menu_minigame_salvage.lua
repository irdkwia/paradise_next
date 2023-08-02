function OpenMinigameSalvageMenu(shopIns, landIndex, spaceIndex, resumeNextFlow, resumeArgTbl)
  local MINIGAME_SALVAGE__WELCOME_RECORD = 1001
  local MINIGAME_SALVAGE__A_SERIES_RECORD = MINIGAME_SALVAGE__WELCOME_RECORD
  local MINIGAME_SALVAGE__MULTI_WELCOME = 1002
  local MINIGAME_SALVAGE__MULTI_WELCOME_MULTIPLAY = 1003
  local MINIGAME_SALVAGE__MULTI_WELCOME_HELP = 1004
  local MINIGAME_SALVAGE__MULTI_WELCOME_RECORD = 1005
  local MINIGAME_SALVAGE__B_SERIES = 1006
  local MINIGAME_SALVAGE__B_SERIES_MALTIPLAY = MINIGAME_SALVAGE__MULTI_WELCOME_MULTIPLAY
  local MINIGAME_SALVAGE__B_SERIES_HELP = MINIGAME_SALVAGE__MULTI_WELCOME_HELP
  local MINIGAME_SALVAGE__B_SERIES_RECORD = MINIGAME_SALVAGE__MULTI_WELCOME_RECORD
  local MINIGAME_SALVAGE__MULTI_INTO = 1007
  local MINIGAME_SALVAGE__MULTI_FINISH = 1008
  local MINIGAME_SALVAGE__SCORE_INTO = 1009
  local MINIGAME_SALVAGE__NO_SCORE = 1010
  local MINIGAME_SALVAGE__RECORD_TITLE = 1011
  local MINIGAME_SALVAGE__DISPLAY_ITEM_TITLE = 1012
  local MINIGAME_SALVAGE__DISPLAY_ITEM_HELP = 1013
  local MINIGAME_SALVAGE__DISPLAY_ITEM_INFO = 1014
  local MINIGAME_SALVAGE__DEPTH_SELECT = 1015
  local MINIGAME_SALVAGE__DEPTH_20 = 1016
  local MINIGAME_SALVAGE__DEPTH_30 = 1017
  local MINIGAME_SALVAGE__DEPTH_50 = 1018
  local MINIGAME_SALVAGE__RECORD_TABLE = 1019
  local MINIGAME_SALVAGE__ALONE = 1020

  MENU:LoadMenuTextPool("message/shop.bin", false)
  MENU:LoadMenuTextPool("message/salvage.bin")
  MENU:LoadMenuTextPool("message/menu_minigame_salvage.bin")
  MENU:LoadMenuTextPool("message/paradise_next_salvage.bin")
  local OpenScoreMenu = function(decideAct, cancelAct)
    local GetRecordContentText = function()
      MENU:SetTag_String(5, tostring(SALVAGE:GetRecordPlayCount()))
      MENU:SetTag_String(6, tostring(SALVAGE:GetRecordOnceTreasureBoxCount()))
      MENU:SetTag_String(7, tostring(SALVAGE:GetRecordTotalTreasureBoxCount()))
      MENU:SetTag_String(8, tostring(SALVAGE:GetRecordCrashChonchiiCount()))
      return MENU:ReplaceTagText(MENU:GetTextPoolText(MINIGAME_SALVAGE__RECORD_TABLE))
    end
    local menu = MENU:CreateBoardMenuWindow(ScreenType.B)
    menu:SetLayoutRect(Rectangle(16, 40, 284, 156))
    menu:SetTextOffset(0, 0)
    menu:SetFontType(FontType.TYPE_12)
    function menu:drawFunc()
    end
    function menu:cancelAction()
      self:Close()
      decideAct()
    end
    function menu:decideAction()
      self:Close()
      cancelAct()
    end
    menu:SetText(GetRecordContentText())
    CommonSys:OpenBasicMenu(MINIGAME_SALVAGE__RECORD_TITLE, nil, nil)
    NestMenu_OpenAndCloseWait(menu)
    CommonSys:CloseBasicMenu()
  end
  local DispRewardItemListMenu = function(cancelAct, expretionAct)
    ShopSys:DispBasicItemBagMenu({
      titleText = MINIGAME_SALVAGE__DISPLAY_ITEM_TITLE,
      padHelpMainText = MINIGAME_SALVAGE__DISPLAY_ITEM_HELP,
      enumItemFunc = function()
        return coroutine.wrap(function()
          for v in SALVAGE:EnumerateRewardItemIndex() do
            coroutine.yield({warehouseItemIndex = v, warehouseItemCount = 0})
          end
        end)
      end,
      itemTextFunc = function(item)
        MENU:SetTag_ItemIndex(0, item.warehouseItemIndex)
        MENU:SetTag_Value(2, SALVAGE:GetRewardItemNowCount(item.warehouseItemIndex))
        return MENU:ReplaceTagText("[S:16][item_b:0][RT][value_s_b:2:3]")
      end,
      itemLineHelpFunc = function(item)
        return ITEM:GetItemOneLineExplainTextFromItemIndex(item.warehouseItemIndex)
      end,
      itemHelpFunc = function(item)
        return ITEM:GetItemExplainTextIdFromItemIndex(item.warehouseItemIndex)
      end,
      itemEqualFunc = function(item1, item2)
        return item1.warehouseItemIndex == item2.warehouseItemIndex
      end,
      commandItems = {
        {
          text = MINIGAME_SALVAGE__DISPLAY_ITEM_INFO,
          action = function()
            expretionAct()
          end,
          isCloseShopMenu = true,
          isSingleOnly = true
        }
      },
      cancelAct = function()
        cancelAct()
      end,
      isMultiSelect = false,
      isDispBagCountWindow = false
    })
  end
  local function enterMinigameAndResumeFlow(resumeFlow, resumeArgTbl, returnLandIndex, returnSpaceIndex)
    GROUND:SetLandShopSceneContinueFunction(function()
      OpenMinigameSalvageMenu(shopIns, returnLandIndex, returnSpaceIndex, resumeFlow, resumeArgTbl)
    end)
    FLAG.MapMoveNoFade = CONST.FLAG_TRUE
    SALVAGE:Entry()
    SOUND:FadeOutBgm(TimeSec(0.5))
    SOUND:WaitBgm()
    FUNC_COMMON:SetSdmcEnable(false)
    SYSTEM:EnterMinigame(returnLandIndex, returnSpaceIndex)
  end
  local function GetDebugDisableAlreadyDayTbl()
    if SYSTEM:IsBuildFinal() == false and shopIns:IsUse() == false then
      return {
        text = 145527403,
        next = "debugDisableAlreadyDay"
      }
    end
    return nil
  end
  FlowSys:Start()
  ShopSys:Start()
  ShopSys:SetOwner("SUTAAMII", "\227\130\185\227\130\191\227\131\188\227\131\159\227\131\188")
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
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.reloadSolo()
    CAMERA:MoveToPlayer(TimeSec(0), ACCEL_TYPE.NONE, DECEL_TYPE.NONE)
    SCREEN_A:FadeIn(TimeSec(0.3), false)
    SCREEN_B:FadeIn(TimeSec(0.3), true)
    FlowSys:Next("rewardSolo")
  end
  function FlowSys.Proc.reloadMultiHost()
    CAMERA:MoveToPlayer(TimeSec(0), ACCEL_TYPE.NONE, DECEL_TYPE.NONE)
    SCREEN_A:FadeIn(TimeSec(0.3), false)
    SCREEN_B:FadeIn(TimeSec(0.3), true)
    FlowSys:Next("rewardMultiHost")
  end
  function FlowSys.Proc.reloadMultiGuest()
    CAMERA:MoveToPlayer(TimeSec(0), ACCEL_TYPE.NONE, DECEL_TYPE.NONE)
    SCREEN_A:FadeIn(TimeSec(0.3), false)
    SCREEN_B:FadeIn(TimeSec(0.3), true)
    FlowSys:Next("rewardMultiGuest")
  end
  function FlowSys.Proc.reloadResume()
    MENU:LoadMenuTextPool("message/shop.bin", false)
    MENU:LoadMenuTextPool("message/salvage.bin")
    MENU:LoadMenuTextPool("message/menu_minigame_salvage.bin")
    MENU:LoadMenuTextPool("message/paradise_next_salvage.bin")
    if FlowSys.Stat.resumeNextFlow then
      local flow = FlowSys.Stat.resumeNextFlow
      FlowSys.Stat.resumeNextFlow = nil
      FlowSys:Next(flow)
    end
  end
  function FlowSys.Proc.what()
    if MULTI_PLAY:IsLogined() then
      local isHost = true
      if MULTI_PLAY:GameMatching_GetType() ~= MatchingType.NONE and MULTI_PLAY:GameMatching_GetState() == MatchingState.SUMMON_UP then
        isHost = false
      end
      if isHost then
        FlowSys:Next("multiWelcome")
      else
        FlowSys:Next("multiWelcomeGuest")
      end
      return
    else
      FlowSys:Next("welcome")
      return
    end
  end
  function FlowSys.Proc.welcome()
    CommonSys:OpenBasicMenu(nil, -1733859855, nil)
    ShopSys:TalkAskFlowNoClose(1006155159, nil, nil, {next = "exit"}, {text = 950977687, next = "soloPlay"}, {text = MINIGAME_SALVAGE__WELCOME_RECORD, next = "soloRecord"}, {text = -1032870416, next = "soloHelp"}, GetDebugDisableAlreadyDayTbl())
    CommonSys:CloseBasicMenu()
    return
  end
  function FlowSys.Proc.seriesA()
    CommonSys:OpenBasicMenu(nil, -1733859855, nil)
    ShopSys:TalkAskFlowNoClose(1540008421, nil, nil, {next = "exit"}, {text = 1121840915, next = "soloPlay"}, {text = MINIGAME_SALVAGE__A_SERIES_RECORD, next = "soloRecord"}, {text = 913922517, next = "soloHelp"}, GetDebugDisableAlreadyDayTbl())
    CommonSys:CloseBasicMenu()
    return
  end
  function FlowSys.Proc.debugDisableAlreadyDay()
    shopIns:ResetUseCount()
    FlowSys:Next("seriesA")
  end
  function FlowSys.Proc.multiWelcome()
    ShopSys:TalkAskFlowNoClose(MINIGAME_SALVAGE__MULTI_WELCOME, nil, nil, {next = "exit"}, {text = MINIGAME_SALVAGE__MULTI_WELCOME_MULTIPLAY, next = "multiPlay"}, {text = MINIGAME_SALVAGE__MULTI_WELCOME_RECORD, next = "multiRecord"}, {text = MINIGAME_SALVAGE__MULTI_WELCOME_HELP, next = "multiHelp"})
    return
  end
  function FlowSys.Proc.seriesB()
    ShopSys:TalkAskFlowNoClose(MINIGAME_SALVAGE__B_SERIES, nil, nil, {next = "exit"}, {text = MINIGAME_SALVAGE__B_SERIES_MALTIPLAY, next = "multiPlay"}, {text = MINIGAME_SALVAGE__B_SERIES_RECORD, next = "multiRecord"}, {text = MINIGAME_SALVAGE__B_SERIES_HELP, next = "multiHelp"})
    return
  end
  function FlowSys.Proc.soloPlay()
    if shopIns:IsUse() == false then
      ShopSys:Talk(928267111)
      FlowSys:Next("finish")
    else
      ShopSys:Talk(-1349243858)
      WINDOW:CloseMessage()
      SYSTEM:ExecuteTutorialHint(SymHint("SHOP_SALVAGE_FIRST"))
      FlowSys:Next("soloLevelSelect")
    end
  end
  function FlowSys.Proc.soloRecord()
    FlowSys:Next("record", "seriesA")
  end
  function FlowSys.Proc.soloHelp()
    FlowSys:Next("help", "seriesA")
  end
  function FlowSys.Proc.soloLevelSelect()
    
    ShopSys:TalkAskFlowNoClose(MINIGAME_SALVAGE__DEPTH_SELECT, nil, nil, {next = "seriesA"}, {
      text = MINIGAME_SALVAGE__DEPTH_20,
      next = "inGame_lv1"
    }, {
      text = MINIGAME_SALVAGE__DEPTH_30,
      next = "inGame_lv2"
    }, {
      text = MINIGAME_SALVAGE__DEPTH_50,
      default = true,
      next = "inGame_lv3"
    })
    return
  end
  function FlowSys.Proc.inGame_lv1()
    FlowSys.Stat.level = 0
    FlowSys:Next("inGame")
  end
  function FlowSys.Proc.inGame_lv2()
    FlowSys.Stat.level = 1
    FlowSys:Next("inGame")
  end
  function FlowSys.Proc.inGame_lv3()
    FlowSys.Stat.level = 2
    FlowSys:Next("inGame")
  end
  function FlowSys.Proc.inGame()
    WINDOW:CloseMessage()
    SCREEN_A:FadeOut(TimeSec(0.3), false)
    SCREEN_B:FadeOut(TimeSec(0.3), true)
    shopIns:DecUseCount()
    SALVAGE:EnableMultiPlay(false)
    SALVAGE:SetLevel(FlowSys.Stat.level)
    enterMinigameAndResumeFlow("reloadSolo", nil, landIndex, spaceIndex)
  end
  function FlowSys.Proc.multiPlay()
    if MULTI_PLAY:GetEntryCount() >= 2 then
      ShopSys:Talk(MINIGAME_SALVAGE__MULTI_INTO)
      FlowSys:Next("multiPlayEntry")
      return
    else
      ShopSys:Talk(MINIGAME_SALVAGE__ALONE)
      FlowSys:Next("seriesB")
      return
    end
  end
  function FlowSys.Proc.multiRecord()
    FlowSys:Next("record", "seriesB")
  end
  function FlowSys.Proc.multiHelp()
    FlowSys:Next("help", "seriesB")
  end
  function FlowSys.Proc.multiPlayEntry()
    local resumeFlowSysData = FlowSys:Suspend()
    local resumeShopSysData = ShopSys:Suspend()
    local nextFlow = "multiLevelSelect"
    OpenMultiPlaySynchronizeMenu_Salvage(function()
      nextFlow = "multiLevelSelect"
    end, function()
      nextFlow = "seriesB"
    end, function()
      nextFlow = "seriesB"
    end, function()
      nextFlow = "error"
    end)
    FlowSys:Resume(resumeFlowSysData)
    ShopSys:Resume(resumeShopSysData)
    FlowSys:Next(nextFlow)
  end
  function FlowSys.Proc.multiLevelSelect()
    ShopSys:TalkAskFlowNoClose(MINIGAME_SALVAGE__DEPTH_SELECT, nil, nil, {}, {
      text = MINIGAME_SALVAGE__DEPTH_20,
      next = "inGameMulti_lv1"
    }, {
      text = MINIGAME_SALVAGE__DEPTH_30,
      next = "inGameMulti_lv2"
    }, {
      text = MINIGAME_SALVAGE__DEPTH_50,
      default = true,
      next = "inGameMulti_lv3"
    })
    return
  end
  function FlowSys.Proc.inGameMulti_lv1()
    FlowSys.Stat.level = 0
    FlowSys:Next("inGameMulti")
  end
  function FlowSys.Proc.inGameMulti_lv2()
    FlowSys.Stat.level = 1
    FlowSys:Next("inGameMulti")
  end
  function FlowSys.Proc.inGameMulti_lv3()
    FlowSys.Stat.level = 2
    FlowSys:Next("inGameMulti")
  end
  function FlowSys.Proc.inGameMulti()
    WINDOW:CloseMessage()
    SCREEN_A:FadeOut(TimeSec(0.3), false)
    SCREEN_B:FadeOut(TimeSec(0.3), true)
    SALVAGE:EnableMultiPlay(true)
    SALVAGE:SetLevel(FlowSys.Stat.level)
    MULTI_PLAY:ReleaseParadiseShopLock(landIndex, spaceIndex)
    enterMinigameAndResumeFlow("reloadMultiHost", nil, landIndex, spaceIndex)
  end
  function FlowSys.Proc.multiWelcomeGuest()
    local resumeFlowSysData = FlowSys:Suspend()
    local resumeShopSysData = ShopSys:Suspend()
    local nextFlow = "exit"
    OpenMultiPlaySynchronizeGuestMenu(function()
      nextFlow = "inGameMultiGuest"
    end, function()
      nextFlow = "exit"
    end, function()
      nextFlow = "error"
    end,
    {symbol = "salvage", isMinigame = true})
    FlowSys:Resume(resumeFlowSysData)
    ShopSys:Resume(resumeShopSysData)
    FlowSys:Next(nextFlow)
  end
  function FlowSys.Proc.inGameMultiGuest()
    --local landIndex = PARADISE_LAND_INDEX.INDEX_00
    local landIndex = GROUND:GetNowLandIndex()
    local spaceIndex = PARADISE_SPACE_INDEX.INDEX_00
    SCREEN_A:FadeOut(TimeSec(0.3), false)
    SCREEN_B:FadeOut(TimeSec(0.3), true)
    SALVAGE:EnableMultiPlay(true)
    enterMinigameAndResumeFlow("reloadMultiGuest", resumeTbl, landIndex, spaceIndex)
  end
  function FlowSys.Proc.rewardSolo()
    FlowSys.Stat.multiPlay = false
    FlowSys:Next("reward")
  end
  function FlowSys.Proc.rewardMultiHost()
    FlowSys.Stat.multiPlay = true
    ShopSys:Talk(MINIGAME_SALVAGE__MULTI_FINISH)
    FlowSys:Next("reward")
  end
  function FlowSys.Proc.rewardMultiGuest()
    FlowSys.Stat.multiPlay = true
    ShopSys:Talk(MINIGAME_SALVAGE__MULTI_FINISH)
    FlowSys:Next("rewardGuest")
  end
  function FlowSys.Proc.reward()
    if SALVAGE:GetRewardItemCount() ~= 0 then
      FlowSys:Next("excuteReward")
      return
    else
      FlowSys:Next("notReward")
      return
    end
  end
  function FlowSys.Proc.rewardGuest()
    if SALVAGE:GetRewardItemCount() ~= 0 then
      WINDOW:KeyWait()
      SOUND:PlayMe(SymSnd("ME_EVT_DAN_01"), Volume(256))
      FlowSys:Next("dispRewardGuest")
      return
    else
      FlowSys:Next("notRewardGuest")
      return
    end
  end
  function FlowSys.Proc.dispReward()
    DispRewardItemListMenu(function()
      FlowSys:Next("excuteReward")
    end, function()
      FlowSys:Next("itemGuide", "dispReward")
    end)
  end
  function FlowSys.Proc.dispRewardGuest()
    DispRewardItemListMenu(function()
      FlowSys:Next("excuteRewardGuset")
    end, function()
      FlowSys:Next("itemGuide", "dispRewardGuest")
    end)
  end
  function FlowSys.Proc.excuteReward()
    ShopSys:Talk(-1466949572)
    WINDOW:CloseMessage()
    for i = 0, SALVAGE:GetRewardItemCount() - 1 do
      local itemIndex = SALVAGE:GetRewardItemIndex(i)
      local boxType = SALVAGE:GetRewardItemBoxType(i)
      local count = SALVAGE:GetRewardItemNowCount(itemIndex)
      OverFlow:AddOverflowCheckItem(itemIndex, count, false)
      SOUND:PlayMe(SymSnd("ME_REWARD"), Volume(256))
      MENU:SetTag_ItemIndex(0, itemIndex)
      MENU:SetTag_String(5, MENU:ReplaceTagText("[item_b:0]"))
      if boxType == 0 then
        ShopSys:SysMsg(790130128)
      elseif boxType == 1 then
        ShopSys:SysMsg(2009134054)
      elseif boxType == 2 then
        ShopSys:SysMsg(1695591298)
      end
      SOUND:WaitMe()
      WINDOW:CloseMessage()
      OverFlow:OpenOrderOverflowMenu(true)
    end
    ShopSys:Talk(1237870149)
    FlowSys:Next("finish")
  end
  function FlowSys.Proc.excuteRewardGuset()
    WINDOW:ForceCloseMessage()
    for i = 0, SALVAGE:GetRewardItemCount() - 1 do
      local itemIndex = SALVAGE:GetRewardItemIndex(i)
      local count = SALVAGE:GetRewardItemNowCount(itemIndex)
      OverFlow:AddOverflowCheckItem(itemIndex, count, false)
    end
    OverFlow:OpenOrderOverflowMenu(true)
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.notReward()
    ShopSys:Talk(927574115)
    FlowSys:Next("finish")
  end
  function FlowSys.Proc.notRewardGuest()
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.itemGuide(nextFlow)
    DispItemGuide()
    FlowSys:Next(nextFlow)
  end
  function FlowSys.Proc.record(nextFlow)
    if SALVAGE:GetRecordPlayCount() ~= 0 then
      ShopSys:Talk(MINIGAME_SALVAGE__SCORE_INTO)
      OpenScoreMenu(function()
        FlowSys:Next(nextFlow)
      end, function()
        FlowSys:Next(nextFlow)
      end)
      WINDOW:ForceCloseMessage()
    else
      ShopSys:Talk(MINIGAME_SALVAGE__NO_SCORE)
    end
    FlowSys:Next(nextFlow)
  end
  function FlowSys.Proc.help(nextFlow)
    ShopSys:Talk(-1571152531)
    WINDOW:KeyWait()
    FlowSys:Next(nextFlow)
  end
  function FlowSys.Proc.exit()
    ShopSys:Talk(-710595377)
    FlowSys:Next("finish")
  end
  function FlowSys.Proc.finish()
    WINDOW:CloseMessage()
    FlowSys:Return()
  end
  if resumeNextFlow then
    FlowSys.Stat.resumeNextFlow = resumeNextFlow
    FlowSys.Stat.resumeArgTbl = resumeArgTbl
    FlowSys:Call("reloadResume")
  else
    FlowSys:Call("what")
  end
  FlowSys:Finish()
  ShopSys:Finish()
end
function OpenMinigameSalvageDebugMenu()
  MENU:LoadMenuTextPool("message/menu_minigame_salvage.bin", false)
  MENU:LoadMenuTextPool("message/debug.bin")
  local OpenTopMenu = function(cancelAct, fallAct, transAct, resetAct)
    local menu = MENU:CreatePageMenu()
    menu:SetCaption(1470441672)
    menu:SetLayoutRectAndLines(16, 16, 0, 0)
    menu:AddItem(-760382482, nil, {
      decideAction = function(self)
        fallAct()
        self:Close()
      end
    })
    menu:AddItem(278725723, nil, {
      decideAction = function(self)
        transAct()
        self:Close()
      end
    })
    if SALVAGE:IsOtherFreeOperation() == true then
      menu:AddItem(-330988534, nil, {
        decideAction = function(self)
          SALVAGE:SetOtherFreeOperation(false)
          resetAct()
          self:Close()
        end
      })
    else
      menu:AddItem(1948752482, nil, {
        decideAction = function(self)
          SALVAGE:SetOtherFreeOperation(true)
          resetAct()
          self:Close()
        end
      })
    end
    function menu:cancelAction()
      cancelAct()
      self:Close()
    end
    NestMenu_OpenAndCloseWait(menu)
  end
  local OpenFallMenu = function(cancelAct, resetAct)
    local fallMaxSeconds = SALVAGE:GetFallMaxSeconds()
    local fallDownSeconds = SALVAGE:GetFallDownSeconds()
    local fallWeight = SALVAGE:GetFallWeight()
    local fallWeightRatio = SALVAGE:GetFallWeightRatio()
    local menu = MENU:CreateParameterMenu()
    local downSecondsTbl = {}
    local maxSecondsTbl = {}
    local weightTbl = {}
    local weightRatioTbl = {}
    local resetTbl = {}
    local function SetValueAndCaption()
      local mps = 1 / fallDownSeconds / (1 + fallWeight * fallWeightRatio)
      mps = math.ceil(mps * 100) / 100
      MENU:SetTag_String(5, mps .. "")
      menu:SetCaption(MENU:ReplaceTagText(2087939400))
    end
    SetValueAndCaption()
    menu:SetLayoutRectAndLines(16, 16, 288, 0)
    menu:AddItemF(-1445699838, ValueParamEx(0, 100, fallMaxSeconds, 0.01, 0.1, 1), nil, maxSecondsTbl)
    menu:AddItemF(1358268728, ValueParamEx(0.01, 100, fallDownSeconds, 0.01, 0.1, 1), nil, downSecondsTbl)
    menu:AddItemF(483287227, ValueParamEx(0, 100, fallWeight, 0.01, 0.1, 1), nil, weightTbl)
    menu:AddItemF(304381229, ValueParamEx(0, 100, fallWeightRatio, 0.01, 0.1, 1), nil, weightRatioTbl)
    menu:AddItem(189873783, nil, resetTbl)
    function menu:cancelAction()
      cancelAct()
      self:Close()
    end
    function menu:decideAction()
      SALVAGE:SetFallMaxSeconds(fallMaxSeconds)
      SALVAGE:SetFallDownSeconds(fallDownSeconds)
      SALVAGE:SetFallWeight(fallWeight)
      SALVAGE:SetFallWeightRatio(fallWeightRatio)
      resetAct()
      self:Close()
    end
    function maxSecondsTbl:currentItemValueChange()
      fallMaxSeconds = self.curItem.value
    end
    function downSecondsTbl:currentItemValueChange()
      fallDownSeconds = self.curItem.value
    end
    function weightTbl:currentItemValueChange()
      fallWeight = self.curItem.value
    end
    function weightRatioTbl:currentItemValueChange()
      fallWeightRatio = self.curItem.value
    end
    function resetTbl:decideAction()
      SALVAGE:ResetFall()
      resetAct()
      self:Close()
    end
    NestMenu_OpenAndCloseWait(menu)
  end
  local OpenTransMenu = function(cancelAct, resetAct)
    local transMaxSpeedSeconds = SALVAGE:GetTransMaxSpeedSeconds()
    local transMeterPerSeconds = SALVAGE:GetTransMeterPerSeconds()
    local transSlopeDeg = SALVAGE:GetTransSlopeDeg()
    local menu = MENU:CreateParameterMenu()
    local maxSpeedSecondsTbl = {}
    local meterPerSecondsTbl = {}
    local slopeDegTbl = {}
    local resetTbl = {}
    local function SetValueAndCaption()
      local mps = transMeterPerSeconds
      mps = math.ceil(mps * 100) / 100
      MENU:SetTag_String(5, mps .. "")
      local deg = transSlopeDeg
      deg = math.ceil(deg * 100) / 100
      MENU:SetTag_String(6, deg .. "")
      menu:SetCaption(MENU:ReplaceTagText(796279867))
    end
    SetValueAndCaption()
    menu:SetLayoutRectAndLines(16, 16, 288, 0)
    menu:AddItemF(-28274282, ValueParamEx(0, 100, transMaxSpeedSeconds, 0.01, 0.1, 1), nil, maxSpeedSecondsTbl)
    menu:AddItemF(-313245000, ValueParamEx(0.01, 100, transMeterPerSeconds, 0.01, 0.1, 1), nil, meterPerSecondsTbl)
    menu:AddItemF(1668171811, ValueParamEx(1, 90, transSlopeDeg, 0.01, 0.1, 1), nil, slopeDegTbl)
    menu:AddItem(1946427200, nil, resetTbl)
    function menu:cancelAction()
      cancelAct()
      self:Close()
    end
    function menu:decideAction()
      SALVAGE:SetTransMaxSpeedSeconds(transMaxSpeedSeconds)
      SALVAGE:SetTransMeterPerSeconds(transMeterPerSeconds)
      SALVAGE:SetTransSlopeDeg(transSlopeDeg)
      resetAct()
      self:Close()
    end
    function maxSpeedSecondsTbl:currentItemValueChange()
      transMaxSpeedSeconds = self.curItem.value
    end
    function meterPerSecondsTbl:currentItemValueChange()
      transMeterPerSeconds = self.curItem.value
    end
    function slopeDegTbl:currentItemValueChange()
      transSlopeDeg = self.curItem.value
    end
    function resetTbl:decideAction()
      SALVAGE:ResetTrans()
      resetAct()
      self:Close()
    end
    NestMenu_OpenAndCloseWait(menu)
  end
  FlowSys:Start()
  ShopSys:Start()
  function FlowSys.Proc.topMenu()
    OpenTopMenu(function()
      FlowSys:Next("finish")
    end, function()
      FlowSys:Next("fallMenu")
    end, function()
      FlowSys:Next("transMenu")
    end, function()
      FlowSys:Next("topMenu")
    end)
  end
  function FlowSys.Proc.fallMenu()
    OpenFallMenu(function()
      FlowSys:Next("topMenu")
    end, function()
      FlowSys:Next("fallMenu")
    end)
  end
  function FlowSys.Proc.transMenu()
    OpenTransMenu(function()
      FlowSys:Next("topMenu")
    end, function()
      FlowSys:Next("transMenu")
    end)
  end
  function FlowSys.Proc.finish()
    FlowSys:Return()
  end
  FlowSys:Call("topMenu")
  FlowSys:Finish()
  ShopSys:Finish()
end
