dofile("script/paradise_next/shop_strings.lua")
function OpenCarpenterShopMenu()
  SCREEN_B:FadeOutAll(TimeSec(0.3), true)
  SCREEN_B:LoadWallpaper("WALLPAPER_SUB_OUTPOST_CYCLE")
  SCREEN_B:SetVisibleWallpaper(true)
  local CarpenterSys = {}
  local EventPlay = {}
  function CarpenterSys:CheckHomeExtensionOk()
    for v in GROUND:EnumerateColorChengeOkLabel(PARADISE_COLOR_CHANGE_TYPE.HOME_ROOF) do
      if GROUND:GetOpenLimitState_Menu(PARADISE_MENU_OPEN_TYPE.HOME_COLOR_CHANGE) == PARADISE_OPEN_LIMIT_STATE.CLOSE then
        GROUND:SetOpenLimitState_Menu(PARADISE_MENU_OPEN_TYPE.HOME_COLOR_CHANGE, PARADISE_OPEN_LIMIT_STATE.OPEN_NEW)
      end
      return true
    end
    return false
  end
  function CarpenterSys:GetLandTypeName(landType)
    if PARADISE_LAND_TYPE.WILDERNESS == landType then
      return ""
    end
    if PARADISE_LAND_TYPE.PRAIRIE == landType then
      return GetLandShopNameTextIdForTitle("reclamation_weed")
    end
    if PARADISE_LAND_TYPE.FOREST == landType then
      return GetLandShopNameTextIdForTitle("reclamation_wood")
    end
    if PARADISE_LAND_TYPE.ROCKY_HILL == landType then
      return GetLandShopNameTextIdForTitle("reclamation_rock")
    end
    if PARADISE_LAND_TYPE.WATER == landType then
      return GetLandShopNameTextIdForTitle("reclamation_water")
    end
    return "\227\129\170\227\129\158\227\129\174\227\130\191\227\130\164\227\131\151"
  end
  function CarpenterSys:IsBeforeFirstDevelopLand()
    return GROUND:GetParadiseLandType(PARADISE_LAND_INDEX.INDEX_04) == PARADISE_LAND_TYPE.WILDERNESS
  end
  function CarpenterSys:GetNeedNextLandOpenCount()
    return GROUND:GetNextBuildShopBonusNeedCount()
  end
  function CarpenterSys:GetNeedNextLandOpenCountText()
    MENU:SetTag_Value(0, CarpenterSys:GetNeedNextLandOpenCount())
    return MENU:ReplaceTagText("[value_p_s_b:0]")
  end
  MENU:LoadMenuTextPool("message/shop.bin", false)
  FlowSys:Start()
  ShopSys:Start()
  ShopSys:SetOwner("DOTEKKOTSU", "\227\131\137\227\131\134\227\131\131\227\130\179\227\131\132")
  function FlowSys.Proc.MenuTopFirst()
    if MULTI_PLAY:IsLogined() then
      SCREEN_B:FadeIn(TimeSec(0.3), false)
      SCREEN_B:FadeInAll(TimeSec(0.3), true)
      if MULTI_PLAY:IsMaster() then
        ShopSys:Talk(2081246028, FACE_TYPE.NORMAL)
        WINDOW:CloseMessage()
        FlowSys:Next("ExitShop")
        return
      else
        ShopSys:Talk(1994703330, FACE_TYPE.NORMAL)
        WINDOW:CloseMessage()
        FlowSys:Next("ExitShop")
        return
      end
    end
    SCREEN_B:FadeInAll(TimeSec(0.3), false)
    CarpenterSys:CheckHomeExtensionOk()
    local home_text = -1282441227
    if GROUND:GetOpenLimitState_Menu(PARADISE_MENU_OPEN_TYPE.HOME_COLOR_CHANGE) == PARADISE_OPEN_LIMIT_STATE.OPEN_NEW then
      home_text = "[M:NEW]" .. MENU:GetTextPoolText(home_text)
    end
    CommonSys:OpenBasicMenu(nil, -1733859855, nil)
    ShopSys:TalkAskFlowNoClose(866391857, FACE_TYPE.NORMAL, {cursorReset = true}, {next = "ExitTalk"}, {text = 1289954736, next = "TopParaMap"}, {
      text = home_text,
      next = "TopHomeExt",
      enableFunc = function()
        return CarpenterSys:CheckHomeExtensionOk()
      end
    }, {text = -1658987038, next = "Help"})
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.MenuTopLoopFade()
    SCREEN_B:LoadWallpaper("WALLPAPER_SUB_OUTPOST_CYCLE")
    SCREEN_B:SetVisibleWallpaper(true)
    SCREEN_A:FadeInAll(TimeSec(0.3), false)
    SCREEN_B:FadeInAll(TimeSec(0.3), false)
    FlowSys:Next("MenuTopLoop")
  end
  function FlowSys.Proc.MenuTopLoop()
    closeSelectMapMenu()
    local home_text = -1841793088
    if GROUND:GetOpenLimitState_Menu(PARADISE_MENU_OPEN_TYPE.HOME_COLOR_CHANGE) == PARADISE_OPEN_LIMIT_STATE.OPEN_NEW then
      home_text = "[M:NEW]" .. MENU:GetTextPoolText(home_text)
    end
    CommonSys:OpenBasicMenu(nil, -1733859855, nil)
    ShopSys:TalkAskFlowNoClose(2017561205, FACE_TYPE.NORMAL, {cursorReset = true}, {next = "ExitTalk"}, {text = 109124914, next = "TopParaMap"}, {
      text = home_text,
      next = "TopHomeExt",
      enableFunc = function()
        return CarpenterSys:CheckHomeExtensionOk()
      end
    }, {text = -1129654825, next = "Help"})
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.TopParaMap()
    ShopSys:Talk(671817041, FACE_TYPE.NORMAL)
    ShopSys:SaveCursorIndex("SelectMapMenu", nil)
    FlowSys:Next("mapLandSelectFade")
  end
  function FlowSys.Proc.mapLandSelectFade()
    WINDOW:CloseMessage()
    SCREEN_A:FadeOutAll(TimeSec(4, TIME_TYPE.FRAME), false)
    SCREEN_B:FadeOutAll(TimeSec(4, TIME_TYPE.FRAME), true)
    FlowSys:Next("mapLandSelect")
  end
  function FlowSys.Proc.mapLandSelect()
    WINDOW:CloseMessage()
    FlowSys.Stat.selectLandIndex = nil
    openAndDispSelectMapMenu("notyetHome", "notyetLand", function()
      SCREEN_A:FadeOutAll(TimeSec(4, TIME_TYPE.FRAME), false)
      SCREEN_B:FadeOutAll(TimeSec(4, TIME_TYPE.FRAME), true)
      FlowSys:Next("MenuTopLoopFade")
    end, function()
      FlowSys:Next("mapTypeSelect")
    end)
  end
  function FlowSys.Proc.notyetHome()
    ShopSys:Talk(-1122552753, FACE_TYPE.NORMAL)
    FlowSys:Next("mapLandSelect")
  end
  function FlowSys.Proc.notyetLand()
    if CarpenterSys:IsBeforeFirstDevelopLand() then
      WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
      WINDOW:Talk(SymAct("DOTEKKOTSU"), 957526521)
      WINDOW:CloseMessage()
    elseif CarpenterSys:GetNeedNextLandOpenCount() >= 4 then
      MENU:SetTag_String(0, CarpenterSys:GetNeedNextLandOpenCountText())
      WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
      WINDOW:Talk(SymAct("DOTEKKOTSU"), -1181332665)
      WINDOW:CloseMessage()
      TASK:Sleep(TimeSec(0.1))
      WINDOW:DrawFace(324, 88, SymAct("DOKKORAA_1"), FACE_TYPE.NORMAL)
      WINDOW:Talk(SymAct("DOKKORAA_1"), 2052161028)
      WINDOW:CloseMessage()
    else
      MENU:SetTag_String(0, CarpenterSys:GetNeedNextLandOpenCountText())
      WINDOW:DrawFace(20, 88, SymAct("DOTEKKOTSU"), FACE_TYPE.NORMAL)
      WINDOW:Talk(SymAct("DOTEKKOTSU"), 764044003)
      WINDOW:CloseMessage()
      TASK:Sleep(TimeSec(0.1))
      WINDOW:DrawFace(324, 88, SymAct("DOKKORAA_1"), FACE_TYPE.NORMAL)
      WINDOW:Talk(SymAct("DOKKORAA_1"), -225965159)
      WINDOW:CloseMessage()
    end
    FlowSys:Next("mapLandSelect")
  end
  function FlowSys.Proc.mapTypeSelect()
    ShopSys:SaveCursorIndex("LandTypeMenu", nil)
    ShopSys:Talk(-223667871, FACE_TYPE.NORMAL)
    FlowSys:Next("mapTypeSelectMenuFade")
  end
  function FlowSys.Proc.mapTypeSelectMenuFade()
    WINDOW:CloseMessage()
    SCREEN_A:FadeOutAll(TimeSec(4, TIME_TYPE.FRAME), false)
    SCREEN_B:FadeOutAll(TimeSec(4, TIME_TYPE.FRAME), true)
    FlowSys:Next("mapTypeSelectMenu")
  end
  function FlowSys.Proc.mapTypeSelectMenu()
    WINDOW:CloseMessage()
    closeSelectMapMenu()
    DispSelectLandTypeMenu(-147838255, -1579917380, function(selectType)
      SCREEN_A:FadeOutAll(TimeSec(0.3), false)
      SCREEN_B:FadeOutAll(TimeSec(0.3), true)
      FlowSys.Stat.selectLandType = selectType
      if GROUND:GetParadiseLandType(FlowSys.Stat.selectLandIndex) == FlowSys.Stat.selectLandType then
        FlowSys:Next("sameLandTypeSelect")
      else
        FlowSys:Next("askPay")
      end
    end, function()
      SCREEN_A:FadeOutAll(TimeSec(4, TIME_TYPE.FRAME), false)
      SCREEN_B:FadeOutAll(TimeSec(4, TIME_TYPE.FRAME), true)
      enableSelectMapMenu()
      FlowSys:Next("mapLandSelect")
    end, true)
  end
  function FlowSys.Proc.askPay()
    SCREEN_A:FadeInAll(TimeSec(0.3), false)
    SCREEN_B:FadeInAll(TimeSec(0.3), true)
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\229\177\158\230\128\167", CarpenterSys:GetLandTypeName(FlowSys.Stat.selectLandType))
    ShopSys:TalkAskFlowNoClose(-1634968493, FACE_TYPE.NORMAL, nil, {
      next = "mapTypeSelectMenuFade"
    }, {text = -949879920, next = "buildLand"}, {
      text = 1741398959,
      next = "mapTypeSelectMenuFade"
    })
  end
  function FlowSys.Proc.sameLandTypeSelect()
    SCREEN_A:FadeInAll(TimeSec(0.3), false)
    SCREEN_B:FadeInAll(TimeSec(0.3), true)
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\229\177\158\230\128\167", CarpenterSys:GetLandTypeName(FlowSys.Stat.selectLandType))
    ShopSys:Talk(589415762, FACE_TYPE.NORMAL)
    FlowSys:Next("MenuTopLoop")
  end
  function FlowSys.Proc.buildLand()
    if GROUND:IsLandDevelopMaterialOk(FlowSys.Stat.selectLandType) == false then
      ShopSys:Talk(-1143365963, FACE_TYPE.NORMAL)
      FlowSys:Next("DefeatExit")
      return
    end
    if GROUND:IsLandDevelopMoneyOk(FlowSys.Stat.selectLandType) == false then
      ShopSys:Talk(-936148333, FACE_TYPE.NORMAL)
      FlowSys:Next("DefeatExit")
      return
    end
    EventPlay.eventShopCarpenterCultivation()
    GROUND:PaymentDevelopParadiseLand(FlowSys.Stat.selectLandType)
    GROUND:DevelopParadiseLand(FlowSys.Stat.selectLandIndex, FlowSys.Stat.selectLandType)
    setLandTypeMenuOpened(FlowSys.Stat.selectLandType)
    if GROUND:CheckDevelopLandBonusLv() >= 0 then
      FlowSys:Next("DevelopLandBonus")
      return
    end
    FlowSys:Next("MenuTopLoop")
  end
  function FlowSys.Proc.DevelopLandBonus()
    local bonusLv = GROUND:CheckDevelopLandBonusLv()
    if bonusLv == 0 then
      ShopSys:Talk(-765123938, FACE_TYPE.NORMAL)
    else
      ShopSys:Talk(-606180074, FACE_TYPE.NORMAL)
    end
    WINDOW:KeyWait()
    for idx = 0, GROUND:GetDevelopBonusItem_Count(bonusLv) - 1 do
      SOUND:PlayMe(SymSnd("ME_REWARD"))
      OverFlow:AddOverflowCheckItem(GROUND:GetDevelopBonusItem_ItemIndex(bonusLv, idx), GROUND:GetDevelopBonusItem_ItemCount(bonusLv, idx), true)
      SOUND:WaitMe()
      WINDOW:KeyWait()
    end
    OverFlow:OpenOrderOverflowMenu(true)
    if 0 < GROUND:GetDevelopBonus_AddWarehouseCount(bonusLv) then
      MENU:SetTag_Value(0, GROUND:GetDevelopBonus_AddWarehouseCount(bonusLv))
      ShopSys:SetShopTag("\228\187\178\233\150\147\230\156\128\229\164\167\230\149\176", MENU:ReplaceTagText("[value_b:0]"))
      SOUND:PlayMe(SymSnd("ME_ITEM_IMPORTANT"))
      ShopSys:SysMsg(1837816020)
      SOUND:WaitMe()
    end
    GROUND:SetOpenedDevelopLandBonusLv(bonusLv)
    FlowSys:Next("ActionExit")
  end
  function FlowSys.Proc.Help()
    ShopSys:Talk(-887928236, FACE_TYPE.NORMAL)
    WINDOW:CloseMessage()
    FlowSys:Next("MenuTopLoop")
  end
  function FlowSys.Proc.TopHomeExt()
    CommonSys:OpenBasicMenu(nil, 1331611147, nil)
    ShopSys:TalkAskFlowNoClose(2114071657, FACE_TYPE.NORMAL, nil, {
      next = "MenuTopLoop"
    }, {
      text = -1870025889,
      next = "",
      obj = PARADISE_COLOR_CHANGE_TYPE.HOME_ROOF
    }, {
      text = 1595664149,
      next = "",
      obj = PARADISE_COLOR_CHANGE_TYPE.HOME_WINDOW
    })
    CommonSys:CloseBasicMenu()
    if FlowSys:CheckNext() then
      return
    end
    FlowSys.Stat.selectColorChangeType = ShopSys:GetLastAskSelectObj()
    FlowSys:Next("colorSelect")
  end
  function FlowSys.Proc.colorSelect()
    ShopSys:Talk(-1755424609, FACE_TYPE.NORMAL)
    WINDOW:CloseMessage()
    DispSelectColorMenu(FlowSys.Stat.selectColorChangeType, -1378135358, -1884418840, nil, function(selectType)
      FlowSys.Stat.selectColorType = selectType
      if GROUND:GetNowColorChangeLabel(FlowSys.Stat.selectColorChangeType) == FlowSys.Stat.selectColorType then
        FlowSys:Next("sameColorChangeSelect")
      else
        FlowSys:Next("askColorChangePay")
      end
    end, function()
      FlowSys:Next("TopHomeExt")
    end)
  end
  function FlowSys.Proc.sameColorChangeSelect()
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\232\137\178", GetLandShopNameTextIdForTitle(FlowSys.Stat.selectColorType))
    ShopSys:Talk(2043329857, FACE_TYPE.NORMAL)
    WINDOW:CloseMessage()
    FlowSys:Next("MenuTopLoop")
  end
  function FlowSys.Proc.askColorChangePay()
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\232\137\178", GetLandShopNameTextIdForTitle(FlowSys.Stat.selectColorType))
    ShopSys:TalkAskFlowNoClose(359171219, FACE_TYPE.NORMAL, nil, {
      next = "colorSelect"
    }, {text = 1846028690, next = ""}, {
      text = 2077993869,
      next = "colorSelect"
    })
    if FlowSys:CheckNext() then
      return
    end
    if GROUND:IsColorChangeMaterialOk(FlowSys.Stat.selectColorType) == false then
      ShopSys:Talk(313543863, FACE_TYPE.NORMAL)
      FlowSys:Next("DefeatExit")
      return
    end
    if GROUND:IsColorChangeMoneyOk(FlowSys.Stat.selectColorType) == false then
      ShopSys:Talk(-1950251809, FACE_TYPE.NORMAL)
      FlowSys:Next("DefeatExit")
      return
    end
    EventPlay.eventShopCarpenterHomePainting()
    GROUND:PaymentColorChange(FlowSys.Stat.selectColorType)
    GROUND:ChangeHomeColor(FlowSys.Stat.selectColorType)
    GROUND:SetOpenLimitState_Menu(PARADISE_MENU_OPEN_TYPE.HOME_COLOR_CHANGE, PARADISE_OPEN_LIMIT_STATE.OPEN)
    setColorMenuOpened(FlowSys.Stat.selectColorType)
    FlowSys:Next("ActionExit")
  end
  function FlowSys.Proc.ExitTalk()
    ShopSys:Talk(-1125352458, FACE_TYPE.NORMAL)
    WINDOW:CloseMessage()
    FlowSys:Next("ExitShop")
  end
  function FlowSys.Proc.ActionExit()
    WINDOW:CloseMessage()
    FlowSys:Next("ExitShop")
  end
  function FlowSys.Proc.DefeatExit()
    WINDOW:CloseMessage()
    FlowSys:Next("ExitShop")
  end
  function FlowSys.Proc.ExitShop()
    FlowSys:Return()
  end
  function EventPlay.eventShopCarpenterCultivation()
    SYSTEM:FreeMoveScriptEventStartAll()
    WINDOW:CloseMessage()
    SCREEN_A:FadeOut(TimeSec(0.5), false)
    SCREEN_B:FadeOut(TimeSec(0.5), true)
    TASK:Sleep(TimeSec(0.2))
    CHARA:DynamicLoad("DOKKORAA_1_DYN", "DOKKORAA_1")
    CHARA:DynamicLoad("DOKKORAA_2_DYN", "DOKKORAA_2")
    CAMERA:SetEye(SymPos("SHOP_EVENT_POINT", PosOffs(0, 3.5, 10)))
    CAMERA:SetTgt(SymPos("SHOP_EVENT_POINT"))
    CH("DOTEKKOTSU"):SetPosition(SymPos("SHOP_EVENT_POINT"))
    CH("DOKKORAA_1_DYN"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0.76, 0.75)))
    CH("DOKKORAA_2_DYN"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(-0.76, 0.75)))
    CH("DOTEKKOTSU"):SetDir(RotateTarget(0))
    CH("DOKKORAA_1_DYN"):SetDir(RotateTarget(0))
    CH("DOKKORAA_2_DYN"):SetDir(RotateTarget(0))
    if CHARA:IsExist("DESUKAAN") then
      CH("DESUKAAN"):SetVisible(false)
    end
    if CHARA:IsExist("DOKKORAA_1") then
      CH("DOKKORAA_1"):SetVisible(false)
      CH("DOKKORAA_2"):SetVisible(false)
    end
    if FLAG.ParaMode == CONST.PARA_MODE_PARADISE or FLAG.StoryPlayerMode == CONST.ST_MODE_PARTNER or FLAG.StoryPlayerMode == CONST.ST_MODE_HERO then
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0, 2.5)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
    else
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0.45, 2.5)))
      CH("PARTY1"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(-0.45, 2.5)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
      CH("PARTY1"):SetDir(CH("DOTEKKOTSU"))
    end
    SCREEN_A:FadeIn(TimeSec(0.5), true)
    subEveNod(CH("DOTEKKOTSU"))
    TASK:Sleep(TimeSec(0.15))
    CH("DOTEKKOTSU"):DirTo(RotateTarget(180), Speed(500), ROT_TYPE.NEAR)
    TASK:Sleep(TimeSec(0.2))
    CH("DOKKORAA_1_DYN"):DirTo(RotateTarget(180), Speed(500), ROT_TYPE.NEAR)
    CH("DOKKORAA_2_DYN"):DirTo(RotateTarget(180), Speed(500), ROT_TYPE.NEAR)
    CH("DOKKORAA_2_DYN"):WaitRotate()
    CH("DOTEKKOTSU"):RunTo(PosOffs(0, -10), Speed(2.5))
    TASK:Sleep(TimeSec(0.1))
    CH("DOKKORAA_1_DYN"):RunTo(PosOffs(0, -10), Speed(2.5))
    CH("DOKKORAA_2_DYN"):RunTo(PosOffs(0, -10), Speed(2.5))
    CAMERA:MoveFollow(Vector(0, 0, -10), Speed(0.8, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
    TASK:Sleep(TimeSec(0.5))
    SOUND:VolumeBgm(Volume(64), TimeSec(0.8))
    SCREEN_A:FadeOut(TimeSec(1), true)
    SOUND:PlaySe(SymSnd("SE_SHOP_LAND_PREPARE"))
    SOUND:WaitSe(SymSnd("SE_SHOP_LAND_PREPARE"))
    CAMERA:SetEye(SymPos("SHOP_EVENT_POINT", PosOffs(0, 3.5, 10)))
    CAMERA:SetTgt(SymPos("SHOP_EVENT_POINT"))
    CH("DOTEKKOTSU"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0, -3.55)))
    CH("DOKKORAA_1_DYN"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0.68, -4.3)))
    CH("DOKKORAA_2_DYN"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(-0.76, -4.3)))
    CH("DOTEKKOTSU"):SetDir(RotateTarget(0))
    CH("DOKKORAA_1_DYN"):SetDir(RotateTarget(0))
    CH("DOKKORAA_2_DYN"):SetDir(RotateTarget(0))
    CH("DOTEKKOTSU"):RunTo(PosOffs(0, 3.8), Speed(3))
    TASK:Sleep(TimeSec(0.2))
    CH("DOKKORAA_1_DYN"):RunTo(PosOffs(0, 3.8), Speed(3))
    CH("DOKKORAA_2_DYN"):RunTo(PosOffs(0, 3.8), Speed(3))
    if FLAG.ParaMode == CONST.PARA_MODE_PARADISE or FLAG.StoryPlayerMode == CONST.ST_MODE_PARTNER or FLAG.StoryPlayerMode == CONST.ST_MODE_HERO then
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0, 2.5)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
    else
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0.45, 2.5)))
      CH("PARTY1"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(-0.45, 2.5)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
      CH("PARTY1"):SetDir(CH("DOTEKKOTSU"))
    end
    SOUND:VolumeBgm(Volume(256), TimeSec(0.8))
    SCREEN_A:FadeIn(TimeSec(0.5), true)
    CH("DOTEKKOTSU"):WaitMove()
    CH("DOKKORAA_1_DYN"):WaitMove()
    CH("DOKKORAA_2_DYN"):WaitMove()
    SOUND:PlayMe(SymSnd("ME_MINIGAME_PERFECT"))
    CH("DOTEKKOTSU"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.1))
    CH("DOKKORAA_2_DYN"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    CH("DOKKORAA_1_DYN"):SetMotion(SymMot("VICTORY"), LOOP.OFF)
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\229\177\158\230\128\167", CarpenterSys:GetLandTypeName(FlowSys.Stat.selectLandType))
    ShopSys:SysMsg(1643592423, nil)
    SOUND:WaitMe()
    WINDOW:CloseMessage()
    CH("DOTEKKOTSU"):WaitPlayMotion()
    CH("DOKKORAA_1_DYN"):WaitPlayMotion()
    CH("DOKKORAA_2_DYN"):WaitPlayMotion()
    TASK:Sleep(TimeSec(0.15))
    SCREEN_A:FadeOut(TimeSec(0.5), true)
    CHARA:DynamicRemove("DOKKORAA_1_DYN")
    CHARA:DynamicRemove("DOKKORAA_2_DYN")
    CH("DOTEKKOTSU"):SetPosition(SymPos("SHOP_EVENT_POINT_CENTER", PosOffs(-3.2406, 5.6222)))
    if FLAG.ParaMode == CONST.PARA_MODE_PARADISE or FLAG.StoryPlayerMode == CONST.ST_MODE_PARTNER or FLAG.StoryPlayerMode == CONST.ST_MODE_HERO then
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT_CENTER", PosOffs(-1.95, 6.6)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
    else
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT_CENTER", PosOffs(-1.95, 6.6)))
      CH("PARTY1"):SetPosition(SymPos("SHOP_EVENT_POINT_CENTER", PosOffs(-3.05, 7.3)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
      CH("PARTY1"):SetDir(CH("DOTEKKOTSU"))
    end
    CH("DOTEKKOTSU"):SetDir(CH("PARTY0"))
    if CHARA:IsExist("DESUKAAN") then
      CH("DESUKAAN"):SetVisible(true)
    end
    if CHARA:IsExist("DOKKORAA_1") then
      CH("DOKKORAA_1"):SetVisible(true)
      CH("DOKKORAA_2"):SetVisible(true)
    end
    CAMERA:MoveToPlayer(TimeSec(0), ACCEL_TYPE.NONE, DECEL_TYPE.NONE)
    CAMERA:ResetAzimuthDifferenceVolume()
    local degree = CH("DOTEKKOTSU"):GetDir()
    local centerPos = (CH("DOTEKKOTSU"):GetPosition() - CH("PARTY0"):GetPosition()) / 2 + CH("PARTY0"):GetPosition()
    CAMERA:MoveFollowZoom(centerPos, Distance(7), TimeSec(1, TIME_TYPE.FRAME), ACCEL_TYPE.NONE, DECEL_TYPE.HIGH)
    SCREEN_A:FadeIn(TimeSec(1), false)
    SCREEN_B:FadeIn(TimeSec(1), true)
    TASK:Sleep(TimeSec(0.2))
    ShopSys:Talk(150610020, FACE_TYPE.NORMAL)
  end
  function EventPlay.eventShopCarpenterHomePainting()
    SYSTEM:FreeMoveScriptEventStartAll()
    WINDOW:CloseMessage()
    SCREEN_A:FadeOut(TimeSec(0.5), false)
    SCREEN_B:FadeOut(TimeSec(0.5), true)
    TASK:Sleep(TimeSec(0.2))
    CHARA:DynamicLoad("DOKKORAA_1_DYN", "DOKKORAA_1")
    CHARA:DynamicLoad("DOKKORAA_2_DYN", "DOKKORAA_2")
    CAMERA:SetEye(SymPos("SHOP_EVENT_POINT", PosOffs(0, 3.5, 10)))
    CAMERA:SetTgt(SymPos("SHOP_EVENT_POINT"))
    CH("DOTEKKOTSU"):SetPosition(SymPos("SHOP_EVENT_POINT"))
    CH("DOKKORAA_1_DYN"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0.76, 0.75)))
    CH("DOKKORAA_2_DYN"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(-0.76, 0.75)))
    CH("DOTEKKOTSU"):SetDir(RotateTarget(0))
    CH("DOKKORAA_1_DYN"):SetDir(RotateTarget(0))
    CH("DOKKORAA_2_DYN"):SetDir(RotateTarget(0))
    if CHARA:IsExist("DESUKAAN") then
      CH("DESUKAAN"):SetVisible(false)
    end
    if CHARA:IsExist("DOKKORAA_1") then
      CH("DOKKORAA_1"):SetVisible(false)
      CH("DOKKORAA_2"):SetVisible(false)
    end
    if FLAG.ParaMode == CONST.PARA_MODE_PARADISE or FLAG.StoryPlayerMode == CONST.ST_MODE_PARTNER or FLAG.StoryPlayerMode == CONST.ST_MODE_HERO then
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0, 2.5)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
    else
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0.45, 2.5)))
      CH("PARTY1"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(-0.45, 2.5)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
      CH("PARTY1"):SetDir(CH("DOTEKKOTSU"))
    end
    SCREEN_A:FadeIn(TimeSec(0.5), true)
    subEveNod(CH("DOTEKKOTSU"))
    TASK:Sleep(TimeSec(0.15))
    CH("DOTEKKOTSU"):DirTo(RotateTarget(180), Speed(500), ROT_TYPE.NEAR)
    TASK:Sleep(TimeSec(0.2))
    CH("DOKKORAA_1_DYN"):DirTo(RotateTarget(180), Speed(500), ROT_TYPE.NEAR)
    CH("DOKKORAA_2_DYN"):DirTo(RotateTarget(180), Speed(500), ROT_TYPE.NEAR)
    CH("DOKKORAA_2_DYN"):WaitRotate()
    CH("DOTEKKOTSU"):RunTo(PosOffs(0, -10), Speed(2.5))
    TASK:Sleep(TimeSec(0.1))
    CH("DOKKORAA_1_DYN"):RunTo(PosOffs(0, -10), Speed(2.5))
    CH("DOKKORAA_2_DYN"):RunTo(PosOffs(0, -10), Speed(2.5))
    CAMERA:MoveFollow(Vector(0, 0, -10), Speed(0.8, ACCEL_TYPE.NONE, DECEL_TYPE.HIGH))
    TASK:Sleep(TimeSec(0.5))
    SOUND:VolumeBgm(Volume(64), TimeSec(0.8))
    SCREEN_A:FadeOut(TimeSec(1), true)
    SOUND:PlaySe(SymSnd("SE_SHOP_PAINT"))
    SOUND:WaitSe(SymSnd("SE_SHOP_PAINT"))
    CAMERA:SetEye(SymPos("SHOP_EVENT_POINT", PosOffs(0, 3.5, 10)))
    CAMERA:SetTgt(SymPos("SHOP_EVENT_POINT"))
    CH("DOTEKKOTSU"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0, -3.55)))
    CH("DOKKORAA_1_DYN"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0.68, -4.3)))
    CH("DOKKORAA_2_DYN"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(-0.76, -4.3)))
    CH("DOTEKKOTSU"):SetDir(RotateTarget(0))
    CH("DOKKORAA_1_DYN"):SetDir(RotateTarget(0))
    CH("DOKKORAA_2_DYN"):SetDir(RotateTarget(0))
    CH("DOTEKKOTSU"):RunTo(PosOffs(0, 3.8), Speed(3))
    TASK:Sleep(TimeSec(0.2))
    CH("DOKKORAA_1_DYN"):RunTo(PosOffs(0, 3.8), Speed(3))
    CH("DOKKORAA_2_DYN"):RunTo(PosOffs(0, 3.8), Speed(3))
    if FLAG.ParaMode == CONST.PARA_MODE_PARADISE or FLAG.StoryPlayerMode == CONST.ST_MODE_PARTNER or FLAG.StoryPlayerMode == CONST.ST_MODE_HERO then
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0, 2.5)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
    else
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(0.45, 2.5)))
      CH("PARTY1"):SetPosition(SymPos("SHOP_EVENT_POINT", PosOffs(-0.45, 2.5)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
      CH("PARTY1"):SetDir(CH("DOTEKKOTSU"))
    end
    SOUND:VolumeBgm(Volume(256), TimeSec(0.8))
    SCREEN_A:FadeIn(TimeSec(0.5), true)
    CH("DOTEKKOTSU"):WaitMove()
    CH("DOKKORAA_1_DYN"):WaitMove()
    CH("DOKKORAA_2_DYN"):WaitMove()
    CH("DOKKORAA_2_DYN"):SetMotion(SymMot("LETSGO"), LOOP.OFF)
    CH("DOKKORAA_1_DYN"):SetMotion(SymMot("LETSGO"), LOOP.OFF)
    TASK:Sleep(TimeSec(0.3))
    subEveNodDouble(CH("DOTEKKOTSU"))
    SOUND:PlayMe(SymSnd("ME_MINIGAME_SOSO"))
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\232\137\178", GetLandShopNameTextIdForTitle(FlowSys.Stat.selectColorType))
    if FlowSys.Stat.selectColorChangeType == PARADISE_COLOR_CHANGE_TYPE.HOME_ROOF then
      ShopSys:SysMsg(2970999, nil)
    else
      ShopSys:SysMsg(1288778525, nil)
    end
    SOUND:WaitMe()
    WINDOW:CloseMessage()
    CH("DOTEKKOTSU"):WaitPlayMotion()
    CH("DOKKORAA_1_DYN"):WaitPlayMotion()
    CH("DOKKORAA_2_DYN"):WaitPlayMotion()
    TASK:Sleep(TimeSec(0.15))
    SCREEN_A:FadeOut(TimeSec(0.5), true)
    CHARA:DynamicRemove("DOKKORAA_1_DYN")
    CHARA:DynamicRemove("DOKKORAA_2_DYN")
    CH("DOTEKKOTSU"):SetPosition(SymPos("SHOP_EVENT_POINT_CENTER", PosOffs(-3.2406, 5.6222)))
    if FLAG.ParaMode == CONST.PARA_MODE_PARADISE or FLAG.StoryPlayerMode == CONST.ST_MODE_PARTNER or FLAG.StoryPlayerMode == CONST.ST_MODE_HERO then
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT_CENTER", PosOffs(-1.95, 6.6)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
    else
      CH("PARTY0"):SetPosition(SymPos("SHOP_EVENT_POINT_CENTER", PosOffs(-1.95, 6.6)))
      CH("PARTY1"):SetPosition(SymPos("SHOP_EVENT_POINT_CENTER", PosOffs(-3.05, 7.3)))
      CH("PARTY0"):SetDir(CH("DOTEKKOTSU"))
      CH("PARTY1"):SetDir(CH("DOTEKKOTSU"))
    end
    CH("DOTEKKOTSU"):SetDir(CH("PARTY0"))
    if CHARA:IsExist("DESUKAAN") then
      CH("DESUKAAN"):SetVisible(true)
    end
    if CHARA:IsExist("DOKKORAA_1") then
      CH("DOKKORAA_1"):SetVisible(true)
      CH("DOKKORAA_2"):SetVisible(true)
    end
    CAMERA:MoveToPlayer(TimeSec(0), ACCEL_TYPE.NONE, DECEL_TYPE.NONE)
    CAMERA:ResetAzimuthDifferenceVolume()
    local degree = CH("DOTEKKOTSU"):GetDir()
    local centerPos = (CH("DOTEKKOTSU"):GetPosition() - CH("PARTY0"):GetPosition()) / 2 + CH("PARTY0"):GetPosition()
    CAMERA:MoveFollowZoom(centerPos, Distance(7), TimeSec(1, TIME_TYPE.FRAME), ACCEL_TYPE.NONE, DECEL_TYPE.HIGH)
    SCREEN_A:FadeIn(TimeSec(1), false)
    SCREEN_B:FadeIn(TimeSec(1), true)
    TASK:Sleep(TimeSec(0.2))
    if FlowSys.Stat.selectColorChangeType == PARADISE_COLOR_CHANGE_TYPE.HOME_ROOF then
      ShopSys:Talk(1071435397, nil)
    else
      ShopSys:Talk(905035247, nil)
    end
  end
  LOWER_SCREEN:SetVisible(false)
  FlowSys:Call("MenuTopFirst")
  FlowSys:Finish()
  ShopSys:Finish()
  LOWER_SCREEN:SetVisible(true)
  LOWER_SCREEN:ChangeLastWallpaper()
end
function openAndDispSelectMapMenu(noDevelopHomeNextFlow, noDevelopLandNextFlow, cancelAction, decideLandAction)
  FlowSys.Stat.selectLandIndex = nil
  if FlowSys.Stat.selectMapMenu == nil then
    FlowSys.Stat.selectMapMenu = openSelectMapMenu(noDevelopHomeNextFlow, noDevelopLandNextFlow, cancelAction, decideLandAction)
    SCREEN_B:LoadWallpaper(WALLPAPER_PATTERN.MAP_OUTPOST_ALL)
    SCREEN_B:SetVisibleWallpaper(true)
    SCREEN_A:FadeInAll(TimeSec(0.3), false)
    SCREEN_B:FadeInAll(TimeSec(0.3), false)
    SYSTEM:ExecuteTutorialHint(SymHint("SHOP_CARPENTER_MAP"))
  else
    CommonSys:EndUpperMenuNavi(true)
    CommonSys:SetVisibleBasicMenu(true)
  end
  MENU:SetFocus(FlowSys.Stat.selectMapMenu)
  while FlowSys:CheckNext() == false do
    MENU:WaitSync()
  end
  if FlowSys.Stat.selectMapMenu:IsOpened() then
    MENU:ClearFocus(FlowSys.Stat.selectMapMenu)
    CommonSys:EndLowerMenuNavi(true)
    CommonSys:BeginUpperMenuNavi(true)
    CommonSys:SetVisibleBasicMenu(false)
  else
    SCREEN_B:LoadWallpaper(WALLPAPER_PATTERN.SUB01)
    SCREEN_B:SetVisibleWallpaper(true)
    FlowSys.Stat.selectMapMenu = nil
    CommonSys:EndLowerMenuNavi(true)
  end
end
function disableSelectMapMenu()
  if FlowSys.Stat.selectMapMenu then
    FlowSys.Stat.selectMapMenu:SetVisible(false)
    CommonSys:EndUpperMenuNavi(true)
  end
end
function enableSelectMapMenu()
  if FlowSys.Stat.selectMapMenu then
    SCREEN_B:LoadWallpaper(WALLPAPER_PATTERN.MAP_OUTPOST_ALL)
    SCREEN_B:SetVisibleWallpaper(true)
    FlowSys.Stat.selectMapMenu:SetVisible(true)
    CommonSys:BeginUpperMenuNavi(true)
  end
end
function closeSelectMapMenu()
  if FlowSys.Stat.selectMapMenu then
    FlowSys.Stat.selectMapMenu:Close()
    SCREEN_B:LoadWallpaper(WALLPAPER_PATTERN.SUB01)
    SCREEN_B:SetVisibleWallpaper(true)
    FlowSys.Stat.selectMapMenu = nil
    CommonSys:EndUpperMenuNavi(true)
    CommonSys:EndLowerMenuNavi(true)
  end
end
LandSpriteSys = {}
LandSpriteSys.landShopLabelIcon = {
  shop_farm_heal = "shop23",
  shop_farm_oren = "shop23",
  shop_farm_megusuri = "shop23",
  shop_farm_fukkatsu = "shop23",
  shop_farm_blind = "shop23",
  shop_farm_quick = "shop23",
  shop_farm_confuse = "shop23",
  shop_farm_sleep = "shop23",
  shop_farm_warp = "shop23",
  shop_farm_blast = "shop23",
  shop_farm_kouchoku = "shop23",
  shop_farm_jaaku = "shop23",
  shop_farm_pure = "shop23",
  shop_farm_mougeki = "shop23",
  shop_farm_tanren = "shop23",
  shop_farm_hagemi = "shop23",
  shop_recycle = "shop24",
  shop_lottery = "shop25",
  shop_special_merchant_plant = "shop26",
  shop_special_merchant_throw = "shop27",
  shop_special_merchant_orb = "shop28",
  shop_select = "shop29",
  shop_treasure_map = "shop30",
  shop_wazatraining_normal = "shop31",
  shop_wazatraining_fighting = "shop31",
  shop_wazatraining_poison = "shop31",
  shop_wazatraining_ground = "shop31",
  shop_wazatraining_flying = "shop31",
  shop_wazatraining_bug = "shop31",
  shop_wazatraining_rock = "shop31",
  shop_wazatraining_ghost = "shop31",
  shop_wazatraining_steel = "shop31",
  shop_wazatraining_fire = "shop31",
  shop_wazatraining_water = "shop31",
  shop_wazatraining_electric = "shop31",
  shop_wazatraining_grass = "shop31",
  shop_wazatraining_ice = "shop31",
  shop_wazatraining_psychic = "shop31",
  shop_wazatraining_dragon = "shop31",
  shop_wazatraining_dark = "shop31",
  shop_dispatch = "shop32",
  shop_dig = "shop33",
  shop_sideway_guide = "shop34",
  shop_jukebox = "shop35",
  minigame_dungeon_diver = "shop36",
  minigame_salvage = "shop37",
  minigame_curling = "shop38"
}
function LandSpriteSys:SetupPattern()
  if self.refCount then
    self.refCount = self.refCount + 1
    return
  else
    self.refCount = 1
  end
  SPRITE:CreatePatternSet("selMapIconSet", {
    name = "exitArwU",
    img = "ICON_MAP",
    u = 16,
    v = 0,
    w = 16,
    h = 16,
    cx = 8,
    cy = 8,
    allocateFromMap = true
  }, {
    name = "exitArwD",
    img = "ICON_MAP",
    u = 32,
    v = 0,
    w = 16,
    h = 16,
    cx = 8,
    cy = 8,
    allocateFromMap = true
  }, {
    name = "exitArwL",
    img = "ICON_MAP",
    u = 48,
    v = 0,
    w = 16,
    h = 16,
    cx = 8,
    cy = 8,
    allocateFromMap = true
  }, {
    name = "exitArwR",
    img = "ICON_MAP",
    u = 64,
    v = 0,
    w = 16,
    h = 16,
    cx = 8,
    cy = 8,
    allocateFromMap = true
  }, {
    name = "shop01",
    img = "ICON_MAP",
    u = 0,
    v = 16,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop02",
    img = "ICON_MAP",
    u = 24,
    v = 16,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop03",
    img = "ICON_MAP",
    u = 48,
    v = 16,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop04",
    img = "ICON_MAP",
    u = 72,
    v = 16,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop05",
    img = "ICON_MAP",
    u = 96,
    v = 16,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop06",
    img = "ICON_MAP",
    u = 120,
    v = 16,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop07",
    img = "ICON_MAP",
    u = 144,
    v = 16,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop08",
    img = "ICON_MAP",
    u = 168,
    v = 16,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop09",
    img = "ICON_MAP",
    u = 192,
    v = 16,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop10",
    img = "ICON_MAP",
    u = 216,
    v = 16,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop11",
    img = "ICON_MAP",
    u = 0,
    v = 40,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop12",
    img = "ICON_MAP",
    u = 24,
    v = 40,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop13",
    img = "ICON_MAP",
    u = 48,
    v = 40,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop14",
    img = "ICON_MAP",
    u = 72,
    v = 40,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop15",
    img = "ICON_MAP",
    u = 96,
    v = 40,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop16",
    img = "ICON_MAP",
    u = 120,
    v = 40,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop17",
    img = "ICON_MAP",
    u = 144,
    v = 40,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop18",
    img = "ICON_MAP",
    u = 168,
    v = 40,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop19",
    img = "ICON_MAP",
    u = 192,
    v = 40,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop20",
    img = "ICON_MAP",
    u = 216,
    v = 40,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop21",
    img = "ICON_MAP",
    u = 0,
    v = 64,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop22",
    img = "ICON_MAP",
    u = 24,
    v = 64,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop23",
    img = "ICON_MAP",
    u = 48,
    v = 64,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop24",
    img = "ICON_MAP",
    u = 72,
    v = 64,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop25",
    img = "ICON_MAP",
    u = 96,
    v = 64,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop26",
    img = "ICON_MAP",
    u = 120,
    v = 64,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop27",
    img = "ICON_MAP",
    u = 144,
    v = 64,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop28",
    img = "ICON_MAP",
    u = 168,
    v = 64,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop29",
    img = "ICON_MAP",
    u = 192,
    v = 64,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop30",
    img = "ICON_MAP",
    u = 216,
    v = 64,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop31",
    img = "ICON_MAP",
    u = 0,
    v = 88,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop32",
    img = "ICON_MAP",
    u = 24,
    v = 88,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop33",
    img = "ICON_MAP",
    u = 48,
    v = 88,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop34",
    img = "ICON_MAP",
    u = 72,
    v = 88,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop35",
    img = "ICON_MAP",
    u = 96,
    v = 88,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop36",
    img = "ICON_MAP",
    u = 120,
    v = 88,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop37",
    img = "ICON_MAP",
    u = 144,
    v = 88,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop38",
    img = "ICON_MAP",
    u = 168,
    v = 88,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop39",
    img = "ICON_MAP",
    u = 192,
    v = 88,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  }, {
    name = "shop40",
    img = "ICON_MAP",
    u = 216,
    v = 88,
    w = 24,
    h = 24,
    cx = 12,
    cy = 12,
    allocateFromMap = true
  })
end
function LandSpriteSys:DestroyPattern()
  if self.refCount > 1 then
    self.refCount = self.refCount - 1
    return
  else
    self.refCount = nil
  end
  SPRITE:DestroyPatternSet("selMapIconSet")
end
function LandSpriteSys:GetLandShopIconSetName()
  return "selMapIconSet"
end
function LandSpriteSys:GetLandShopIconPatternName(landIdx, spaceIdx)
  if landIdx == PARADISE_LAND_INDEX.INDEX_HOME then
    return "shop11"
  else
    return self.landShopLabelIcon[GROUND:GetLandShopLabel(landIdx, spaceIdx)]
  end
end
function openSelectMapMenu(noDevelopHomeNextFlow, noDevelopLandNextFlow, cancelAction, decideLandAction)
  local buttonMenu = MENU:CreateButtonMenu()
  local btnTbl = {
    {
      rect = Rectangle(16, 24, 96, 64),
      link = {
        l = 2,
        r = 1,
        u = 6,
        d = 3
      },
      landIndex = PARADISE_LAND_INDEX.INDEX_00
    },
    {
      rect = Rectangle(112, 24, 96, 64),
      link = {
        l = 0,
        r = 2,
        u = 7,
        d = 4
      },
      landIndex = PARADISE_LAND_INDEX.INDEX_01
    },
    {
      rect = Rectangle(208, 24, 96, 64),
      link = {
        l = 1,
        r = 0,
        u = 8,
        d = 5
      },
      landIndex = PARADISE_LAND_INDEX.INDEX_02
    },
    {
      rect = Rectangle(16, 88, 96, 64),
      link = {
        l = 5,
        r = 4,
        u = 0,
        d = 6
      },
      landIndex = PARADISE_LAND_INDEX.INDEX_03
    },
    {
      rect = Rectangle(112, 88, 96, 64),
      link = {
        l = 3,
        r = 5,
        u = 1,
        d = 7
      },
      landIndex = PARADISE_LAND_INDEX.INDEX_04
    },
    {
      rect = Rectangle(208, 88, 96, 64),
      link = {
        l = 4,
        r = 3,
        u = 2,
        d = 8
      },
      landIndex = PARADISE_LAND_INDEX.INDEX_05
    },
    {
      rect = Rectangle(16, 152, 96, 64),
      link = {
        l = 8,
        r = 7,
        u = 3,
        d = 0
      },
      landIndex = PARADISE_LAND_INDEX.INDEX_06
    },
    {
      rect = Rectangle(112, 152, 96, 64),
      link = {
        l = 6,
        r = 8,
        u = 4,
        d = 1
      },
      landIndex = PARADISE_LAND_INDEX.INDEX_HOME
    },
    {
      rect = Rectangle(208, 152, 96, 64),
      link = {
        l = 7,
        r = 6,
        u = 5,
        d = 2
      },
      landIndex = PARADISE_LAND_INDEX.INDEX_07
    }
  }
  local spriteTbl = {
    wild_parts = {
      img = "MAP_OUTPOST_ALL_LAND",
      u = 96,
      v = 64,
      w = 96,
      h = 64,
      isMul = false
    },
    grass_parts = {
      img = "MAP_OUTPOST_ALL_LAND",
      u = 0,
      v = 128,
      w = 96,
      h = 64,
      isMul = false
    },
    forest_parts = {
      img = "MAP_OUTPOST_ALL_LAND",
      u = 96,
      v = 128,
      w = 96,
      h = 64,
      isMul = false
    },
    water_parts = {
      img = "MAP_OUTPOST_ALL_LAND",
      u = 0,
      v = 192,
      w = 96,
      h = 64,
      isMul = false
    },
    rock_parts = {
      img = "MAP_OUTPOST_ALL_LAND",
      u = 96,
      v = 192,
      w = 96,
      h = 64,
      isMul = false
    },
    home1_parts = {
      img = "MAP_OUTPOST_ALL_LAND",
      u = 0,
      v = 0,
      w = 96,
      h = 64,
      isMul = false
    },
    dark_parts = {
      img = "MAP_OUTPOST_ALL_FRAME",
      u = 0,
      v = 0,
      w = 112,
      h = 80,
      isMul = true
    }
  }
  if GROUND:GetParadiseHomeLevel() == 1 then
    spriteTbl.home1_parts = {
      img = "MAP_OUTPOST_ALL_LAND",
      u = 0,
      v = 0,
      w = 96,
      h = 64,
      isMul = false
    }
  elseif GROUND:GetParadiseHomeLevel() == 2 then
    spriteTbl.home1_parts = {
      img = "MAP_OUTPOST_ALL_LAND",
      u = 96,
      v = 0,
      w = 96,
      h = 64,
      isMul = false
    }
  else
    spriteTbl.home1_parts = {
      img = "MAP_OUTPOST_ALL_LAND",
      u = 0,
      v = 64,
      w = 96,
      h = 64,
      isMul = false
    }
  end
  local landTypeSprTbl = {
    [PARADISE_LAND_TYPE.WILDERNESS] = spriteTbl.wild_parts,
    [PARADISE_LAND_TYPE.PRAIRIE] = spriteTbl.grass_parts,
    [PARADISE_LAND_TYPE.FOREST] = spriteTbl.forest_parts,
    [PARADISE_LAND_TYPE.ROCKY_HILL] = spriteTbl.rock_parts,
    [PARADISE_LAND_TYPE.WATER] = spriteTbl.water_parts
  }
  LandSpriteSys:SetupPattern()
  local landShopIconPosTbl = {
    [-1] = {
      Vector2(48, 24),
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0)
    },
    [PARADISE_LAND_TYPE.WILDERNESS] = {
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0)
    },
    [PARADISE_LAND_TYPE.PRAIRIE] = {
      Vector2(32, 16),
      Vector2(28, 44),
      Vector2(64, 16),
      Vector2(68, 44)
    },
    [PARADISE_LAND_TYPE.FOREST] = {
      Vector2(36, 20),
      Vector2(16, 32),
      Vector2(64, 28),
      Vector2(84, 36)
    },
    [PARADISE_LAND_TYPE.WATER] = {
      Vector2(40, 8),
      Vector2(20, 24),
      Vector2(72, 20),
      Vector2(48, 48)
    },
    [PARADISE_LAND_TYPE.ROCKY_HILL] = {
      Vector2(36, 12),
      Vector2(36, 36),
      Vector2(64, 16),
      Vector2(64, 40)
    }
  }
  for landIdx = 1, 9 do
    SPRITE:CreateSprite("landshop" .. landIdx)
  end
  for i, btn in ipairs(btnTbl) do
    local buttonMenuWindow = MENU:CreateButtonMenuWindow()
    buttonMenuWindow:SetType(ButtonMenuWindowType.TYPE_SPRITE)
    local spr
    if btn.landIndex == PARADISE_LAND_INDEX.INDEX_HOME then
      spr = spriteTbl.home1_parts
    elseif GROUND:IsOpenedParadiseLand(btn.landIndex) then
      spr = landTypeSprTbl[GROUND:GetParadiseLandType(btn.landIndex)]
    else
      spr = spriteTbl.dark_parts
    end
    buttonMenuWindow:LoadSpriteImage(spr.img, SpriteSlotIndex.SLOT_INDEX_0, true)
    buttonMenuWindow:SetSpriteInfo(SpriteSlotIndex.SLOT_INDEX_0, spr.u, spr.v, spr.w, spr.h)
    buttonMenuWindow:SetSpriteBlendMul(SpriteSlotIndex.SLOT_INDEX_0, spr.isMul)
    local centerRc = Rectangle(btn.rect.x + (btn.rect.w - spr.w) / 2, btn.rect.y + (btn.rect.h - spr.h) / 2, spr.w, spr.h)
    buttonMenuWindow:SetRectangle(centerRc)
    buttonMenu:AddButtonMenuWindowItem(buttonMenuWindow, btn, nil)
    buttonMenu:SetItemLink4(i - 1, btn.link.l, btn.link.r, btn.link.u, btn.link.d)
    local shopPtnTbl = {}
    for spaceIdx = 1, 4 do
      if btn.landIndex ~= PARADISE_LAND_INDEX.INDEX_HOME and GROUND:IsLandShopExist(btn.landIndex, spaceIdx - 1) then
        local landType = GROUND:GetParadiseLandType(btn.landIndex)
        local iconPos = landShopIconPosTbl[landType][spaceIdx]
        table.insert(shopPtnTbl, {
          setName = LandSpriteSys:GetLandShopIconSetName(),
          ptnName = LandSpriteSys:GetLandShopIconPatternName(btn.landIndex, spaceIdx - 1),
          ofsX = iconPos.x,
          ofsY = iconPos.y,
          ofsPrio = 0
        })
      elseif btn.landIndex == PARADISE_LAND_INDEX.INDEX_HOME then
        local iconPos = landShopIconPosTbl[-1][1]
        table.insert(shopPtnTbl, {
          setName = LandSpriteSys:GetLandShopIconSetName(),
          ptnName = LandSpriteSys:GetLandShopIconPatternName(btn.landIndex),
          ofsX = iconPos.x,
          ofsY = iconPos.y,
          ofsPrio = 0
        })
      end
    end
    if #shopPtnTbl ~= 0 then
      SPRT("landshop" .. i):SetPatternFromTable(shopPtnTbl)
      SPRT("landshop" .. i):SetOption({
        screen = ScreenType.B,
        visible = true,
        pos = Vector2(centerRc.x, centerRc.y),
        prio = 400
      })
    end
  end
  buttonMenu:SetCursorItemIndex(4)
  function buttonMenu:cancelAction()
    cancelAction()
    self:Close()
  end
  function buttonMenu:decideAction()
    local btn = self.curItem.obj
    local selectLandIndex = btn.landIndex
    if selectLandIndex == PARADISE_LAND_INDEX.INDEX_HOME or GROUND:IsOpenedParadiseLand(selectLandIndex) == false then
      self:GetIconCursor():Play(IconCursorAction.NORMAL, true)
      if selectLandIndex == PARADISE_LAND_INDEX.INDEX_HOME then
        FlowSys:Next(noDevelopHomeNextFlow)
      else
        FlowSys:Next(noDevelopLandNextFlow)
      end
      return
    end
    FlowSys.Stat.selectLandIndex = selectLandIndex
    decideLandAction()
  end
  function buttonMenu:openedAction()
    CommonSys:OpenBasicMenu(-1653755322, -802044746, nil)
  end
  function buttonMenu:closedAction()
    ShopSys:SaveCursorIndex("SelectMapMenu", self:GetCursorItemIndex())
    CommonSys:CloseBasicMenu()
    for landIdx = 1, 9 do
      SPRITE:DestroySprite("landshop" .. landIdx)
    end
    LandSpriteSys:DestroyPattern()
    GuidMapSys:EndGuidMap_ParadiseLand(function()
    end)
  end
  GuidMapSys:BeginGuidMap_ParadiseLand(btnTbl[buttonMenu:GetCursorItemIndex() + 1].landIndex)
  buttonMenu:SetOption({
    inputMode = "LINK",
    selectMode = "SCALE",
    iconCursor = "PARA_LAND"
  })
  function buttonMenu:currentItemChange()
    GuidMapSys:ChangeGuidMap_ParadiseLand(self.curItem.obj.landIndex)
  end
  function buttonMenu:SetGuidMapVisible(bVisible)
    if bVisible then
    else
    end
  end
  buttonMenu:Open()
  return buttonMenu
