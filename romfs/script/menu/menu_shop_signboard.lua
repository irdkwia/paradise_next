dofile("script/paradise_next/shop_strings.lua")
function OpenParadiseLand_SignboardMenu(spaceIndex, resumeNextFlow, resumeArgTbl)
  local TatefudaSys = {}
  local EventPlay = {}
  TatefudaSys.landIndex = GROUND:GetNowLandIndex()
  TatefudaSys.spaceIndex = spaceIndex
  if FLAG.ScenarioFlag == CONST.S1_UCHUURITSUNOOKA_END then
    FLAG.DotekkotsuCounter = CONST.CNT_2
  end
  function TatefudaSys:GetNowLandShopPairs()
    return self.landIndex, self.spaceIndex
  end
  function TatefudaSys:GetNowLandShopId()
    return GROUND:GetLandShopLabel(self:GetNowLandShopPairs())
  end
  function TatefudaSys:GetNowLandShopLevel()
    return GROUND:GetLandShopLevel(self:GetNowLandShopPairs())
  end
  function TatefudaSys:GetNowLandShopName()
    local landTypeNameTbl = {
      reclamation_weed = 1989378931,
      reclamation_wood = -1952329977,
      reclamation_water = -634815408,
      reclamation_rock = 567129807
    }
    if landTypeNameTbl[self:GetNowLandShopId()] then
      return landTypeNameTbl[self:GetNowLandShopId()]
    else
      return GetLandShopNameTextIdForTitle(self:GetNowLandShopId())
    end
  end
  function TatefudaSys:GetNowLandShopOwnerSymbol()
    return GROUND:GetLandShopInstance(self:GetNowLandShopPairs()):GetOwnerSymbol()
  end
  function TatefudaSys:GetNowLandShopOwnerName()
    return GROUND:GetLandShopInstance(self:GetNowLandShopPairs()):GetOwnerName()
  end
  function TatefudaSys:InitNowJukeboxAllBreak()
    TatefudaSys.flagJukeboxAllBrake = false
    if GROUND:IsLandSpaceJukebox(TatefudaSys.landIndex, TatefudaSys.spaceIndex) and GROUND:GetJukeboxAllSearch() == 1 then
      TatefudaSys.flagJukeboxAllBrake = true
    end
  end
  function TatefudaSys:IsNowJukeboxAllBreak()
    return TatefudaSys.flagJukeboxAllBrake
  end
  local addNewMark = function(textId, isAdd)
    if isAdd then
      return "[M:NEW]" .. MENU:GetTextPoolText(textId)
    else
      return MENU:GetTextPoolText(textId)
    end
  end
  local isLandShopOkFuncTbl = {
    [PARADISE_MENU_OPEN_TYPE.SHOP_GRADE_UP] = function()
      return GROUND:IsLandShopExtendOk(TatefudaSys:GetNowLandShopPairs())
    end,
    [PARADISE_MENU_OPEN_TYPE.SHOP_COLOR_CHANGE] = function()
      return GROUND:IsLandShopChangeColorOk(TatefudaSys:GetNowLandShopPairs())
    end,
    [PARADISE_MENU_OPEN_TYPE.SHOP_BROKEN] = function()
      return true
    end,
    [PARADISE_MENU_OPEN_TYPE.SHOP_OWNER_CHANGE] = function()
      return GROUND:IsLandShopChangeStaffOk(TatefudaSys:GetNowLandShopPairs())
    end
  }
  local isOpenMenu = function(openType)
    local isOpen = GROUND:GetOpenLimitState_Menu(openType) ~= PARADISE_OPEN_LIMIT_STATE.CLOSE
    return isOpen
  end
  local function isEnableMenu(openType)
    return isOpenMenu(openType) and isLandShopOkFuncTbl[openType](TatefudaSys:GetNowLandShopPairs())
  end
  local isNewMenu = function(openType)
    return GROUND:GetOpenLimitState_Menu(openType) == PARADISE_OPEN_LIMIT_STATE.OPEN_NEW
  end
  local setOpenedMenu = function(openType)
    GROUND:SetOpenLimitState_Menu(openType, PARADISE_OPEN_LIMIT_STATE.OPEN)
  end
  local function isExtendOk()
    return isEnableMenu(PARADISE_MENU_OPEN_TYPE.SHOP_GRADE_UP)
  end
  local function isDestructionOk()
    return isEnableMenu(PARADISE_MENU_OPEN_TYPE.SHOP_BROKEN)
  end
  local function isPokemonChangeOk()
    return isEnableMenu(PARADISE_MENU_OPEN_TYPE.SHOP_OWNER_CHANGE)
  end
  local function isColorChangeOk()
    return isEnableMenu(PARADISE_MENU_OPEN_TYPE.SHOP_COLOR_CHANGE)
  end
  local function isExtendNew()
    return isNewMenu(PARADISE_MENU_OPEN_TYPE.SHOP_GRADE_UP)
  end
  local function isDestructionNew()
    return isNewMenu(PARADISE_MENU_OPEN_TYPE.SHOP_BROKEN)
  end
  local function isPokemonChangeNew()
    return isNewMenu(PARADISE_MENU_OPEN_TYPE.SHOP_OWNER_CHANGE)
  end
  local function isColorChangeNew()
    return isNewMenu(PARADISE_MENU_OPEN_TYPE.SHOP_COLOR_CHANGE)
  end
  local function setExtendOpened()
    return setOpenedMenu(PARADISE_MENU_OPEN_TYPE.SHOP_GRADE_UP)
  end
  local function setDestructionOpened()
    return setOpenedMenu(PARADISE_MENU_OPEN_TYPE.SHOP_BROKEN)
  end
  local function setPokemonChangeOpened()
    return setOpenedMenu(PARADISE_MENU_OPEN_TYPE.SHOP_OWNER_CHANGE)
  end
  local function setColorChangeOpened()
    return setOpenedMenu(PARADISE_MENU_OPEN_TYPE.SHOP_COLOR_CHANGE)
  end
  local function reloadEntryAndResumeFlow(resumeFlow, resumeArgTbl)
    GROUND:SetLandShopSceneContinueFunction(function()
      OpenParadiseLand_SignboardMenu(spaceIndex, resumeFlow, resumeArgTbl)
    end)
    CHARA:DynamicRemove("DOTEKKOTSU")
    CHARA:DynamicRemove("DOKKORAA_1")
    CHARA:DynamicRemove("DOKKORAA_2")
    FLAG.MapMoveNoFade = CONST.FLAG_TRUE
    SYSTEM:ReloadLandEntry()
  end
  MENU:LoadMenuTextPool("message/shop.bin")
  MENU:LoadMenuTextPool("message/paradise_next_common.bin")
  FlowSys:Start()
  ShopSys:Start({withOutLowerScreen = true})
  ShopSys:SetOwner("DOTEKKOTSU", "\227\131\137\227\131\134\227\131\131\227\130\179\227\131\132")
  TatefudaSys:InitNowJukeboxAllBreak()
  function FlowSys.Proc.tatehudaMenuStart()
    if GROUND:CheckOpenFriendGate() then
      ShopSys:SysMsg(1749049412)
      WINDOW:CloseMessage()
      FlowSys:Next("ExitShopNoFade")
      return
    end
    if GROUND:IsSelectShopClose(TatefudaSys:GetNowLandShopPairs()) == true then
      ShopSys:SetShopTag("\227\131\157\227\130\177\227\131\162\227\131\179\229\144\141", TatefudaSys:GetNowLandShopOwnerName())
      ShopSys:SysMsg(-529060259)
      WINDOW:CloseMessage()
    end
    CommonSys:OpenBasicMenu(nil, -707245197, nil)
    if MULTI_PLAY:IsLogined() then
      ShopSys:SysMsg(3)
      WINDOW:CloseMessage()
      FlowSys:Next("ExitShopNoFade")
      return
    end
    ShopSys:SysMsgAskFlow(1260108552, {cursorSaveName = "start"}, {
      next = "ExitShopNoFade"
    }, {
      text = -71934798,
      next = "tatehudaMenuTopFirst"
    }, {text = -616931409, next = "Help"})
    CommonSys:CloseBasicMenu()
  end
  local EventPlay = {}
  function FlowSys.Proc.tatehudaMenuTopResume()
    LOWER_SCREEN:SetVisible(false)
    SCREEN_B:LoadWallpaper("WALLPAPER_SUB_NOTICE01")
    SCREEN_B:SetVisibleWallpaper(true)
    CHARA:DynamicLoad("DOTEKKOTSU", "DOTEKKOTSU")
    CHARA:DynamicLoad("DOKKORAA_1", "DOKKORAA_1")
    CHARA:DynamicLoad("DOKKORAA_2", "DOKKORAA_2")
    CH("DOTEKKOTSU"):SetPosition(SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex)))
    CH("DOKKORAA_1"):SetPosition(SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex), PosOffs(-0.55, -0.75)))
    CH("DOKKORAA_2"):SetPosition(SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex), PosOffs(0.55, -0.75)))
    if FlowSys.Stat.resumeNextFlow then
      local flow = FlowSys.Stat.resumeNextFlow
      FlowSys.Stat.resumeNextFlow = nil
      FlowSys:Next(flow)
    end
  end
  function FlowSys.Proc.tatehudaMenuTopFirst()
    EventPlay.eventSignboardDottekotsuCome()
    FlowSys:Next("tatehudaMenuTop")
  end
  function FlowSys.Proc.tatehudaMenuTop()
    if GROUND:IsSelectShopClose(TatefudaSys:GetNowLandShopPairs()) == true then
      FlowSys:Next("firstAccessCloseAsk")
      return
    end
    if GROUND:IsLandShopExist(TatefudaSys:GetNowLandShopPairs()) == false then
      FlowSys:Next("firstAccessAsk")
    else
      FlowSys:Next("secondAccessAsk")
    end
  end
  function FlowSys.Proc.firstAccessCloseAsk()
    if GROUND:IsSelectShopClose(TatefudaSys:GetNowLandShopPairs()) == false then
      FlowSys:Next("tatehudaMenuTop")
      return
    end
    CommonSys:OpenBasicMenu(nil, 1331611147, nil)
    ShopSys:TalkAskFlowNoClose(-963515799, FACE_TYPE.NORMAL, {cursorSaveName = "top1st"}, {next = "ExitShop"}, {
      text = 458470186,
      next = "TopDestruction"
    }, {text = 233752981, next = "CloseHelp"})
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.CloseHelp()
    ShopSys:SetShopTag("\227\131\157\227\130\177\227\131\162\227\131\179\229\144\141", TatefudaSys:GetNowLandShopOwnerName())
    ShopSys:SysMsg(-529060259)
    FlowSys:Next("firstAccessCloseAsk")
  end
  function FlowSys.Proc.firstAccessAsk()
    ShopSys:TalkAskFlowNoClose(643131471, FACE_TYPE.NORMAL, {cursorSaveName = "top1st"}, {next = "ExitShop"}, {text = -653920556, next = "TopBuild"}, {text = -680581454, next = "ExitShop"})
  end
  function FlowSys.Proc.secondAccessAsk()
    if isExtendOk() == false and isDestructionOk() == false and isPokemonChangeOk() == false and isColorChangeOk() == false then
      if TatefudaSys:GetNowLandShopId() == "shop_dig" then
        ShopSys:Talk(-973100246, FACE_TYPE.NORMAL)
        FlowSys:Next("ExitShop")
        return
      end
      if isOpenMenu(PARADISE_MENU_OPEN_TYPE.SHOP_GRADE_UP) then
        ShopSys:Talk(508253706, FACE_TYPE.NORMAL)
        FlowSys:Next("ExitShop")
        return
      end
      ShopSys:Talk(801359039, FACE_TYPE.NORMAL)
      FlowSys:Next("ExitShop")
      return
    end
    CommonSys:OpenBasicMenu(nil, -707245197, nil)
    ShopSys:TalkAskFlowNoClose(1729127108, FACE_TYPE.NORMAL, {cursorSaveName = "top2nd"}, {next = "ExitShop"}, {
      text = addNewMark(54416710, isExtendNew()),
      next = "TopExtend",
      enableFunc = isExtendOk
    }, {
      text = addNewMark(-77918128, isDestructionNew()),
      next = "TopDestruction",
      enableFunc = isDestructionOk
    }, {
      text = addNewMark(-1086689670, isPokemonChangeNew()),
      next = "TopPokemonChange",
      enableFunc = isPokemonChangeOk
    }, {
      text = addNewMark(149491510, isColorChangeNew()),
      next = "TopColorChange",
      enableFunc = isColorChangeOk
    })
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.TopBuild()
    ShopSys:Talk(115725363, FACE_TYPE.NORMAL)
    WINDOW:CloseMessage()
    local selectLandShopId
    DispBuildSelectMenu(2043608976, 1892664260, function(landShopId)
      selectLandShopId = landShopId
    end, function()
      FlowSys:Next("tatehudaMenuTop")
    end, true)
    if ShopSys:NeedReturnFlow() then
      return
    end
    if GROUND:IsLandShopDevelopMaterialOk(selectLandShopId, 0) == false then
      ShopSys:Talk(-159930698, FACE_TYPE.NORMAL)
      WINDOW:KeyWait()
      FlowSys:Next("TopBuild")
      return
    end
    if GROUND:IsLandShopDevelopMoneyOk(selectLandShopId, 0) == false then
      ShopSys:Talk(-269989041, FACE_TYPE.NORMAL)
      WINDOW:KeyWait()
      FlowSys:Next("TopBuild")
      return
    end
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\230\150\189\232\168\173", GetLandShopNameTextIdForTitle(selectLandShopId))
    ShopSys:TalkAskFlow(-1063194182, FACE_TYPE.NORMAL, nil, {next = "TopBuild"}, {
      text = -1966095469,
      next = "",
      default = true
    }, {text = 1391567358, next = "TopBuild"})
    if ShopSys:NeedReturnFlow() then
      return
    end
    local taskbuild_cancelflag = 0
    EventPlay.eventSignboardBuildBefore_Fast(selectLandShopId)
    local function taskEventSignboardBuild()
      function TaskL.Start()
        EventPlay.eventSignboardBuildBefore(selectLandShopId)
      end
    end
    TASK:Regist(Group("taskEventGrp"), taskEventSignboardBuild)
    while TASK:IsEndTasks(Group("taskEventGrp")) == false do
      if PAD:Edge("B") then
        taskbuild_cancelflag = 1
        SOUND:FadeOutSe(SymSnd("SE_SHOP_BUILD"), TimeSec(1))
        SOUND:PlaySe(SymSnd("SE_EVT_WHITEOUT"))
        SCREEN_A:WhiteOutAll(TimeSec(1), true)
        TASK:ExitNotifyTasks()
        break
      end
      TASK:Sleep(TimeSec(0))
    end
    TASK:WaitTask()
    if taskbuild_cancelflag == 0 then
      SOUND:PlaySe(SymSnd("SE_EVT_WHITEOUT"))
      SCREEN_A:WhiteOutAll(TimeSec(1), true)
      EventPlay.eventSignboardBuildBefore_End(selectLandShopId)
    else
      EventPlay.eventSignboardBuildBefore_End(selectLandShopId)
    end
    GROUND:PaymentDevelopLandShop(selectLandShopId, 0)
    GROUND:BuildLandShop(TatefudaSys.landIndex, TatefudaSys.spaceIndex, selectLandShopId)
    GROUND:SetOpenLimitState_LandShopLabel(selectLandShopId, PARADISE_OPEN_LIMIT_STATE.OPEN)
    reloadEntryAndResumeFlow("build_after")
  end
  function FlowSys.Proc.build_after()
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\230\150\189\232\168\173", TatefudaSys:GetNowLandShopName())
    EventPlay.eventSignboardBuildAfter()
    if GROUND:CheckBuildShopBonusLv() >= 0 then
      FlowSys:Next("BuildBonus")
      return
    end
    FlowSys:Next("ExitShop")
  end
  function FlowSys.Proc.BuildBonus()
    local bonusLv = GROUND:CheckBuildShopBonusLv()
    if GROUND:GetBuildShopBonusOpenLand_Count(bonusLv) > 0 then
      EventPlay.eventSignboardOpenLand1st()
      if GROUND:GetBuildShopBonus_LandType(bonusLv) ~= PARADISE_LAND_TYPE.NONE then
        local landTypeTextId = GROUND:GetLandTypeNameTextId(GROUND:GetBuildShopBonus_LandType(bonusLv))
        SOUND:PlayMe(SymSnd("ME_RANKUP"))
        ShopSys:SysMsg(-949372209)
        SOUND:WaitMe()
        WINDOW:KeyWait()
        ShopSys:Talk(264550161, FACE_TYPE.NORMAL)
        WINDOW:KeyWait()
        CH("DOTEKKOTSU"):SetManpu("MP_SPREE_LP")
        CH("DOTEKKOTSU"):SetMotion(SymMot("LETSGO"), LOOP.OFF)
        CH("DOKKORAA_1"):SetMotion(SymMot("SPEAK"), LOOP.ON)
        CH("DOKKORAA_2"):SetMotion(SymMot("SPEAK"), LOOP.ON)
        SOUND:PlaySe(SymSnd("SE_WAZA_ODATERU"))
        TASK:Sleep(TimeSec(1.5))
        CH("DOTEKKOTSU"):ResetManpu()
        CH("DOKKORAA_1"):SetMotion(SymMot("WAIT02"), LOOP.ON)
        CH("DOKKORAA_2"):SetMotion(SymMot("WAIT02"), LOOP.ON)
        CH("DOTEKKOTSU"):SetMotion(SymMot("SPEAK"), LOOP.ON)
        ShopSys:SetShopTag("\232\167\163\230\148\190\227\129\149\227\130\140\227\129\159\229\177\158\230\128\167", MENU:GetTextPoolText(landTypeTextId))
        ShopSys:Talk(619308242, FACE_TYPE.NORMAL)
        WINDOW:KeyWait()
        ShopSys:SetShopTag("\232\167\163\230\148\190\227\129\149\227\130\140\227\129\159\229\177\158\230\128\167", MENU:GetTextPoolText(landTypeTextId))
        SOUND:PlayMe(SymSnd("ME_REWARD"))
        ShopSys:SysMsg(-300621142)
        SOUND:WaitMe()
      else
        WINDOW:KeyWait()
        SOUND:PlayMe(SymSnd("ME_RANKUP"))
        ShopSys:SysMsg(-949372209)
        SOUND:WaitMe()
        WINDOW:KeyWait()
      end
      ShopSys:Talk(-1685542222, FACE_TYPE.NORMAL)
      WINDOW:CloseMessage()
    end
    if GROUND:GetBuildShopBonus_GradeUpMenuOpen(bonusLv) then
      EventPlay.eventSignboardGradeUp()
    end
    if GROUND:GetBuildShopBonus_ColorChangeMenuOpen(bonusLv) then
      EventPlay.eventSignboardColorChange()
    end
    if GROUND:GetBuildShopBonus_BrokenMenuOpen(bonusLv) then
      EventPlay.eventSignboardBroken()
    end
    if GROUND:GetBuildShopBonus_OwnerChangeMenuOpen(bonusLv) then
      EventPlay.eventSignboardOwnerChange()
    end
    if GROUND:GetBuildShopBonus_FullOpen(bonusLv) then
      EventPlay.eventSignboardFullOpen()
    end
    GROUND:SetOpenedBuildShopBonusLv(bonusLv)
    FlowSys:Next("ExitShop")
  end
  function FlowSys.Proc.TopExtend()
    ShopSys:SetShopTag("\229\187\186\232\168\173\227\129\149\227\130\140\227\129\166\227\129\132\227\130\139\230\150\189\232\168\173", TatefudaSys:GetNowLandShopName())
    ShopSys:Talk(1099603065, FACE_TYPE.NORMAL)
    WINDOW:CloseMessage()
    FlowSys:Call("LookExtend")
    FlowSys:Next("ExtendConfirm")
  end
  function FlowSys.Proc.ExtendConfirm()
    local nextLevel = TatefudaSys:GetNowLandShopLevel() + 1
    ShopSys:SetShopTag("\229\187\186\232\168\173\227\129\149\227\130\140\227\129\166\227\129\132\227\130\139\230\150\189\232\168\173", TatefudaSys:GetNowLandShopName())
    ShopSys:TalkAskFlow(-1379467516, FACE_TYPE.NORMAL, nil, {
      next = "tatehudaMenuTop"
    }, {
      text = 1335050071,
      next = "",
      default = true
    }, {
      text = 1917748779,
      next = "tatehudaMenuTop"
    }, {text = 557995042, call = "LookExtend"})
    if ShopSys:NeedReturnFlow() then
      return
    end
    if GROUND:IsLandShopDevelopMaterialOk(TatefudaSys:GetNowLandShopId(), nextLevel) == false then
      ShopSys:Talk(1531479508, FACE_TYPE.NORMAL)
      WINDOW:KeyWait()
      FlowSys:Next("tatehudaMenuTop")
      return
    end
    if GROUND:IsLandShopDevelopMoneyOk(TatefudaSys:GetNowLandShopId(), nextLevel) == false then
      ShopSys:Talk(1109618751, FACE_TYPE.NORMAL)
      WINDOW:KeyWait()
      FlowSys:Next("tatehudaMenuTop")
      return
    end
    local taskbuild_cancelflag = 0
    EventPlay.eventSignboardBuildLvupBefore_Fast()
    local function taskEventSignboardBuildLvup()
      function TaskL.Start()
        EventPlay.eventSignboardBuildLvupBefore()
      end
    end
    TASK:Regist(Group("taskEventGrp"), taskEventSignboardBuildLvup)
    while TASK:IsEndTasks(Group("taskEventGrp")) == false do
      if PAD:Edge("B") then
        taskbuild_cancelflag = 1
        SOUND:FadeOutSe(SymSnd("SE_SHOP_GRADE_UP"), TimeSec(1))
        SOUND:PlaySe(SymSnd("SE_EVT_WHITEOUT"))
        SCREEN_A:WhiteOutAll(TimeSec(1), true)
        TASK:ExitNotifyTasks()
        break
      end
      TASK:Sleep(TimeSec(0))
    end
    TASK:WaitTask()
    if taskbuild_cancelflag == 0 then
      SOUND:PlaySe(SymSnd("SE_EVT_WHITEOUT"))
      SCREEN_A:WhiteOutAll(TimeSec(1), true)
      EventPlay.eventSignboardBuildLvupBefore_End()
    else
      EventPlay.eventSignboardBuildLvupBefore_End()
    end
    GROUND:PaymentDevelopLandShop(TatefudaSys:GetNowLandShopId(), nextLevel)
    GROUND:ExtendLandShop(TatefudaSys:GetNowLandShopPairs())
    reloadEntryAndResumeFlow("extend_after")
  end
  function FlowSys.Proc.extend_after()
    EventPlay.eventSignboardBuildLvupAfter()
    setExtendOpened()
    FlowSys:Next("ExitShop")
  end
  function FlowSys.Proc.LookExtend()
    dispExtendLookMenu(-1408819415, TatefudaSys:GetNowLandShopId(), TatefudaSys:GetNowLandShopLevel() + 1, function()
    end, function()
      FlowSys:Next("tatehudaMenuTop")
    end)
    if ShopSys:NeedReturnFlow() then
      return
    end
    FlowSys:Return()
  end
  function FlowSys.Proc.TopDestruction()
    ShopSys:SetShopTag("\229\187\186\232\168\173\227\129\149\227\130\140\227\129\166\227\129\132\227\130\139\230\150\189\232\168\173", TatefudaSys:GetNowLandShopName())
    ShopSys:TalkAskFlow(-1422991445, FACE_TYPE.NORMAL, nil, {
      next = "tatehudaMenuTop"
    }, {text = 1862566675, next = ""}, {
      text = -1383201684,
      next = "tatehudaMenuTop",
      default = true
    })
    if ShopSys:NeedReturnFlow() then
      return
    end
    ShopSys:TalkAskFlow(-1105600468, FACE_TYPE.NORMAL, nil, {
      next = "tatehudaMenuTop"
    }, {text = -642845300, next = ""}, {
      text = -94654760,
      next = "tatehudaMenuTop",
      default = true
    })
    if ShopSys:NeedReturnFlow() then
      return
    end
    local taskbuild_cancelflag = 0
    EventPlay.eventSignboardShopCrushBefore_Fast()
    local function taskEventSignboardShopCrush()
      function TaskL.Start()
        EventPlay.eventSignboardShopCrushBefore()
      end
    end
    TASK:Regist(Group("taskEventGrp"), taskEventSignboardShopCrush)
    while TASK:IsEndTasks(Group("taskEventGrp")) == false do
      if PAD:Edge("B") then
        taskbuild_cancelflag = 1
        SOUND:FadeOutSe(SymSnd("SE_SHOP_DESTROY"), TimeSec(1))
        SCREEN_A:FadeOut(TimeSec(1), true)
        TASK:ExitNotifyTasks()
        break
      end
      TASK:Sleep(TimeSec(0))
    end
    TASK:WaitTask()
    if taskbuild_cancelflag == 0 then
      SCREEN_A:FadeOut(TimeSec(1), true)
      EventPlay.eventSignboardShopCrushBefore_End()
    else
      EventPlay.eventSignboardShopCrushBefore_End()
    end
    local brokenShopName = TatefudaSys:GetNowLandShopName()
    GROUND:BrokenLandShop(TatefudaSys:GetNowLandShopPairs())
    reloadEntryAndResumeFlow("destruction_after", {brokenShopName = brokenShopName})
  end
  function FlowSys.Proc.destruction_after()
    SCREEN_A:FadeOut(TimeSec(0), false)
    SCREEN_B:FadeOutAll(TimeSec(0), false)
    local brokenShopName = FlowSys.Stat.resumeArgTbl.brokenShopName
    FlowSys.Stat.resumeArgTbl = nil
    EventPlay.eventSignboardShopCrushAfter(brokenShopName)
    setDestructionOpened()
    FlowSys:Next("ExitShop")
  end
  function FlowSys.Proc.TopPokemonChange()
    local selectChangePokemonIndex
    ShopSys:Talk(1207620349, FACE_TYPE.NORMAL)
    WINDOW:CloseMessage()
    dispShopStaffSelectMenu(329040099, -758048700, TatefudaSys.landIndex, TatefudaSys.spaceIndex, function(changePokemonIndex)
      selectChangePokemonIndex = changePokemonIndex
    end, function()
      FlowSys:Next("tatehudaMenuTop")
    end)
    if ShopSys:NeedReturnFlow() then
      return
    end
    ShopSys:SetShopTag("\227\131\157\227\130\177\227\131\162\227\131\179\229\144\141", GROUND:GetChangeStaffPokemonName(TatefudaSys.landIndex, TatefudaSys.spaceIndex, selectChangePokemonIndex))
    ShopSys:TalkAskFlow(488692704, FACE_TYPE.NORMAL, nil, {
      next = "tatehudaMenuTop"
    }, {text = 1244783999, next = ""}, {
      text = 480095634,
      next = "tatehudaMenuTop",
      default = true
    })
    if ShopSys:NeedReturnFlow() then
      return
    end
    EventPlay.eventSignboardShoperChangeBefore()
    GROUND:ChangeStaffLandShop(TatefudaSys.landIndex, TatefudaSys.spaceIndex, selectChangePokemonIndex)
    reloadEntryAndResumeFlow("pokemon_change_after", {selectChangePokemonIndex = selectChangePokemonIndex})
  end
  function FlowSys.Proc.pokemon_change_after()
    local selectChangePokemonIndex = FlowSys.Stat.resumeArgTbl.selectChangePokemonIndex
    EventPlay.eventSignboardShoperChangeAfter()
    setPokemonChangeOpened()
    FlowSys:Next("ExitShop")
  end
  function FlowSys.Proc.TopColorChange()
    ShopSys:Talk(-1731599621, FACE_TYPE.NORMAL)
    WINDOW:CloseMessage()
    local selectColorChangeId
    dispColorSelectMenu(-1000901194, 208098066, TatefudaSys:GetNowLandShopId(), TatefudaSys:GetNowLandShopLevel(), function(colorChangeId)
      selectColorChangeId = colorChangeId
    end, function()
      FlowSys:Next("tatehudaMenuTop")
    end)
    if ShopSys:NeedReturnFlow() then
      return
    end
    if GROUND:IsSameColorLandShop(TatefudaSys.landIndex, TatefudaSys.spaceIndex, selectColorChangeId) then
      ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\232\137\178", GetLandShopNameTextIdForTitle(selectColorChangeId))
      ShopSys:Talk(2043329857, FACE_TYPE.NORMAL)
      WINDOW:CloseMessage()
      FlowSys:Next("tatehudaMenuTop")
      return
    end
    if GROUND:IsColorChangeMaterialOk(selectColorChangeId) == false then
      ShopSys:Talk(908254794, FACE_TYPE.NORMAL)
      WINDOW:KeyWait()
      FlowSys:Next("tatehudaMenuTop")
      return
    end
    if GROUND:IsColorChangeMoneyOk(selectColorChangeId) == false then
      ShopSys:Talk(-1824466023, FACE_TYPE.NORMAL)
      WINDOW:KeyWait()
      FlowSys:Next("tatehudaMenuTop")
      return
    end
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\232\137\178", GetLandShopNameTextIdForTitle(selectColorChangeId))
    ShopSys:TalkAskFlow(236168505, FACE_TYPE.NORMAL, nil, {
      next = "tatehudaMenuTop"
    }, {text = 1251654511, next = ""}, {
      text = -1817119555,
      next = "tatehudaMenuTop",
      default = true
    })
    if ShopSys:NeedReturnFlow() then
      return
    end
    local taskbuild_cancelflag = 0
    EventPlay.eventSignboardShopColorChangeBefort_Fast()
    local function taskEventSignboardShopColorChange()
      function TaskL.Start()
        EventPlay.eventSignboardShopColorChangeBefort()
      end
    end
    TASK:Regist(Group("taskEventGrp"), taskEventSignboardShopColorChange)
    while TASK:IsEndTasks(Group("taskEventGrp")) == false do
      if PAD:Edge("B") then
        taskbuild_cancelflag = 1
        SOUND:FadeOutSe(SymSnd("SE_SHOP_PAINT"), TimeSec(1))
        SOUND:PlaySe(SymSnd("SE_EVT_WHITEOUT"))
        SCREEN_A:WhiteOutAll(TimeSec(1), true)
        TASK:ExitNotifyTasks()
        break
      end
      TASK:Sleep(TimeSec(0))
    end
    TASK:WaitTask()
    if taskbuild_cancelflag == 0 then
      SOUND:PlaySe(SymSnd("SE_EVT_WHITEOUT"))
      SCREEN_A:WhiteOutAll(TimeSec(1), true)
      EventPlay.eventSignboardShopColorChangeBefort_End()
    else
      EventPlay.eventSignboardShopColorChangeBefort_End()
    end
    GROUND:PaymentDevelopLandShop(selectColorChangeId, 0)
    GROUND:ChangeColorLandShop(TatefudaSys.landIndex, TatefudaSys.spaceIndex, selectColorChangeId)
    GROUND:SetOpenLimitState_LandShopLabel(selectColorChangeId, PARADISE_OPEN_LIMIT_STATE.OPEN)
    reloadEntryAndResumeFlow("color_change_after", {selectColorChangeId = selectColorChangeId})
  end
  function FlowSys.Proc.color_change_after()
    local selectColorChangeId = FlowSys.Stat.resumeArgTbl.selectColorChangeId
    EventPlay.eventSignboardShopColorChangeAfter(selectColorChangeId)
    setColorChangeOpened()
    FlowSys:Next("ExitShop")
  end
  function FlowSys.Proc.Help()
    ShopSys:SysMsg(-675528387)
    FlowSys:Return()
  end
  function FlowSys.Proc.ExitShopNoFade()
    WINDOW:CloseMessage()
    FlowSys:Next("tatehudaMenuEnd")
  end
  function FlowSys.Proc.ExitShop()
    EventPlay.eventSignboardGoodbye(false)
    FlowSys:Next("tatehudaMenuEnd")
  end
  function FlowSys.Proc.DefeatExitShop()
    EventPlay.eventSignboardGoodbye(true)
    FlowSys:Next("tatehudaMenuEnd")
  end
  function FlowSys.Proc.tatehudaMenuEnd()
    FlowSys:Return()
  end
  function EventPlay.eventSignboardDottekotsuCome()
    local POINT_DOTEKKOTSU = SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex))
    local POINT_DOKKORAA_1 = SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex), PosOffs(-0.55, -0.75))
    local POINT_DOKKORAA_2 = SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex), PosOffs(0.55, -0.75))
    SCREEN_A:FadeOutAll(TimeSec(0.3), false)
    SCREEN_B:FadeOutAll(TimeSec(0.3), true)
    SYSTEM:FreeMoveScriptEventStartAll()
    CHARA:DynamicRemoveLandNpc()
    if CHARA:IsExist("DIG_SHOP_OWNER") then
      CH("DIG_SHOP_OWNER"):SetVisible(false)
    end
    if CHARA:IsExist("MEROETTA_VOICE") then
      CH("MEROETTA_VOICE"):SetVisible(false)
      CH("MEROETTA_STEP"):SetVisible(false)
    end
    CHARA:DynamicLoad("DOTEKKOTSU", "DOTEKKOTSU")
    CHARA:DynamicLoad("DOKKORAA_1", "DOKKORAA_1")
    CHARA:DynamicLoad("DOKKORAA_2", "DOKKORAA_2")
    CH("DOTEKKOTSU"):SetPosition(POINT_DOTEKKOTSU)
    CH("DOKKORAA_1"):SetPosition(POINT_DOKKORAA_1)
    CH("DOKKORAA_2"):SetPosition(POINT_DOKKORAA_2)
    if FLAG.ParaMode == CONST.PARA_MODE_PARADISE or FLAG.StoryPlayerMode == CONST.ST_MODE_PARTNER or FLAG.StoryPlayerMode == CONST.ST_MODE_HERO then
      local POINT_PARTY0 = SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex), PosOffs(0, 1.3))
      CH("PARTY0"):SetPosition(POINT_PARTY0)
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
    else
      local POINT_PARTY0 = SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex), PosOffs(-0.6, 1.3))
      local POINT_PARTY1 = SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex), PosOffs(0.6, 1.3))
      CH("PARTY0"):SetPosition(POINT_PARTY0)
      CH("PARTY1"):SetPosition(POINT_PARTY1)
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
      CH("PARTY1"):SetDir(CH("DOTEKKOTSU"))
    end
    CAMERA:SetEye(SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex), PosOffs(0, 4, 9)))
    CAMERA:SetTgt(SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex)))
    CAMERA:Zoom(Distance(5), TimeSec(0), ACCEL_TYPE.NONE, DECEL_TYPE.HIGH)
    CAMERA:Zoom(Distance(10), TimeSec(0.2), ACCEL_TYPE.NONE, DECEL_TYPE.HIGH)
    LOWER_SCREEN:SetVisible(false)
    SCREEN_B:LoadWallpaper("WALLPAPER_SUB_NOTICE01")
    SCREEN_B:SetVisibleWallpaper(true)
    SCREEN_A:FadeInAll(TimeSec(0.5), false)
    SCREEN_B:FadeInAll(TimeSec(0.5), true)
    CAMERA:WaitMove()
  end
  function EventPlay.eventSignboardBuildBefore_Fast(selectLandShopId)
    SCREEN_A:FadeOut(TimeSec(0.3), false)
    SCREEN_B:FadeOutAll(TimeSec(0.3), true)
    SOUND:VolumeBgm(Volume(64), TimeSec(0.8))
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local POINT_00 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.95, -1))
    local POINT_01 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 1.95))
    local POINT_02 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.95, -1))
    local POINT_00_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.95, 0.8))
    local POINT_01_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.95, 0.8))
    local POINT_02_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, -2.1))
    CAMERA:SetEye(SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 5, 10)))
    CAMERA:SetTgt(SymPos(string.format("@SHOP_CENTER%02d", spaceIndex)))
    CH("DOTEKKOTSU"):SetPosition(POINT_00)
    CH("DOKKORAA_1"):SetPosition(POINT_01)
    CH("DOKKORAA_2"):SetPosition(POINT_02)
    CH("DOTEKKOTSU"):SetDir(POINT_CENTER)
    CH("DOKKORAA_1"):SetDir(POINT_CENTER)
    CH("DOKKORAA_2"):SetDir(POINT_CENTER)
    CH("PARTY0"):SetDir(POINT_CENTER)
    CH("PARTY1"):SetDir(POINT_CENTER)
    CH("PARTY0"):SetVisible(false)
    CH("PARTY1"):SetVisible(false)
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPEAK"), LOOP.ON)
    CH("DOKKORAA_1"):SetMotion(SymMot("SPEAK"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("SPEAK"), LOOP.ON)
    SCREEN_A:FadeIn(TimeSec(0.5), true)
    TASK:Sleep(TimeSec(0.3))
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\230\150\189\232\168\173", GetLandShopNameTextIdForTitle(selectLandShopId))
    WINDOW:DrawFace(324, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOTEKKOTSU"), 1334087209)
    WINDOW:CloseMessage()
    subEveJump(CH("DOKKORAA_1"))
    subEveJump(CH("DOKKORAA_2"))
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\230\150\189\232\168\173", GetLandShopNameTextIdForTitle(selectLandShopId))
    WINDOW:DrawFace(20, 88, SymAct("DOKKORAA_1"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOKKORAA_1"), -487638842)
    WINDOW:CloseMessage()
    SOUND:PlaySe(SymSnd("SE_SHOP_BUILD"))
  end
  function EventPlay.eventSignboardBuildBefore(selectLandShopId)
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local POINT_00 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.95, -1))
    local POINT_01 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 1.95))
    local POINT_02 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.95, -1))
    local POINT_00_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.95, 0.8))
    local POINT_01_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.95, 0.8))
    local POINT_02_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, -2.1))
    CH("DOTEKKOTSU"):RunTo(SplinePath(POINT_00_1, POINT_01), Speed(4))
    CH("DOKKORAA_1"):RunTo(SplinePath(POINT_01_1, POINT_02), Speed(4))
    CH("DOKKORAA_2"):RunTo(SplinePath(POINT_02_1, POINT_00), Speed(4))
    TASK:Sleep(TimeSec(0), TASK_EXIT.QUICK)
    CH("DOTEKKOTSU"):WaitMove()
    CH("DOKKORAA_1"):WaitMove()
    CH("DOKKORAA_2"):WaitMove()
    CH("DOTEKKOTSU"):DirTo(POINT_CENTER, Speed(500), ROT_TYPE.NEAR)
    CH("DOKKORAA_1"):DirTo(POINT_CENTER, Speed(500), ROT_TYPE.NEAR)
    CH("DOKKORAA_2"):DirTo(POINT_CENTER, Speed(500), ROT_TYPE.NEAR)
    CH("DOTEKKOTSU"):WaitRotate()
    CH("DOKKORAA_1"):WaitRotate()
    CH("DOKKORAA_2"):WaitRotate()
    CH("DOTEKKOTSU"):SetMotionRaito(Raito(1.3))
    CH("DOKKORAA_1"):SetMotionRaito(Raito(1.3))
    CH("DOKKORAA_2"):SetMotionRaito(Raito(1.3))
    CH("DOTEKKOTSU"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_1"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOTEKKOTSU"):WaitPlayMotion()
    CH("DOKKORAA_1"):WaitPlayMotion()
    CH("DOKKORAA_2"):WaitPlayMotion()
    EFFECT:Create("effectsmoke01", SymEff("EV_SMOKE_POP_BROWN"))
    EFFECT:SetScale("effectsmoke01", Scale(2))
    EFFECT:SetPosition("effectsmoke01", POINT_CENTER)
    EFFECT:Play("effectsmoke01")
    EFFECT:Create("effecthit01", SymEff("NM_WAZAHIT_SMALL_WHITE"))
    EFFECT:SetScale("effecthit01", Scale(0.6))
    EFFECT:SetPosition("effecthit01", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-0.4, 0.2, -0.1)))
    EFFECT:Play("effecthit01")
    CH("DOTEKKOTSU"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_1"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("THROW"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.1))
    EFFECT:Create("effecthit02", SymEff("NM_WAZAHIT_SMALL_WHITE"))
    EFFECT:SetScale("effecthit02", Scale(0.8))
    EFFECT:SetPosition("effecthit02", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0.4, 0.2, 0.1)))
    EFFECT:Play("effecthit02")
    TASK:Sleep(TimeSec(0.1))
    EFFECT:Create("effecthit03", SymEff("NM_WAZAHIT_SMALL_WHITE"))
    EFFECT:SetScale("effecthit03", Scale(0.4))
    EFFECT:SetPosition("effecthit03", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-0.1, 0.2, 0.3)))
    EFFECT:Play("effecthit03")
    CH("DOTEKKOTSU"):WaitPlayMotion()
    CH("DOKKORAA_1"):WaitPlayMotion()
    CH("DOKKORAA_2"):WaitPlayMotion()
    EFFECT:Create("effectice", SymEff("EV_GLITTER_SMOKE_LP"))
    EFFECT:SetScale("effectice", Scale(1.5))
    EFFECT:SetPosition("effectice", POINT_CENTER)
    EFFECT:Play("effectice")
    CH("DOTEKKOTSU"):RunTo(SplinePath(POINT_01_1, POINT_02), Speed(5.5))
    CH("DOKKORAA_1"):RunTo(SplinePath(POINT_02_1, POINT_00), Speed(5.5))
    CH("DOKKORAA_2"):RunTo(SplinePath(POINT_00_1, POINT_01), Speed(5.5))
    TASK:Sleep(TimeSec(0), TASK_EXIT.QUICK)
    CH("DOTEKKOTSU"):WaitMove()
    CH("DOKKORAA_1"):WaitMove()
    CH("DOKKORAA_2"):WaitMove()
    CH("DOTEKKOTSU"):DirTo(POINT_CENTER, Speed(700), ROT_TYPE.NEAR)
    CH("DOKKORAA_1"):DirTo(POINT_CENTER, Speed(700), ROT_TYPE.NEAR)
    CH("DOKKORAA_2"):DirTo(POINT_CENTER, Speed(700), ROT_TYPE.NEAR)
    CH("DOTEKKOTSU"):WaitRotate()
    CH("DOKKORAA_1"):WaitRotate()
    CH("DOKKORAA_2"):WaitRotate()
    CH("DOTEKKOTSU"):SetMotionRaito(Raito(1.7))
    CH("DOKKORAA_1"):SetMotionRaito(Raito(1.7))
    CH("DOKKORAA_2"):SetMotionRaito(Raito(1.7))
    CH("DOTEKKOTSU"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_1"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOTEKKOTSU"):WaitPlayMotion()
    CH("DOKKORAA_1"):WaitPlayMotion()
    CH("DOKKORAA_2"):WaitPlayMotion()
    EFFECT:Create("effectsmoke02", SymEff("EV_SMOKE_POP_BROWN"))
    EFFECT:SetScale("effectsmoke02", Scale(4))
    EFFECT:SetPosition("effectsmoke02", POINT_CENTER)
    EFFECT:Play("effectsmoke02")
    EFFECT:Create("effecthit01", SymEff("NM_WAZAHIT_SMALL_WHITE"))
    EFFECT:SetScale("effecthit01", Scale(0.6))
    EFFECT:SetPosition("effecthit01", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-0.4, 0.2, -0.1)))
    EFFECT:Play("effecthit01")
    CH("DOTEKKOTSU"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_1"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("THROW"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.1))
    EFFECT:Create("effecthit02", SymEff("NM_WAZAHIT_SMALL_WHITE"))
    EFFECT:SetScale("effecthit02", Scale(0.8))
    EFFECT:SetPosition("effecthit02", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0.4, 0.2, 0.1)))
    EFFECT:Play("effecthit02")
    TASK:Sleep(TimeSec(0.1))
    EFFECT:Create("effecthit03", SymEff("NM_WAZAHIT_SMALL_WHITE"))
    EFFECT:SetScale("effecthit03", Scale(0.4))
    EFFECT:SetPosition("effecthit03", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-0.1, 0.2, 0.3)))
    EFFECT:Play("effecthit03")
    CH("DOTEKKOTSU"):WaitPlayMotion()
    CH("DOKKORAA_1"):WaitPlayMotion()
    CH("DOKKORAA_2"):WaitPlayMotion()
    CH("DOTEKKOTSU"):RunTo(SplinePath(POINT_02_1, POINT_00), Speed(6.5))
    CH("DOKKORAA_1"):RunTo(SplinePath(POINT_00_1, POINT_01), Speed(6.5))
    CH("DOKKORAA_2"):RunTo(SplinePath(POINT_01_1, POINT_02), Speed(6.5))
    TASK:Sleep(TimeSec(0), TASK_EXIT.QUICK)
    CH("DOTEKKOTSU"):WaitMove()
    CH("DOKKORAA_1"):WaitMove()
    CH("DOKKORAA_2"):WaitMove()
    CH("DOTEKKOTSU"):DirTo(POINT_CENTER, Speed(900), ROT_TYPE.NEAR)
    CH("DOKKORAA_1"):DirTo(POINT_CENTER, Speed(900), ROT_TYPE.NEAR)
    CH("DOKKORAA_2"):DirTo(POINT_CENTER, Speed(900), ROT_TYPE.NEAR)
    CH("DOTEKKOTSU"):WaitRotate()
    CH("DOKKORAA_1"):WaitRotate()
    CH("DOKKORAA_2"):WaitRotate()
    CH("DOTEKKOTSU"):SetMotionRaito(Raito(2))
    CH("DOKKORAA_1"):SetMotionRaito(Raito(2))
    CH("DOKKORAA_2"):SetMotionRaito(Raito(2))
    CH("DOTEKKOTSU"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_1"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOTEKKOTSU"):WaitPlayMotion()
    CH("DOKKORAA_1"):WaitPlayMotion()
    CH("DOKKORAA_2"):WaitPlayMotion()
    EFFECT:Create("effectsmoke03", SymEff("EV_SMOKE_POP_BROWN"))
    EFFECT:SetScale("effectsmoke03", Scale(6))
    EFFECT:SetPosition("effectsmoke03", POINT_CENTER)
    EFFECT:Play("effectsmoke03")
    EFFECT:Create("effecthit01", SymEff("NM_WAZAHIT_SMALL_WHITE"))
    EFFECT:SetScale("effecthit01", Scale(0.6))
    EFFECT:SetPosition("effecthit01", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-0.4, 0.2, -0.1)))
    EFFECT:Play("effecthit01")
    CH("DOTEKKOTSU"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_1"):SetMotion(SymMot("THROW"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("THROW"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.1), TASK_EXIT.QUICK)
    EFFECT:Create("effecthit02", SymEff("NM_WAZAHIT_SMALL_WHITE"))
    EFFECT:SetScale("effecthit02", Scale(0.8))
    EFFECT:SetPosition("effecthit02", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0.4, 0.2, 0.1)))
    EFFECT:Play("effecthit02")
    TASK:Sleep(TimeSec(0.1), TASK_EXIT.QUICK)
    EFFECT:Create("effecthit03", SymEff("NM_WAZAHIT_SMALL_WHITE"))
    EFFECT:SetScale("effecthit03", Scale(0.4))
    EFFECT:SetPosition("effecthit03", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-0.1, 0.2, 0.3)))
    EFFECT:Play("effecthit03")
    CH("DOTEKKOTSU"):WaitPlayMotion()
    CH("DOKKORAA_1"):WaitPlayMotion()
    CH("DOKKORAA_2"):WaitPlayMotion()
    CH("DOKKORAA_1"):RunTo(SplinePath(POINT_01_1, POINT_02, POINT_02_1), Speed(7.3))
    CH("DOKKORAA_2"):RunTo(SplinePath(POINT_02_1, POINT_00, POINT_00_1), Speed(7.3))
    CH("DOTEKKOTSU"):RunTo(SplinePath(POINT_00_1, POINT_01, POINT_01_1), Speed(7.3))
    TASK:Sleep(TimeSec(0), TASK_EXIT.QUICK)
    TASK:Sleep(TimeSec(0.9))
    EFFECT:Create("effectsmoke05", SymEff("EV_SMOKE_POP_BROWN"))
    EFFECT:SetScale("effectsmoke05", Scale(10))
    EFFECT:SetPosition("effectsmoke05", POINT_CENTER)
    EFFECT:Play("effectsmoke05")
    CH("DOKKORAA_1"):RunTo(SplinePath(POINT_00, POINT_00_1, POINT_01), Speed(7.3))
    CH("DOKKORAA_2"):RunTo(SplinePath(POINT_01, POINT_01_1, POINT_02), Speed(7.3))
    CH("DOTEKKOTSU"):RunTo(SplinePath(POINT_02, POINT_02_1, POINT_00), Speed(7.3))
    TASK:Sleep(TimeSec(0), TASK_EXIT.QUICK)
    TASK:Sleep(TimeSec(0.9))
    EFFECT:Create("effectsmoke06", SymEff("EV_SMOKE_POP_BROWN"))
    EFFECT:SetScale("effectsmoke06", Scale(10))
    EFFECT:SetPosition("effectsmoke06", POINT_CENTER)
    EFFECT:Play("effectsmoke06")
    CH("DOKKORAA_1"):RunTo(SplinePath(POINT_01_1, POINT_02, POINT_02_1), Speed(7.3))
    CH("DOKKORAA_2"):RunTo(SplinePath(POINT_02_1, POINT_00, POINT_00_1), Speed(7.3))
    CH("DOTEKKOTSU"):RunTo(SplinePath(POINT_00_1, POINT_01, POINT_01_1), Speed(7.3))
  end
  function EventPlay.eventSignboardBuildBefore_End(selectLandShopId)
    EFFECT:Remove("effectsmoke01")
    CHARA:DynamicRemove("DOTEKKOTSU")
    CHARA:DynamicRemove("DOKKORAA_1")
    CHARA:DynamicRemove("DOKKORAA_2")
  end
  function EventPlay.eventSignboardBuildAfter()
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local SHOP_COUNTER = SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex))
    local POINT_DOTEKKOTSU = SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex))
    local SHOP_OWNER = TatefudaSys:GetNowLandShopOwnerSymbol()
    CHARA:DynamicRemoveLandNpc()
    if CHARA:IsExist("DIG_SHOP_OWNER") then
      CH("DIG_SHOP_OWNER"):SetVisible(false)
    end
    if CHARA:IsExist("MEROETTA_VOICE") then
      CH("MEROETTA_VOICE"):SetVisible(false)
      CH("MEROETTA_STEP"):SetVisible(false)
    end
    CH("DOTEKKOTSU"):SetDir(POINT_CENTER)
    CH("DOKKORAA_1"):SetDir(POINT_CENTER)
    CH("DOKKORAA_2"):SetDir(POINT_CENTER)
    CH("PARTY0"):SetDir(POINT_CENTER)
    CH("PARTY1"):SetDir(POINT_CENTER)
    CH("PARTY0"):SetVisible(true)
    CH("PARTY1"):SetVisible(true)
    if CHARA:IsExist(SHOP_OWNER) then
      CH(SHOP_OWNER):SetVisible(false)
    end
    CAMERA:SetEye(SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex), PosOffs(0, 5, 10)))
    CAMERA:SetTgt(SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex)))
    CH("DOTEKKOTSU"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.1))
    CH("DOKKORAA_1"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    SCREEN_A:WhiteInAll(TimeSec(0.5), true)
    SOUND:PlayMe(SymSnd("ME_MINIGAME_PERFECT"))
    SOUND:WaitMe()
    CH("DOTEKKOTSU"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_1"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    SOUND:VolumeBgm(Volume(256), TimeSec(0.8))
    WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOTEKKOTSU"), -2011716786)
    WINDOW:CloseMessage()
    if CHARA:IsExist(SHOP_OWNER) then
      SOUND:PlaySe(SymSnd("SE_EVT_BUNI"))
      EFFECT:Create("effectsmoke", SymEff("NM_SMOKE_SHORT_WHITE"))
      EFFECT:SetScale("effectsmoke", Scale(1))
      EFFECT:SetPosition("effectsmoke", SHOP_COUNTER)
      EFFECT:Play("effectsmoke")
      TASK:Sleep(TimeSec(0.3))
      CH(SHOP_OWNER):SetVisible(true)
      TASK:Sleep(TimeSec(0.8))
      subEveDoubleJump(CH(SHOP_OWNER))
      WINDOW:DrawFace(20, 88, SymAct(SHOP_OWNER), FACE_TYPE.NORMAL)
      WINDOW:Talk(SymAct(SHOP_OWNER), -1625831405)
      WINDOW:CloseMessage()
      CAMERA:MoveFollow(POINT_DOTEKKOTSU, Speed(3.5, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
      subEveNod(CH("PARTY0"))
    else
      CAMERA:MoveFollow(POINT_DOTEKKOTSU, Speed(3.5, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
    end
    CH("DOTEKKOTSU"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    CH("DOKKORAA_1"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    TASK:Sleep(TimeSec(0.1))
    CH("DOKKORAA_2"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    CH("PARTY0"):DirTo(CH("DOTEKKOTSU"), Speed(500), ROT_TYPE.NEAR)
    CH("PARTY1"):DirTo(CH("DOTEKKOTSU"), Speed(500), ROT_TYPE.NEAR)
    CAMERA:WaitMove()
    SCREEN_B:FadeInAll(TimeSec(0.5), true)
  end
  function EventPlay.eventSignboardBuildLvupBefore_Fast()
    SCREEN_A:FadeOut(TimeSec(0.3), false)
    SCREEN_B:FadeOutAll(TimeSec(0.3), true)
    SOUND:VolumeBgm(Volume(64), TimeSec(0.8))
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local SHOP_COUNTER = SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex))
    local SHOP_OWNER = TatefudaSys:GetNowLandShopOwnerSymbol()
    local POINT_DOTEKKOTSU = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0.1, 2.6))
    local POINT_DOKKORAA_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.6, 1.75))
    local POINT_DOKKORAA_2 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.6, 1.75))
    CAMERA:SetEye(SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 5, 10)))
    CAMERA:SetTgt(SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 2)))
    CH("DOTEKKOTSU"):SetPosition(POINT_DOTEKKOTSU)
    CH("DOKKORAA_1"):SetPosition(POINT_DOKKORAA_1)
    CH("DOKKORAA_2"):SetPosition(POINT_DOKKORAA_2)
    CH("DOTEKKOTSU"):SetDir(POINT_CENTER)
    CH("DOKKORAA_1"):SetDir(CH("DOTEKKOTSU"))
    CH("DOKKORAA_2"):SetDir(CH("DOTEKKOTSU"))
    CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
    CH("PARTY1"):SetDir(CH("DOTEKKOTSU"))
    CH("PARTY0"):SetVisible(false)
    CH("PARTY1"):SetVisible(false)
    if CHARA:IsExist(SHOP_OWNER) then
      CH(SHOP_OWNER):SetVisible(false)
    end
    SCREEN_A:FadeIn(TimeSec(0.5), true)
    TASK:Sleep(TimeSec(0.3))
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOTEKKOTSU"):WaitPlayMotion()
    CH("DOTEKKOTSU"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOTEKKOTSU"), 710889638)
    WINDOW:CloseMessage()
    subEveJump(CH("DOKKORAA_1"))
    subEveJump(CH("DOKKORAA_2"))
    WINDOW:DrawFace(324, 88, SymAct("DOKKORAA_1"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOKKORAA_1"), 1067394634)
    WINDOW:CloseMessage()
    CH("DOKKORAA_1"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("DOKKORAA_2"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("PARTY0"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("PARTY1"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("DOKKORAA_2"):WaitRotate()
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOKKORAA_1"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOKKORAA_2"):WaitPlayMotion()
    CH("DOTEKKOTSU"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_1"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOTEKKOTSU"):SetMotion(SymMot("THROW"), LOOP.ON)
    CH("DOKKORAA_1"):SetMotion(SymMot("THROW"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("THROW"), LOOP.ON)
    SOUND:PlaySe(SymSnd("SE_SHOP_GRADE_UP"))
  end
  function EventPlay.eventSignboardBuildLvupBefore()
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local SHOP_COUNTER = SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex))
    local SHOP_OWNER = TatefudaSys:GetNowLandShopOwnerSymbol()
    local POINT_DOTEKKOTSU = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0.1, 2.6))
    local POINT_DOKKORAA_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.6, 1.75))
    local POINT_DOKKORAA_2 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.6, 1.75))
    EFFECT:Create("effectup01", SymEff("NM_STRENGTHUP_VR_YELLOW"))
    EFFECT:SetScale("effectup01", Scale(1))
    EFFECT:SetPosition("effectup01", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.2, 0.5)))
    EFFECT:Play("effectup01")
    CAMERA:MoveFollow(POINT_CENTER, Speed(0.6, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
    TASK:Sleep(TimeSec(0.5), TASK_EXIT.QUICK)
    EFFECT:Create("effectup02", SymEff("NM_STRENGTHUP_VR_BLUEWHITE"))
    EFFECT:SetScale("effectup02", Scale(1))
    EFFECT:SetPosition("effectup02", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.2, 0.5)))
    EFFECT:Play("effectup02")
    TASK:Sleep(TimeSec(0.2), TASK_EXIT.QUICK)
    EFFECT:Create("effectup03", SymEff("NM_STRENGTHUP_RED"))
    EFFECT:SetScale("effectup03", Scale(1.5))
    EFFECT:SetPosition("effectup03", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 1.2)))
    EFFECT:Play("effectup03")
    TASK:Sleep(TimeSec(0.5), TASK_EXIT.QUICK)
    EFFECT:Create("effectup04", SymEff("NM_STRENGTHUP_VR_YELLOW"))
    EFFECT:SetScale("effectup04", Scale(1))
    EFFECT:SetPosition("effectup04", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.2, 0.5)))
    EFFECT:Play("effectup04")
    TASK:Sleep(TimeSec(0.5), TASK_EXIT.QUICK)
    EFFECT:Create("effectup05", SymEff("NM_STRENGTHUP_VR_BLUEWHITE"))
    EFFECT:SetScale("effectup05", Scale(1))
    EFFECT:SetPosition("effectup05", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.2, 0.5)))
    EFFECT:Play("effectup05")
    TASK:Sleep(TimeSec(0.2), TASK_EXIT.QUICK)
    EFFECT:Create("effectup06", SymEff("NM_STRENGTHUP_RED"))
    EFFECT:SetScale("effectup06", Scale(1.5))
    EFFECT:SetPosition("effectup06", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 1.2)))
    EFFECT:Play("effectup06")
  end
  function EventPlay.eventSignboardBuildLvupBefore_End()
    CHARA:DynamicRemove("DOTEKKOTSU")
    CHARA:DynamicRemove("DOKKORAA_1")
    CHARA:DynamicRemove("DOKKORAA_2")
  end
  function EventPlay.eventSignboardBuildLvupAfter()
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local SHOP_COUNTER = SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex))
    local POINT_DOTEKKOTSU = SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex))
    local SHOP_OWNER = TatefudaSys:GetNowLandShopOwnerSymbol()
    CHARA:DynamicRemoveLandNpc()
    if CHARA:IsExist("DIG_SHOP_OWNER") then
      CH("DIG_SHOP_OWNER"):SetVisible(false)
    end
    if CHARA:IsExist("MEROETTA_VOICE") then
      CH("MEROETTA_VOICE"):SetVisible(false)
      CH("MEROETTA_STEP"):SetVisible(false)
    end
    CH("DOTEKKOTSU"):SetDir(POINT_CENTER)
    CH("DOKKORAA_1"):SetDir(POINT_CENTER)
    CH("DOKKORAA_2"):SetDir(POINT_CENTER)
    CH("PARTY0"):SetDir(POINT_CENTER)
    CH("PARTY1"):SetDir(POINT_CENTER)
    CH("PARTY0"):SetVisible(true)
    CH("PARTY1"):SetVisible(true)
    if CHARA:IsExist(SHOP_OWNER) then
      CH(SHOP_OWNER):SetVisible(false)
    end
    CAMERA:SetEye(SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex), PosOffs(0, 5, 10)))
    CAMERA:SetTgt(SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex)))
    CH("DOTEKKOTSU"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.1))
    CH("DOKKORAA_1"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    SCREEN_A:WhiteInAll(TimeSec(0.5), true)
    SOUND:PlayMe(SymSnd("ME_LEVELUP"))
    SOUND:WaitMe()
    CH("DOTEKKOTSU"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_1"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    SOUND:VolumeBgm(Volume(256), TimeSec(0.8))
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\230\150\189\232\168\173", TatefudaSys:GetNowLandShopName())
    WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOTEKKOTSU"), -1336369188)
    WINDOW:CloseMessage()
    if CHARA:IsExist(SHOP_OWNER) then
      SOUND:PlaySe(SymSnd("SE_EVT_BUNI"))
      EFFECT:Create("effectsmoke", SymEff("NM_SMOKE_SHORT_WHITE"))
      EFFECT:SetScale("effectsmoke", Scale(1))
      EFFECT:SetPosition("effectsmoke", SHOP_COUNTER)
      EFFECT:Play("effectsmoke")
      TASK:Sleep(TimeSec(0.3))
      CH(SHOP_OWNER):SetVisible(true)
      TASK:Sleep(TimeSec(0.8))
      CH(SHOP_OWNER):SetMotion(SymMot("VICTORY"), LOOP.OFF)
      CH(SHOP_OWNER):WaitPlayMotion()
      CH(SHOP_OWNER):SetMotion(SymMot("WAIT02"), LOOP.ON)
      WINDOW:DrawFace(20, 88, SymAct(SHOP_OWNER), FACE_TYPE.NORMAL)
      WINDOW:Talk(SymAct(SHOP_OWNER), -157476827)
      WINDOW:CloseMessage()
      CAMERA:MoveFollow(POINT_DOTEKKOTSU, Speed(3.5, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
      subEveNod(CH("PARTY0"))
    else
      CAMERA:MoveFollow(POINT_DOTEKKOTSU, Speed(3.5, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
    end
    CH("DOTEKKOTSU"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    CH("DOKKORAA_1"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    TASK:Sleep(TimeSec(0.1))
    CH("DOKKORAA_2"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    CH("PARTY0"):DirTo(CH("DOTEKKOTSU"), Speed(500), ROT_TYPE.NEAR)
    CH("PARTY1"):DirTo(CH("DOTEKKOTSU"), Speed(500), ROT_TYPE.NEAR)
    CAMERA:WaitMove()
    SCREEN_B:FadeInAll(TimeSec(0.5), true)
  end
  function EventPlay.eventSignboardOpenLand1st()
    subEveNodDouble(CH("DOTEKKOTSU"))
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPEAK"), LOOP.ON)
    ShopSys:Talk(2145605146, FACE_TYPE.NORMAL)
    WINDOW:CloseMessage()
  end
  function EventPlay.eventSignboardOpenLandTypeOn()
  end
  function EventPlay.eventSignboardOpenLandTypeOff()
  end
  function EventPlay.eventSignboardGradeUp()
    local PosDotekkotsu = CH("DOTEKKOTSU"):GetPosition()
    ShopSys:Talk(794762549, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    SOUND:PlaySe(SymSnd("SE_WAZA_ODATERU"))
    CH("DOTEKKOTSU"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.3))
    CH("DOKKORAA_1"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    EFFECT:Create("effect", SymEff("EV_PAPERBLOW_VR_COMB"))
    EFFECT:SetScale("effect", Scale(2))
    EFFECT:SetPosition("effect", PosDotekkotsu)
    EFFECT:Play("effect")
    SOUND:WaitMe()
    ShopSys:Talk(74600182, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    CH("DOKKORAA_1"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPEAK"), LOOP.ON)
    ShopSys:Talk(493453239, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    SOUND:PlayMe(SymSnd("ME_RANKUP"))
    ShopSys:SysMsg(2074505082)
    SOUND:WaitMe()
  end
  function EventPlay.eventSignboardColorChange()
    local PosDotekkotsu = CH("DOTEKKOTSU"):GetPosition()
    ShopSys:Talk(-264218435, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    SOUND:PlaySe(SymSnd("SE_WAZA_ODATERU"))
    CH("DOTEKKOTSU"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.3))
    CH("DOKKORAA_1"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    EFFECT:Create("effect", SymEff("EV_PAPERBLOW_VR_COMB"))
    EFFECT:SetScale("effect", Scale(2))
    EFFECT:SetPosition("effect", PosDotekkotsu)
    EFFECT:Play("effect")
    SOUND:WaitMe()
    ShopSys:Talk(-613610626, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    CH("DOKKORAA_1"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPEAK"), LOOP.ON)
    ShopSys:Talk(-1032439233, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    SOUND:PlayMe(SymSnd("ME_RANKUP"))
    ShopSys:SysMsg(-496946964)
    SOUND:WaitMe()
  end
  function EventPlay.eventSignboardBroken()
    local PosDotekkotsu = CH("DOTEKKOTSU"):GetPosition()
    ShopSys:Talk(851328882, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    SOUND:PlaySe(SymSnd("SE_WAZA_ODATERU"))
    CH("DOTEKKOTSU"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.3))
    CH("DOKKORAA_1"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    EFFECT:Create("effect", SymEff("EV_PAPERBLOW_VR_COMB"))
    EFFECT:SetScale("effect", Scale(2))
    EFFECT:SetPosition("effect", PosDotekkotsu)
    EFFECT:Play("effect")
    SOUND:WaitMe()
    ShopSys:Talk(429092017, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    CH("DOKKORAA_1"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPEAK"), LOOP.ON)
    ShopSys:Talk(8936944, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    SOUND:PlayMe(SymSnd("ME_RANKUP"))
    ShopSys:SysMsg(-491519625)
    SOUND:WaitMe()
  end
  function EventPlay.eventSignboardOwnerChange()
    local PosDotekkotsu = CH("DOTEKKOTSU"):GetPosition()
    ShopSys:Talk(2099667616, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    SOUND:PlaySe(SymSnd("SE_WAZA_ODATERU"))
    CH("DOTEKKOTSU"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.3))
    CH("DOKKORAA_1"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    EFFECT:Create("effect", SymEff("EV_PAPERBLOW_VR_COMB"))
    EFFECT:SetScale("effect", Scale(2))
    EFFECT:SetPosition("effect", PosDotekkotsu)
    EFFECT:Play("effect")
    SOUND:WaitMe()
    ShopSys:Talk(1443574115, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    CH("DOKKORAA_1"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPEAK"), LOOP.ON)
    ShopSys:Talk(1326448674, FACE_TYPE.NORMAL)
    WINDOW:KeyWait()
    SOUND:PlayMe(SymSnd("ME_RANKUP"))
    ShopSys:SysMsg(1953190646)
    SOUND:WaitMe()
  end
  function EventPlay.eventSignboardFullOpen()
    SOUND:PlayMe(SymSnd("ME_MINIGAME_PERFECT"))
    ShopSys:SysMsg(-403603079)
    SOUND:WaitMe()
  end
  function EventPlay.eventSignboardShopCrushBefore_Fast()
    if TatefudaSys:IsNowJukeboxAllBreak() == true then
      SOUND:FadeOutBgm(TimeSec(0.5))
      FLAG.ParaMusicParadiseBrokeBGM = CONST.FLAG_TRUE
    else
      SOUND:VolumeBgm(Volume(64), TimeSec(0.8))
    end
    SCREEN_A:FadeOut(TimeSec(0.3), false)
    SCREEN_B:FadeOutAll(TimeSec(0.3), true)
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local SHOP_COUNTER = SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex))
    local SHOP_OWNER = TatefudaSys:GetNowLandShopOwnerSymbol()
    local POINT_DOTEKKOTSU = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0.1, 2.6))
    local POINT_DOKKORAA_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.6, 1.75))
    local POINT_DOKKORAA_2 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.6, 1.75))
    CAMERA:SetEye(SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 5, 10)))
    CAMERA:SetTgt(SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 2)))
    CH("DOTEKKOTSU"):SetPosition(POINT_DOTEKKOTSU)
    CH("DOKKORAA_1"):SetPosition(POINT_DOKKORAA_1)
    CH("DOKKORAA_2"):SetPosition(POINT_DOKKORAA_2)
    CH("DOTEKKOTSU"):SetDir(POINT_CENTER)
    CH("DOKKORAA_1"):SetDir(CH("DOTEKKOTSU"))
    CH("DOKKORAA_2"):SetDir(CH("DOTEKKOTSU"))
    CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
    CH("PARTY1"):SetDir(CH("DOTEKKOTSU"))
    CH("PARTY0"):SetVisible(false)
    CH("PARTY1"):SetVisible(false)
    if CHARA:IsExist(SHOP_OWNER) then
      CH(SHOP_OWNER):SetVisible(false)
    end
    SCREEN_A:FadeIn(TimeSec(0.5), true)
    TASK:Sleep(TimeSec(0.3))
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOTEKKOTSU"):WaitPlayMotion()
    CH("DOTEKKOTSU"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOTEKKOTSU"), -2123150960)
    WINDOW:CloseMessage()
    CH("DOKKORAA_1"):SetNeckRot(RotateTarget(0), RotateTarget(-30), RotateTarget(0), TimeSec(0.15))
    CH("DOKKORAA_2"):SetNeckRot(RotateTarget(0), RotateTarget(-30), RotateTarget(0), TimeSec(0.15))
    CH("DOKKORAA_2"):WaitNeckRot()
    CH("DOKKORAA_1"):ResetNeckRot(TimeSec(0.2))
    CH("DOKKORAA_2"):ResetNeckRot(TimeSec(0.2))
    CH("DOKKORAA_2"):WaitNeckRot()
    TASK:Sleep(TimeSec(0.3))
    WINDOW:DrawFace(324, 88, SymAct("DOKKORAA_1"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOKKORAA_1"), -756501293)
    WINDOW:CloseMessage()
    CH("DOKKORAA_1"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("DOKKORAA_2"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("PARTY0"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("PARTY1"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("DOKKORAA_2"):WaitRotate()
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOKKORAA_1"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOKKORAA_2"):WaitPlayMotion()
    CH("DOTEKKOTSU"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_1"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOTEKKOTSU"):SetMotion(SymMot("ATTACK"), LOOP.ON)
    CH("DOKKORAA_1"):SetMotion(SymMot("ATTACK_ROUND"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("ATTACK_ROUND"), LOOP.ON)
    SOUND:PlaySe(SymSnd("SE_SHOP_DESTROY"))
  end
  function EventPlay.eventSignboardShopCrushBefore()
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local SHOP_COUNTER = SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex))
    local SHOP_OWNER = TatefudaSys:GetNowLandShopOwnerSymbol()
    local POINT_DOTEKKOTSU = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0.1, 2.6))
    local POINT_DOKKORAA_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.6, 1.75))
    local POINT_DOKKORAA_2 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.6, 1.75))
    EFFECT:Create("effectsmoke", SymEff("EV_SMOKE_POP_BROWN"))
    EFFECT:SetScale("effectsmoke", Scale(6))
    EFFECT:SetPosition("effectsmoke", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex)))
    EFFECT:Play("effectsmoke")
    EFFECT:Create("effectstar01", SymEff("NM_STARBOMB_YELLOW"))
    EFFECT:SetScale("effectstar01", Scale(1.5))
    EFFECT:SetPosition("effectstar01", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.2, 0.5)))
    EFFECT:Play("effectstar01")
    CAMERA:MoveFollow(POINT_CENTER, Speed(0.6, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
    TASK:Sleep(TimeSec(0.5), TASK_EXIT.QUICK)
    EFFECT:Create("effectstar02", SymEff("NM_STARBOMB_YELLOW"))
    EFFECT:SetScale("effectstar02", Scale(1.5))
    EFFECT:SetPosition("effectstar02", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.2, 0.5)))
    EFFECT:Play("effectstar02")
    TASK:Sleep(TimeSec(0.2))
    EFFECT:Create("effectstar03", SymEff("NM_STARBOMB_YELLOW"))
    EFFECT:SetScale("effectstar03", Scale(2))
    EFFECT:SetPosition("effectstar03", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 1.2)))
    EFFECT:Play("effectstar03")
    TASK:Sleep(TimeSec(0.3), TASK_EXIT.QUICK)
    EFFECT:Create("effectsmoke", SymEff("EV_SMOKE_POP_BROWN"))
    EFFECT:SetScale("effectsmoke", Scale(8))
    EFFECT:SetPosition("effectsmoke", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex)))
    EFFECT:Play("effectsmoke")
    TASK:Sleep(TimeSec(0.2))
    EFFECT:Create("effectstar04", SymEff("NM_STARBOMB_YELLOW"))
    EFFECT:SetScale("effectstar04", Scale(1.5))
    EFFECT:SetPosition("effectstar04", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.2, 0.5)))
    EFFECT:Play("effectstar04")
    TASK:Sleep(TimeSec(0.3), TASK_EXIT.QUICK)
    EFFECT:Create("effectstar05", SymEff("NM_STARBOMB_YELLOW"))
    EFFECT:SetScale("effectstar05", Scale(1.5))
    EFFECT:SetPosition("effectstar05", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.2, 0.5)))
    EFFECT:Play("effectstar05")
    TASK:Sleep(TimeSec(0.2))
    EFFECT:Create("effectstar06", SymEff("NM_STARBOMB_YELLOW"))
    EFFECT:SetScale("effectstar06", Scale(2))
    EFFECT:SetPosition("effectstar06", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 1.2)))
    EFFECT:Play("effectstar06")
    EFFECT:Create("effectsmoke", SymEff("EV_SMOKE_BROWN"))
    EFFECT:SetScale("effectsmoke", Scale(9))
    EFFECT:SetPosition("effectsmoke", POINT_CENTER)
    EFFECT:Play("effectsmoke")
  end
  function EventPlay.eventSignboardShopCrushBefore_End()
    CHARA:DynamicRemove("DOTEKKOTSU")
    CHARA:DynamicRemove("DOKKORAA_1")
    CHARA:DynamicRemove("DOKKORAA_2")
  end
  function EventPlay.eventSignboardShopCrushAfter(brokenShopName)
    CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
    CH("PARTY1"):SetDir(CH("DOTEKKOTSU"))
    CH("PARTY0"):SetVisible(true)
    CH("PARTY1"):SetVisible(true)
    CHARA:DynamicRemoveLandNpc()
    if CHARA:IsExist("DIG_SHOP_OWNER") then
      CH("DIG_SHOP_OWNER"):SetVisible(false)
    end
    if CHARA:IsExist("MEROETTA_VOICE") then
      CH("MEROETTA_VOICE"):SetVisible(false)
      CH("MEROETTA_STEP"):SetVisible(false)
    end
    CAMERA:SetEye(SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex), PosOffs(0, 4, 9)))
    CAMERA:SetTgt(SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex)))
    SOUND:StopSe(SymSnd("SE_SHOP_DESTROY"))
    if FLAG.ParaMusicParadiseBrokeBGM == CONST.FLAG_TRUE then
      FLAG.ParaMusicParadiseBrokeBGM = CONST.FLAG_FALSE
      subMapBgmParadise()
    else
      SOUND:VolumeBgm(Volume(256), TimeSec(0.8))
    end
    SCREEN_A:FadeIn(TimeSec(0.5), false)
    SCREEN_B:FadeInAll(TimeSec(0.5), true)
    ShopSys:SetShopTag("\229\187\186\232\168\173\227\129\149\227\130\140\227\129\166\227\129\132\227\130\139\230\150\189\232\168\173", brokenShopName)
    WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOTEKKOTSU"), 1414610949)
    WINDOW:CloseMessage()
  end
  function EventPlay.eventSignboardShopColorChangeBefort_Fast()
    SCREEN_A:FadeOut(TimeSec(0.3), false)
    SCREEN_B:FadeOutAll(TimeSec(0.3), true)
    SOUND:VolumeBgm(Volume(64), TimeSec(0.8))
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local SHOP_COUNTER = SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex))
    local SHOP_OWNER = TatefudaSys:GetNowLandShopOwnerSymbol()
    local POINT_DOTEKKOTSU = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0.1, 2.6))
    local POINT_DOKKORAA_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.6, 1.75))
    local POINT_DOKKORAA_2 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.6, 1.75))
    CAMERA:SetEye(SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 5, 10)))
    CAMERA:SetTgt(SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 2)))
    CH("DOTEKKOTSU"):SetPosition(POINT_DOTEKKOTSU)
    CH("DOKKORAA_1"):SetPosition(POINT_DOKKORAA_1)
    CH("DOKKORAA_2"):SetPosition(POINT_DOKKORAA_2)
    CH("DOTEKKOTSU"):SetDir(POINT_CENTER)
    CH("DOKKORAA_1"):SetDir(CH("DOTEKKOTSU"))
    CH("DOKKORAA_2"):SetDir(CH("DOTEKKOTSU"))
    CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
    CH("PARTY1"):SetDir(CH("DOTEKKOTSU"))
    CH("PARTY0"):SetVisible(false)
    CH("PARTY1"):SetVisible(false)
    if CHARA:IsExist(SHOP_OWNER) then
      CH(SHOP_OWNER):SetVisible(false)
    end
    SCREEN_A:FadeIn(TimeSec(0.5), true)
    TASK:Sleep(TimeSec(0.3))
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOTEKKOTSU"):WaitPlayMotion()
    CH("DOTEKKOTSU"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOTEKKOTSU"), -1454171709)
    WINDOW:CloseMessage()
    subEveJump(CH("DOKKORAA_1"))
    subEveJump(CH("DOKKORAA_2"))
    WINDOW:DrawFace(324, 88, SymAct("DOKKORAA_1"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOKKORAA_1"), 672514960)
    WINDOW:CloseMessage()
    CH("DOKKORAA_1"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("DOKKORAA_2"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("PARTY0"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("PARTY1"):DirTo(POINT_CENTER, Speed(350), ROT_TYPE.NEAR)
    CH("DOKKORAA_2"):WaitRotate()
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOKKORAA_1"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("SPECIAL"), LOOP.OFF)
    CH("DOKKORAA_2"):WaitPlayMotion()
    CH("DOTEKKOTSU"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_1"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_1"):SetMotion(SymMot("VICTORY"), LOOP.ON)
    SOUND:PlaySe(SymSnd("SE_SHOP_PAINT"))
  end
  function EventPlay.eventSignboardShopColorChangeBefort()
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local SHOP_COUNTER = SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex))
    local SHOP_OWNER = TatefudaSys:GetNowLandShopOwnerSymbol()
    local POINT_DOTEKKOTSU = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0.1, 2.6))
    local POINT_DOKKORAA_1 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.6, 1.75))
    local POINT_DOKKORAA_2 = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.6, 1.75))
    EFFECT:Create("effectup01", SymEff("NM_WATER_VR_GREEN"))
    EFFECT:SetScale("effectup01", Scale(1.5))
    EFFECT:SetPosition("effectup01", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.2, 0.5)))
    EFFECT:Play("effectup01")
    CAMERA:MoveFollow(POINT_CENTER, Speed(0.6, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
    TASK:Sleep(TimeSec(0.5))
    CH("DOKKORAA_2"):SetMotion(SymMot("VICTORY"), LOOP.ON)
    EFFECT:Create("effectup02", SymEff("NM_WATER_BLUE"))
    EFFECT:SetScale("effectup02", Scale(1.5))
    EFFECT:SetPosition("effectup02", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.2, 0.5)))
    EFFECT:Play("effectup02")
    TASK:Sleep(TimeSec(0.2), TASK_EXIT.QUICK)
    CH("DOTEKKOTSU"):SetMotion(SymMot("VICTORY"), LOOP.ON)
    EFFECT:Create("effectup03", SymEff("NM_WATER_VR_RED"))
    EFFECT:SetScale("effectup03", Scale(2))
    EFFECT:SetPosition("effectup03", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 1.2)))
    EFFECT:Play("effectup03")
    TASK:Sleep(TimeSec(0.5))
    EFFECT:Create("effectup04", SymEff("NM_WATER_VR_GREEN"))
    EFFECT:SetScale("effectup04", Scale(1.5))
    EFFECT:SetPosition("effectup04", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(1.2, 0.5)))
    EFFECT:Play("effectup04")
    TASK:Sleep(TimeSec(0.5), TASK_EXIT.QUICK)
    EFFECT:Create("effectup05", SymEff("NM_WATER_BLUE"))
    EFFECT:SetScale("effectup05", Scale(1.5))
    EFFECT:SetPosition("effectup05", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(-1.2, 0.5)))
    EFFECT:Play("effectup05")
    TASK:Sleep(TimeSec(0.2))
    EFFECT:Create("effectup06", SymEff("NM_WATER_VR_RED"))
    EFFECT:SetScale("effectup06", Scale(2))
    EFFECT:SetPosition("effectup06", SymPos(string.format("@SHOP_CENTER%02d", spaceIndex), PosOffs(0, 1.2)))
    EFFECT:Play("effectup06")
  end
  function EventPlay.eventSignboardShopColorChangeBefort_End()
    CHARA:DynamicRemove("DOTEKKOTSU")
    CHARA:DynamicRemove("DOKKORAA_1")
    CHARA:DynamicRemove("DOKKORAA_2")
  end
  function EventPlay.eventSignboardShopColorChangeAfter(selectColorChangeId)
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local SHOP_COUNTER = SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex))
    local POINT_DOTEKKOTSU = SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex))
    local SHOP_OWNER = TatefudaSys:GetNowLandShopOwnerSymbol()
    CHARA:DynamicRemoveLandNpc()
    if CHARA:IsExist("DIG_SHOP_OWNER") then
      CH("DIG_SHOP_OWNER"):SetVisible(false)
    end
    if CHARA:IsExist("MEROETTA_VOICE") then
      CH("MEROETTA_VOICE"):SetVisible(false)
      CH("MEROETTA_STEP"):SetVisible(false)
    end
    CH("DOTEKKOTSU"):SetDir(POINT_CENTER)
    CH("DOKKORAA_1"):SetDir(POINT_CENTER)
    CH("DOKKORAA_2"):SetDir(POINT_CENTER)
    CH("PARTY0"):SetDir(POINT_CENTER)
    CH("PARTY1"):SetDir(POINT_CENTER)
    CH("PARTY0"):SetVisible(true)
    CH("PARTY1"):SetVisible(true)
    if CHARA:IsExist(SHOP_OWNER) then
      CH(SHOP_OWNER):SetVisible(false)
    end
    CAMERA:SetEye(SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex), PosOffs(0, 5, 10)))
    CAMERA:SetTgt(SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex)))
    SOUND:StopSe(SymSnd("SE_SHOP_PAINT"))
    CH("DOTEKKOTSU"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.1))
    CH("DOKKORAA_1"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    CH("DOKKORAA_2"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    SCREEN_A:WhiteInAll(TimeSec(0.5), true)
    SOUND:PlayMe(SymSnd("ME_MINIGAME_SOSO"))
    SOUND:WaitMe()
    CH("DOTEKKOTSU"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_1"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CH("DOKKORAA_2"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    SOUND:VolumeBgm(Volume(256), TimeSec(0.8))
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\232\137\178", GetLandShopNameTextIdForTitle(selectColorChangeId))
    WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOTEKKOTSU"), 1230435853)
    WINDOW:CloseMessage()
    if CHARA:IsExist(SHOP_OWNER) then
      SOUND:PlaySe(SymSnd("SE_EVT_BUNI"))
      EFFECT:Create("effectsmoke", SymEff("NM_SMOKE_SHORT_WHITE"))
      EFFECT:SetScale("effectsmoke", Scale(1))
      EFFECT:SetPosition("effectsmoke", SHOP_COUNTER)
      EFFECT:Play("effectsmoke")
      TASK:Sleep(TimeSec(0.3))
      CH(SHOP_OWNER):SetVisible(true)
      TASK:Sleep(TimeSec(0.8))
      subEveNodDouble(CH(SHOP_OWNER))
      WINDOW:DrawFace(20, 88, SymAct(SHOP_OWNER), FACE_TYPE.NORMAL)
      WINDOW:Talk(SymAct(SHOP_OWNER), 579748405)
      WINDOW:CloseMessage()
      CAMERA:MoveFollow(POINT_DOTEKKOTSU, Speed(3.5, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
      subEveNod(CH("PARTY0"))
    else
      CAMERA:MoveFollow(POINT_DOTEKKOTSU, Speed(3.5, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
    end
    CH("DOTEKKOTSU"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    CH("DOKKORAA_1"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    TASK:Sleep(TimeSec(0.1))
    CH("DOKKORAA_2"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    CH("PARTY0"):DirTo(CH("DOTEKKOTSU"), Speed(500), ROT_TYPE.NEAR)
    CH("PARTY1"):DirTo(CH("DOTEKKOTSU"), Speed(500), ROT_TYPE.NEAR)
    CAMERA:WaitMove()
    SCREEN_B:FadeInAll(TimeSec(0.5), true)
  end
  function EventPlay.eventSignboardShoperChangeBefore()
    local SHOP_COUNTER = SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex))
    local SHOP_OWNER = TatefudaSys:GetNowLandShopOwnerSymbol()
    local CAM_POINT = SymPos(string.format("@CAM_POINT%02d", spaceIndex))
    CH("DOTEKKOTSU"):DirTo(SHOP_COUNTER, Speed(500), ROT_TYPE.NEAR)
    CH("DOKKORAA_1"):DirTo(SHOP_COUNTER, Speed(500), ROT_TYPE.NEAR)
    TASK:Sleep(TimeSec(0.1))
    CH("DOKKORAA_2"):DirTo(SHOP_COUNTER, Speed(500), ROT_TYPE.NEAR)
    CH("PARTY0"):DirTo(SHOP_COUNTER, Speed(500), ROT_TYPE.NEAR)
    CH("PARTY1"):DirTo(SHOP_COUNTER, Speed(500), ROT_TYPE.NEAR)
    CAMERA:MoveFollow(CAM_POINT, Speed(3, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
    CAMERA:WaitMove()
    TASK:Sleep(TimeSec(0.3))
    subEveDoubleJump(CH(SHOP_OWNER))
    WINDOW:DrawFace(20, 88, SymAct(SHOP_OWNER), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct(SHOP_OWNER), 1422360082)
    WINDOW:CloseMessage()
    subEveNod(CH("DOTEKKOTSU"))
    WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOTEKKOTSU"), 1049066354)
    WINDOW:CloseMessage()
    SOUND:VolumeBgm(Volume(64), TimeSec(0.8))
    SCREEN_A:FadeOut(TimeSec(0.5), false)
    SCREEN_B:FadeOutAll(TimeSec(0.5), true)
    CHARA:DynamicRemove("DOTEKKOTSU")
    CHARA:DynamicRemove("DOKKORAA_1")
    CHARA:DynamicRemove("DOKKORAA_2")
  end
  function EventPlay.eventSignboardShoperChangeAfter()
    local SHOP_COUNTER = SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex))
    local SHOP_OWNER = TatefudaSys:GetNowLandShopOwnerSymbol()
    local POINT_DOTEKKOTSU = SymPos(string.format("@DOTEKKOTSU_POINT%02d", spaceIndex))
    local CAM_POINT = SymPos(string.format("@CAM_POINT%02d", spaceIndex))
    CHARA:DynamicRemoveLandNpc()
    if CHARA:IsExist("DIG_SHOP_OWNER") then
      CH("DIG_SHOP_OWNER"):SetVisible(false)
    end
    if CHARA:IsExist("MEROETTA_VOICE") then
      CH("MEROETTA_VOICE"):SetVisible(false)
      CH("MEROETTA_STEP"):SetVisible(false)
    end
    CH("DOTEKKOTSU"):SetDir(SHOP_COUNTER)
    CH("DOKKORAA_1"):SetDir(SHOP_COUNTER)
    CH("DOKKORAA_2"):SetDir(SHOP_COUNTER)
    CH("PARTY0"):SetDir(SHOP_COUNTER)
    CH("PARTY1"):SetDir(SHOP_COUNTER)
    CH(SHOP_OWNER):SetVisible(false)
    CAMERA:SetEye(SymPos(string.format("@SHOP_COUNTER%02d", spaceIndex), PosOffs(0, 4, 9)))
    CAMERA:SetTgt(CAM_POINT)
    SCREEN_A:FadeIn(TimeSec(0.5), false)
    SCREEN_B:FadeInAll(TimeSec(0.5), true)
    TASK:Sleep(TimeSec(0.3))
    SOUND:PlaySe(SymSnd("SE_EVT_BUNI"))
    EFFECT:Create("effectsmoke", SymEff("NM_SMOKE_SHORT_WHITE"))
    EFFECT:SetScale("effectsmoke", Scale(1))
    EFFECT:SetPosition("effectsmoke", SHOP_COUNTER)
    EFFECT:Play("effectsmoke")
    TASK:Sleep(TimeSec(0.3))
    CH(SHOP_OWNER):SetVisible(true)
    TASK:Sleep(TimeSec(0.5))
    CH(SHOP_OWNER):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    CH(SHOP_OWNER):WaitPlayMotion()
    CH(SHOP_OWNER):SetMotion(SymMot("WAIT02"), LOOP.ON)
    SOUND:VolumeBgm(Volume(256), TimeSec(0.8))
    WINDOW:DrawFace(20, 88, SymAct(SHOP_OWNER), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct(SHOP_OWNER), 105699285)
    WINDOW:CloseMessage()
    CH("DOTEKKOTSU"):SetMotion(SymMot("SPEAK"), LOOP.ON)
    WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOTEKKOTSU"), -1844736691)
    WINDOW:CloseMessage()
    CH("DOTEKKOTSU"):SetMotion(SymMot("WAIT02"), LOOP.ON)
    CAMERA:MoveFollow(POINT_DOTEKKOTSU, Speed(3, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
    CH("DOTEKKOTSU"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    CH("DOKKORAA_1"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    TASK:Sleep(TimeSec(0.1))
    CH("DOKKORAA_2"):DirTo(RotateTarget(0), Speed(500), ROT_TYPE.NEAR)
    CH("PARTY0"):DirTo(CH("DOTEKKOTSU"), Speed(500), ROT_TYPE.NEAR)
    CH("PARTY1"):DirTo(CH("DOTEKKOTSU"), Speed(500), ROT_TYPE.NEAR)
    WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
    WINDOW:Talk(SymAct("DOTEKKOTSU"), -1188634994)
    WINDOW:CloseMessage()
    CAMERA:WaitMove()
  end
  function EventPlay.eventSignboardGoodbye(defeat)
    local RESTART_PLAYER = SymPos(string.format("@RESTART_PLAYER%02d", spaceIndex))
    local RESTART_PARTNER = SymPos(string.format("@RESTART_PARTNER%02d", spaceIndex))
    local KANBAN_POINT = SymPos(string.format("@KANBAN_POINT%02d", spaceIndex))
    WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.SPECIAL04)
    if defeat then
      WINDOW:Talk(SymAct("DOTEKKOTSU"), 688507363)
    else
      WINDOW:Talk(SymAct("DOTEKKOTSU"), 1070622953)
    end
    WINDOW:CloseMessage()
    SCREEN_A:FadeOutAll(TimeSec(0.5), false)
    SCREEN_B:FadeOutAll(TimeSec(0.5), true)
    SYSTEM:FreeMoveScriptEventStartAll()
    if FLAG.ParaMode == CONST.PARA_MODE_PARADISE or FLAG.StoryPlayerMode == CONST.ST_MODE_PARTNER or FLAG.StoryPlayerMode == CONST.ST_MODE_HERO then
      CH("PARTY0"):SetPosition(RESTART_PLAYER)
      CH("PARTY0"):SetDir(KANBAN_POINT)
    else
      CH("PARTY0"):SetPosition(RESTART_PLAYER)
      CH("PARTY1"):SetPosition(RESTART_PARTNER)
      CH("PARTY0"):SetDir(KANBAN_POINT)
      CH("PARTY1"):SetDir(KANBAN_POINT)
    end
    CAMERA:ResetPlayerFreeMoveCameraOffset()
    CAMERA:MoveToPlayer(TimeSec(0), ACCEL_TYPE.NONE, DECEL_TYPE.NONE)
    CHARA:DynamicLoadLandNpc()
    if CHARA:IsExist("DIG_SHOP_OWNER") then
      CH("DIG_SHOP_OWNER"):SetVisible(true)
    end
    if CHARA:IsExist("MEROETTA_VOICE") then
      CH("MEROETTA_VOICE"):SetVisible(true)
      CH("MEROETTA_STEP"):SetVisible(false)
    end
    CHARA:DynamicRemove("DOTEKKOTSU")
    CHARA:DynamicRemove("DOKKORAA_1")
    CHARA:DynamicRemove("DOKKORAA_2")
    LOWER_SCREEN:SetVisible(true)
    LOWER_SCREEN:ChangeLastWallpaper()
    TASK:Sleep(TimeSec(0.15))
    SCREEN_A:FadeInAll(TimeSec(0.3), false)
    SCREEN_B:FadeInAll(TimeSec(0.3), true)
  end
  if resumeNextFlow then
    FlowSys.Stat.resumeNextFlow = resumeNextFlow
    FlowSys.Stat.resumeArgTbl = resumeArgTbl
    FlowSys:Call("tatehudaMenuTopResume")
  else
    FlowSys:Call("tatehudaMenuStart")
  end
  FlowSys:Finish()
  ShopSys:Finish()
end
function dispExtendLookMenu(padHelpText, nowShopId, nextShopLevel, selectedAction, cancelAction)
  local spriteAutoLoadTbl = {
    notice_PARA_SHOP_COUNTER = {
      img = "NOTICE_INST01",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_HOUSE_1 = {
      img = "NOTICE_INST02",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_HOUSE_2 = {
      img = "NOTICE_INST03",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_DOOM_1 = {
      img = "NOTICE_INST04",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_DOOM_2 = {
      img = "NOTICE_INST05",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_TENT_1 = {
      img = "NOTICE_INST06",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_TENT_2 = {
      img = "NOTICE_INST07",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_HORIATE = {
      img = "NOTICE_INST08",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_WAZA_TRAINING = {
      img = "NOTICE_INST09",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_MUSIC = {
      img = "NOTICE_INST10",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_FARM_1 = {
      img = "NOTICE_INST11",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_FARM_2 = {
      img = "NOTICE_INST12",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_DIVER = {
      img = "NOTICE_INST13",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_SALVAGE = {
      img = "NOTICE_INST14",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    notice_PARA_SHOP_TAMAIRE = {
      img = "NOTICE_INST15",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    }
  }
  local titleTextTbl = {}
  local spritePtnTbl = {}
  local explainTextTbl = {}
  titleTextTbl[nowShopId] = GetLandShopNameTextIdForTitle(nowShopId)
  spritePtnTbl[nowShopId] = "notice_" .. GROUND:GetLandShopGraphicLabel(nowShopId, nextShopLevel)
  explainTextTbl[nowShopId] = GetLandShopExplainTextIdForDesc(nowShopId, nextShopLevel)
  local upperMaterialMenu = ShopSys:OpenUpperMaterialMenu({
    enumMaterialFunc = function(landShopId)
      return coroutine.wrap(function()
        for idx = 1, GROUND:GetDevelopLandShopMaterialCount(landShopId, nextShopLevel) do
          coroutine.yield({
            itemIndex = GROUND:GetDevelopLandShopMaterialItemIndex(landShopId, nextShopLevel, idx - 1),
            neecCount = GROUND:GetDevelopLandShopMaterialNeedCount(landShopId, nextShopLevel, idx - 1),
            hasCount = GROUND:GetDevelopLandShopMaterialHasCount(landShopId, nextShopLevel, idx - 1)
          })
        end
      end)
    end,
    getPriceFunc = function(landShopId)
      return GROUND:GetDevelopLandShopPrice(landShopId, nextShopLevel)
    end,
    spritePtnSetName = nil,
    titleTextTbl = titleTextTbl,
    spritePtnTbl = spritePtnTbl,
    explainTextTbl = explainTextTbl,
    spriteAutoLoadTbl = spriteAutoLoadTbl
  })
  local dummyBoardMenu = MENU:CreateBoardMenuWindow(ScreenType.B)
  dummyBoardMenu:SetLayoutRect(Rectangle(-10, -10, 1, 1))
  local padHelpInfoMenu
  function dummyBoardMenu:openedAction()
    self:SetVisible(false)
    upperMaterialMenu:UpdateInfo(nowShopId)
    padHelpInfoMenu = CommonSys:OpenPadHelpInfoMenuWindow(padHelpText)
  end
  function dummyBoardMenu:decideAction()
    self:Close()
  end
  function dummyBoardMenu:inputLSelectAction()
    upperMaterialMenu:SwitchInfo(-1)
  end
  function dummyBoardMenu:inputRSelectAction()
    upperMaterialMenu:SwitchInfo(1)
  end
  function dummyBoardMenu:cancelAction()
  end
  function dummyBoardMenu:closedAction()
    upperMaterialMenu:Close()
    padHelpInfoMenu:Close()
  end
  CommonSys:OpenAndCloseWait(dummyBoardMenu)
end
function dispShopStaffSelectMenu(titleText, padHelpText, landIndex, spaceIndex, selectedAction, cancelAction)
  local shopListMenu = MENU:CreatePageMenu()
  shopListMenu:SetLayoutRectAndLines(16, 40, 168, 9)
  shopListMenu:ShowPageNum(true)
  for idx = 0, GROUND:GetChangeStaffCount(landIndex, spaceIndex) - 1 do
    shopListMenu:AddItem(GROUND:GetChangeStaffPokemonName(landIndex, spaceIndex, idx), idx, nil)
  end
  function shopListMenu:itemPreOpenModifyAction()
    local ownerSymbol = GROUND:GetLandShopInstance(landIndex, spaceIndex):GetOwnerSymbol()
    if GROUND:GetChangeStaffPokemonIndex(landIndex, spaceIndex, self.curItem.obj) == CH(ownerSymbol):GetPokemonIndex() then
      self.curItem.grayed = true
    end
  end
  function shopListMenu:openedAction()
    SCREEN_B:LoadWallpaper("WALLPAPER_SUB_NOTICE01")
    SCREEN_B:SetVisibleWallpaper(true)
    CommonSys:OpenBasicMenu(titleText, padHelpText, nil)
  end
  function shopListMenu:currentItemChange()
  end
  function shopListMenu:decideAction()
    selectedAction(self.curItem.obj)
    self:Close()
  end
  function shopListMenu:cancelAction()
    cancelAction()
    self:Close()
  end
  function shopListMenu:closedAction()
    CommonSys:CloseBasicMenu()
  end
  CommonSys:OpenAndCloseWait(shopListMenu)
end
function dispColorSelectMenu(titleText, padHelpText, nowShopId, nowShopLevel, selectedAction, cancelAction)
  local graphicLabel = GROUND:GetLandShopGraphicLabel(nowShopId, nowShopLevel)
  local colorChangeType
  if graphicLabel == "PARA_SHOP_FARM_1" or graphicLabel == "PARA_SHOP_FARM_2" then
    colorChangeType = PARADISE_COLOR_CHANGE_TYPE.FARM
  else
    colorChangeType = PARADISE_COLOR_CHANGE_TYPE.SHOP
  end
  DispSelectColorMenu(colorChangeType, titleText, padHelpText, graphicLabel, selectedAction, cancelAction)
end