end
function setLandTypeMenuOpened(landType)
  local typeLabelTbl = {
    [PARADISE_LAND_TYPE.PRAIRIE] = "reclamation_weed",
    [PARADISE_LAND_TYPE.FOREST] = "reclamation_wood",
    [PARADISE_LAND_TYPE.ROCKY_HILL] = "reclamation_rock",
    [PARADISE_LAND_TYPE.WATER] = "reclamation_water"
  }
  local state = GROUND:GetOpenLimitState_LandShopLabel(typeLabelTbl[landType])
  if state == PARADISE_OPEN_LIMIT_STATE.OPEN_NEW then
    GROUND:SetOpenLimitState_LandShopLabel(typeLabelTbl[landType], PARADISE_OPEN_LIMIT_STATE.OPEN)
  end
end
function setColorMenuOpened(colorLabel)
  local state = GROUND:GetOpenLimitState_LandShopLabel(colorLabel)
  if state == PARADISE_OPEN_LIMIT_STATE.OPEN_NEW then
    GROUND:SetOpenLimitState_LandShopLabel(colorLabel, PARADISE_OPEN_LIMIT_STATE.OPEN)
  end
end
GuidMapSys = {}
function GuidMapSys:BeginGuidMap_ParadiseLand(selectLandIndex)
  self.textBoardMenu = MENU:CreateBoardMenuWindow(ScreenType.A)
  self.textBoardMenu:SetOption({showBgFrame = false})
  self.textBoardMenu:SetFontType(FontType.TYPE_12)
  self.textBoardMenu:SetTextOffset(0, 0)
  self.textBoardMenu:SetLayoutRect(Rectangle(0, 0, 400, 240))
  self.textBoardMenu:Open()
  self.textShopMenuTbl = {}
  for ii = 1, 4 do
    self.textShopMenuTbl[ii] = MENU:CreateBoardMenuWindow(ScreenType.A)
    self.textShopMenuTbl[ii]:SetOption({
      frameMode = FrameMode.INFOMATION_MENU
    })
    self.textShopMenuTbl[ii]:SetFontType(FontType.TYPE_12)
    self.textShopMenuTbl[ii]:SetTextOffset(0, -4)
    self.textShopMenuTbl[ii]:SetLayoutRect(Rectangle(0, 0, 120, 16))
    self.textShopMenuTbl[ii]:Open()
  end
  LandSpriteSys:SetupPattern()
  SPRITE:CreatePatternSet("mapBgSet", {
    name = "MAP_BASE_BG",
    img = "WALLPAPER_MAIN_NOTICE02",
    u = 0,
    v = 0,
    w = 512,
    h = 240,
    cx = 256,
    cy = 120,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_COUNTER",
    img = "MAP_OUTPOST_INST",
    u = 0,
    v = 0,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_HOUSE_1",
    img = "MAP_OUTPOST_INST",
    u = 64,
    v = 0,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_HOUSE_2",
    img = "MAP_OUTPOST_INST",
    u = 128,
    v = 0,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_DIVER",
    img = "MAP_OUTPOST_INST",
    u = 192,
    v = 0,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_HORIATE",
    img = "MAP_OUTPOST_INST",
    u = 0,
    v = 64,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_DOOM_1",
    img = "MAP_OUTPOST_INST",
    u = 64,
    v = 64,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_DOOM_2",
    img = "MAP_OUTPOST_INST",
    u = 128,
    v = 64,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_SALVAGE",
    img = "MAP_OUTPOST_INST",
    u = 192,
    v = 64,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_WAZA_TRAINING",
    img = "MAP_OUTPOST_INST",
    u = 0,
    v = 128,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_TENT_1",
    img = "MAP_OUTPOST_INST",
    u = 64,
    v = 128,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_TENT_2",
    img = "MAP_OUTPOST_INST",
    u = 128,
    v = 128,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_TAMAIRE",
    img = "MAP_OUTPOST_INST",
    u = 192,
    v = 128,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_MUSIC",
    img = "MAP_OUTPOST_INST",
    u = 0,
    v = 192,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_FARM_1",
    img = "MAP_OUTPOST_INST",
    u = 64,
    v = 192,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  }, {
    name = "PARA_SHOP_FARM_2",
    img = "MAP_OUTPOST_INST",
    u = 128,
    v = 192,
    w = 64,
    h = 64,
    cx = 34,
    cy = 38,
    allocateFromMap = true
  })
  SPRITE:CreateSprite("mapLandBg")
  for spaceIdx = 1, 4 do
    SPRITE:CreateSprite("shop0" .. spaceIdx)
  end
  self:ChangeGuidMap_ParadiseLand(selectLandIndex, false)
end
function GuidMapSys:ChangeGuidMap_ParadiseLand(selectLandIndex, fadeFlag)
  if fadeFlag then
    SCREEN_A:FadeOutAll(TimeSec(8, TIME_TYPE.FRAME), true)
  end
  local landType = selectLandIndex == PARADISE_LAND_INDEX.INDEX_HOME and -1 or GROUND:GetParadiseLandType(selectLandIndex)
  local drawText = ""
  local landTypeNameTbl = {
    [-1] = 2057575993,
    [PARADISE_LAND_TYPE.WILDERNESS] = 1411687167,
    [PARADISE_LAND_TYPE.PRAIRIE] = 1989378931,
    [PARADISE_LAND_TYPE.FOREST] = -1952329977,
    [PARADISE_LAND_TYPE.WATER] = -634815408,
    [PARADISE_LAND_TYPE.ROCKY_HILL] = 567129807
  }
  drawText = drawText .. "[VO:24][HO:32][FT:2][CS:8]" .. MENU:ReplaceTagText(landTypeNameTbl[landType]) .. "[CR][FR]"
  local homeBgTbl = {
    "MAP_GUIDE_HOME00",
    "MAP_GUIDE_HOME01",
    "MAP_GUIDE_HOME02",
    "MAP_GUIDE_HOME03"
  }
  local landTypebgImgTbl = {
    [-1] = homeBgTbl[GROUND:GetParadiseHomeLevel() + 1],
    [PARADISE_LAND_TYPE.WILDERNESS] = "MAP_OUTPOST00WILD",
    [PARADISE_LAND_TYPE.PRAIRIE] = "MAP_OUTPOST01GRASS",
    [PARADISE_LAND_TYPE.FOREST] = "MAP_OUTPOST02FOREST",
    [PARADISE_LAND_TYPE.WATER] = "MAP_OUTPOST03WATER",
    [PARADISE_LAND_TYPE.ROCKY_HILL] = "MAP_OUTPOST04ROCK"
  }
  local bgImg = landTypebgImgTbl[landType]
  SPRITE:CreatePatternSet("mapBgReloadSet", {
    name = "MAP_LAND_BG",
    img = bgImg,
    u = 0,
    v = 0,
    w = 240,
    h = 160,
    cx = 120,
    cy = 80,
    allocateFromMap = true
  })
  local landShopPosIconTbl = {
    [-1] = {
      Vector2(200, 116),
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0)
    },
    [PARADISE_LAND_TYPE.WILDERNESS] = {
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0)
    },
    [PARADISE_LAND_TYPE.PRAIRIE] = {
      Vector2(140, 100),
      Vector2(132, 148),
      Vector2(268, 100),
      Vector2(268, 156)
    },
    [PARADISE_LAND_TYPE.FOREST] = {
      Vector2(156, 100),
      Vector2(116, 124),
      Vector2(252, 100),
      Vector2(292, 132)
    },
    [PARADISE_LAND_TYPE.WATER] = {
      Vector2(164, 92),
      Vector2(116, 124),
      Vector2(244, 108),
      Vector2(204, 180)
    },
    [PARADISE_LAND_TYPE.ROCKY_HILL] = {
      Vector2(180, 60),
      Vector2(148, 116),
      Vector2(252, 68),
      Vector2(268, 140)
    }
  }
  local landShopTextPosTbl = {
    [-1] = {
      Vector2(224, 120),
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0)
    },
    [PARADISE_LAND_TYPE.WILDERNESS] = {
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0)
    },
    [PARADISE_LAND_TYPE.PRAIRIE] = {
      Vector2(168, 72),
      Vector2(168, 192),
      Vector2(232, 72),
      Vector2(240, 192)
    },
    [PARADISE_LAND_TYPE.FOREST] = {
      Vector2(192, 72),
      Vector2(160, 160),
      Vector2(208, 72),
      Vector2(240, 176)
    },
    [PARADISE_LAND_TYPE.WATER] = {
      Vector2(160, 72),
      Vector2(160, 160),
      Vector2(240, 80),
      Vector2(224, 192)
    },
    [PARADISE_LAND_TYPE.ROCKY_HILL] = {
      Vector2(160, 64),
      Vector2(160, 168),
      Vector2(240, 112),
      Vector2(240, 184)
    }
  }
  local landShopImgPosTbl = {
    [-1] = {
      Vector2(200, 116),
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0)
    },
    [PARADISE_LAND_TYPE.WILDERNESS] = {
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0),
      Vector2(0, 0)
    },
    [PARADISE_LAND_TYPE.PRAIRIE] = {
      Vector2(168, 104),
      Vector2(152, 160),
      Vector2(248, 104),
      Vector2(248, 168)
    },
    [PARADISE_LAND_TYPE.FOREST] = {
      Vector2(176, 104),
      Vector2(136, 120),
      Vector2(240, 120),
      Vector2(280, 128)
    },
    [PARADISE_LAND_TYPE.WATER] = {
      Vector2(184, 80),
      Vector2(136, 120),
      Vector2(264, 112),
      Vector2(208, 200)
    },
    [PARADISE_LAND_TYPE.ROCKY_HILL] = {
      Vector2(168, 72),
      Vector2(168, 136),
      Vector2(240, 88),
      Vector2(256, 160)
    }
  }
  local spaceIdxTbl = {
    PARADISE_SPACE_INDEX.INDEX_00,
    PARADISE_SPACE_INDEX.INDEX_01,
    PARADISE_SPACE_INDEX.INDEX_02,
    PARADISE_SPACE_INDEX.INDEX_03
  }
  SPRT("mapLandBg"):SetPattern({
    setName = "mapBgSet",
    ptnName = "MAP_BASE_BG",
    ofsX = 0,
    ofsY = 0,
    ofsPrio = 0
  }, {
    setName = "mapBgReloadSet",
    ptnName = "MAP_LAND_BG",
    ofsX = 0,
    ofsY = 20,
    ofsPrio = -1
  })
  SPRT("mapLandBg"):SetOption({
    screen = ScreenType.A,
    visible = true,
    pos = Vector2(200, 120),
    prioFromMenu = 50
  })
  if selectLandIndex ~= PARADISE_LAND_INDEX.INDEX_HOME then
    for spaceIdx = 1, 4 do
      if GROUND:IsLandShopExist(selectLandIndex, spaceIdxTbl[spaceIdx]) then
        local grLabel = GROUND:GetLandShopGraphicLabel(selectLandIndex, spaceIdxTbl[spaceIdx])
        local iconPos = Vector2(landShopPosIconTbl[landType][spaceIdx])
        local imgPos = Vector2(landShopImgPosTbl[landType][spaceIdx])
        local textPos = Vector2(landShopTextPosTbl[landType][spaceIdx])
        SPRT("shop0" .. spaceIdx):SetPattern({
          setName = LandSpriteSys:GetLandShopIconSetName(),
          ptnName = LandSpriteSys:GetLandShopIconPatternName(selectLandIndex, spaceIdx - 1),
          ofsX = iconPos.x,
          ofsY = iconPos.y,
          ofsPrio = 0
        }, {
          setName = "mapBgSet",
          ptnName = grLabel,
          ofsX = imgPos.x,
          ofsY = imgPos.y,
          ofsPrio = 1,
          hflip = 200 > imgPos.x
        })
        SPRT("shop0" .. spaceIdx):SetOption({
          screen = ScreenType.A,
          visible = true,
          pos = Vector2(0, 0),
          prioFromMenu = 30
        })
        local landShopLabel = GROUND:GetLandShopLabel(selectLandIndex, spaceIdx - 1)
        local shopName = GetLandShopNameTextStringForTitle(landShopLabel)
        local shopNameWidth = MENU:GetTextWidth(shopName)
        local tx = 200 < textPos.x and textPos.x or textPos.x - shopNameWidth
        local ty = textPos.y
        if self.textShopMenuTbl[spaceIdx] then
          self.textShopMenuTbl[spaceIdx]:SetVisible(true)
          self.textShopMenuTbl[spaceIdx]:SetLayoutPosition(tx, ty - 8)
          self.textShopMenuTbl[spaceIdx]:Resize(shopNameWidth, 8)
          self.textShopMenuTbl[spaceIdx]:SetText(string.format("[FT:3]%s[FR]", shopName))
        end
      else
        SPRT("shop0" .. spaceIdx):SetVisible(false)
        self.textShopMenuTbl[spaceIdx]:SetVisible(false)
      end
    end
  else
    SPRT("shop01"):SetVisible(false)
    SPRT("shop02"):SetVisible(false)
    SPRT("shop03"):SetVisible(false)
    SPRT("shop04"):SetVisible(false)
    self.textShopMenuTbl[1]:SetVisible(false)
    self.textShopMenuTbl[2]:SetVisible(false)
    self.textShopMenuTbl[3]:SetVisible(false)
    self.textShopMenuTbl[4]:SetVisible(false)
    local iconPos = Vector2(landShopPosIconTbl[-1][1])
    local textPos = Vector2(landShopTextPosTbl[-1][1])
    SPRT("shop01"):SetVisible(true)
    SPRT("shop01"):SetPattern({
      setName = LandSpriteSys:GetLandShopIconSetName(),
      ptnName = LandSpriteSys:GetLandShopIconPatternName(selectLandIndex),
      ofsX = 0,
      ofsY = 0,
      ofsPrio = 0
    })
    SPRT("shop01"):SetOption({
      screen = ScreenType.A,
      visible = true,
      pos = iconPos,
      prioFromMenu = 30
    })
    local shopName = MENU:ReplaceTagText(554553607)
    local shopNameWidth = MENU:GetTextWidth(shopName)
    local tx = 200 < textPos.x and textPos.x or textPos.x - shopNameWidth
    local ty = textPos.y
    self.textShopMenuTbl[1]:SetVisible(true)
    self.textShopMenuTbl[1]:SetLayoutPosition(tx, ty - 8)
    self.textShopMenuTbl[1]:Resize(shopNameWidth, 8)
    self.textShopMenuTbl[1]:SetText(string.format("[FT:3]%s[FR]", shopName))
  end
  self.textBoardMenu:SetText(drawText)
  if fadeFlag then
    SCREEN_A:FadeInAll(TimeSec(8, TIME_TYPE.FRAME), false)
  end
end
function GuidMapSys:EndGuidMap_ParadiseLand(nextStartFunc)
  self.textBoardMenu:Close()
  self.textBoardMenu = nil
  for ii = 1, 4 do
    self.textShopMenuTbl[ii]:Close()
  end
  self.textShopMenuTbl = nil
  LandSpriteSys:DestroyPattern()
  SPRITE:DestroyPatternSet("mapBgSet")
  SPRITE:DestroyPatternSet("mapBgReloadSet")
  SPRITE:DestroySprite("mapLandBg")
  for spaceIdx = 1, 4 do
    SPRITE:DestroySprite("shop0" .. spaceIdx)
  end
  if nextStartFunc then
    nextStartFunc()
  else
    SCREEN_B:LoadWallpaper(WALLPAPER_PATTERN.SUB01)
  end
end
