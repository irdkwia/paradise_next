function OpenDigMenuOutSide(resumeFlow, resumeArgTbl, spaceIndex)
  local DIG_PRICE_RATE_10M = 100
  local depth = 0
  local EventPlay = {}
  local GoodRateFlag = false
  MENU:LoadMenuTextPool("message/shop.bin", false)
  MENU:LoadMenuTextPool("message/paradise_next_common.bin")
  FlowSys:Start()
  ShopSys:Start()
  ShopSys:SetOwner("MOGURYUU")
  local reloadEntryAndResumeFlow = function(resumeFlow, resumeArgTbl)
    SYSTEM:DebugPrint("##### 1 #####")
    GROUND:SetLandShopSceneContinueFunction(function()
      OpenDigMenuOutSide(resumeFlow, resumeArgTbl)
    end)
    FlowSys:Finish()
    ShopSys:Finish()
    FLAG.MapMoveNoFade = CONST.FLAG_TRUE
    GROUND__2:GroundBrokenLandShopForDigShop()
    SYSTEM:ReloadLandEntry()
  end
  local reloadEntryAndResumeFlow2 = function(resumeFlow, resumeArgTbl)
    SYSTEM:DebugPrint("##### 2 #####")
    GROUND:SetLandShopSceneContinueFunction(function()
      OpenDigMenuOutSide(resumeFlow, resumeArgTbl)
    end)
    FlowSys:Finish()
    ShopSys:Finish()
    FLAG.MapMoveNoFade = CONST.FLAG_TRUE
    GROUND__2:GroundBuildDigShop()
    GROUND__2:SetDigDepth(GROUND__2:GetDigDepthBuf())
    GROUND__2:SetGoodRateFlagDig(GROUND__2:IsGoodRateFlagDigBuf())
    GROUND__2:ClearDigShopOwner()
    SYSTEM:ReloadLandEntry()
  end
  function FlowSys.Proc.DigMenuOutSideTop()
    EventPlay.eventShopDigStart()
    ShopSys:TalkAskFlowNoClose(-139793625, nil, nil, {
      next = "DigMenuOutSideCansel"
    }, {
      text = 1333716675,
      next = "DigMenuOutSideBuildCheck"
    }, {
      text = -1749010383,
      next = "DigMenuOutSideCansel",
      default = true
    })
    CH("DIG_SHOP_OWNER"):SetMotion(SymMot("WAIT02"), LOOP.ON)
  end
  function FlowSys.Proc.DigMenuOutSideBuildCheck()
    GoodRateFlag = false
    if GROUND__2:DigIsBuildPlace() then
      FlowSys:Next("DigMenuOutSideDestructionCheck")
    else
      FlowSys:Next("DigMenuSelectDigDepthEvent")
    end
  end
  function FlowSys.Proc.DigMenuOutSideDestructionCheck()
    EventPlay.eventShopDigBuildingStart()
    ShopSys:TalkAskFlowNoClose(-2043745936, nil, nil, {
      next = "DigMenuOutSideDestructionCansel"
    }, {
      text = -963538300,
      next = "DigMenuSelectDigDepthEventRateChange"
    }, {
      text = -880578539,
      next = "DigMenuOutSideDestructionCansel",
      default = true
    })
    CH("DIG_SHOP_OWNER"):SetMotion(SymMot("WAIT02"), LOOP.ON)
  end
  function FlowSys.Proc.DigMenuSelectDigDepthEventRateChange()
    GoodRateFlag = true
    FlowSys:Next("DigMenuSelectDigDepthEvent")
  end
  function FlowSys.Proc.DigMenuSelectDigDepthEvent()
    EventPlay.eventShopDigDepthStart()
    FlowSys:Next("DigMenuSelectDigDepthFirst")
  end
  function FlowSys.Proc.DigMenuSelectDigDepthFirst()
    depth = 0
    CommonSys:OpenBasicMenu(nil, -1733859855, nil)
    ShopSys:TalkAskFlowNoClose(1818552815, FACE_TYPE.NORMAL, {cursorReset = true}, {
      next = "DigMenuOutSide2Cansel"
    }, {
      text = 1127618251,
      next = "DigMenuDepthSelect10"
    }, {
      text = -866877028,
      next = "DigMenuDepthSelect50"
    }, {
      text = 1111874798,
      next = "DigMenuDepthSelect100"
    })
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.DigMenuDepthSelect10()
    depth = 1
    FlowSys:Next("DigMenuDecideDigDepth01")
  end
  function FlowSys.Proc.DigMenuDepthSelect50()
    depth = 5
    FlowSys:Next("DigMenuDecideDigDepth01")
  end
  function FlowSys.Proc.DigMenuDepthSelect100()
    depth = 10
    FlowSys:Next("DigMenuDecideDigDepth01")
  end
  function FlowSys.Proc.DigMenuDecideDigDepth01()
    local price = DIG_PRICE_RATE_10M * depth
    MENU:SetTag_Value(0, depth * 10)
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\230\183\177\227\129\149", MENU:ReplaceTagText("[value_b:0]"))
    MENU:SetTag_Money(0, price)
    ShopSys:SetShopTag("\229\144\136\232\168\136\232\179\188\229\133\165\233\161\141", MENU:ReplaceTagText("[st_money:0]"))
    ShopSys:DispMoneyWindowOpen()
    ShopSys:TalkAskFlowNoClose(-1301873262, nil, nil, {
      next = "DigMenuSelectDigDepthFirst"
    }, {
      text = 593468930,
      next = "DigMenuCheckEnoughMoneyForDepth1st"
    }, {
      text = 2024654400,
      next = "DigMenuSelectDigDepthFirst",
      default = true
    })
    ShopSys:DispMoneyWindowClose()
  end
  function FlowSys.Proc.DigMenuCheckEnoughMoneyForDepth1st()
    local price = DIG_PRICE_RATE_10M * depth
    if price <= GROUND:GetPlayerMoney() then
      SOUND:PlaySe(SymSnd("SE_ACT_MONEY"))
      GROUND:SetPlayerMoney(GROUND:GetPlayerMoney() - price)
      EventPlay.eventShopDigThanks1st()
      FlowSys:Next("DigMenuBuildDigShop")
    else
      EventPlay.eventShopDigNoMoney1st()
      FlowSys:Next("DigMenuSelectDigDepthFirst")
    end
  end
  function FlowSys.Proc.DigMenuBuildDigShop()
    SOUND:VolumeBgm(Volume(64), TimeSec(0.8))
    SCREEN_A:FadeOut(TimeSec(0.3), false)
    SCREEN_B:FadeOut(TimeSec(0.3), true)
    SOUND:PlaySe(SymSnd("SE_WAZA_ANAWOHORU_1"))
    TASK:Sleep(TimeSec(0.6))
    SOUND:PlaySe(SymSnd("SE_WAZA_ANAWOHORU_1"))
    SOUND:WaitSe(SymSnd("SE_WAZA_ANAWOHORU_1"))
    GROUND__2:SetDigDepthBuf(depth)
    GROUND__2:SetGoodRateFlagDigBuf(GoodRateFlag)
    FlowSys:Next("DigMenuOutSideDig")
  end
  function FlowSys.Proc.DigMenuOutSideDig()
    reloadEntryAndResumeFlow("DigMenuOutSideDig2")
  end
  function FlowSys.Proc.DigMenuOutSideDig2()
    reloadEntryAndResumeFlow2("DigMenuBuildDigShopAfter")
  end
  function FlowSys.Proc.DigMenuBuildDigShopAfter()
    SCREEN_A:FadeOut(TimeSec(0), false)
    SCREEN_B:FadeOut(TimeSec(0), false)
    SCREEN_A:FadeIn(TimeSec(0.3), false)
    SCREEN_B:FadeIn(TimeSec(0.3), true)
    FlowSys:Next("DigMenuEnd")
    SOUND:VolumeBgm(Volume(256), TimeSec(0.8))
  end
  function FlowSys.Proc.DigMenuOutSideCansel()
    EventPlay.eventShopDigStartFall()
    FlowSys:Next("DigMenuEnd")
  end
  function FlowSys.Proc.DigMenuOutSide2Cansel()
    ShopSys:Talk(-1133427866, nil)
    GoodRateFlag = false
    FlowSys:Next("DigMenuEnd")
  end
  function FlowSys.Proc.DigMenuOutSideDestructionCansel()
    EventPlay.eventShopDigBuildingStartFall()
    FlowSys:Next("DigMenuEnd")
  end
  function FlowSys.Proc.DigMenuEnd()
    FlowSys:Return()
  end
  function EventPlay.eventShopDigStart()
    ShopSys:Talk(-128861419, nil)
    WINDOW:CloseMessage()
    subEveDoubleJump(CH("DIG_SHOP_OWNER"))
    ShopSys:Talk(-746788650, nil)
    WINDOW:CloseMessage()
    CH("DIG_SHOP_OWNER"):SetMotion(SymMot("SPEAK"), LOOP.ON)
    ShopSys:Talk(-899163753, nil)
    WINDOW:CloseMessage()
    CH("DIG_SHOP_OWNER"):SetMotion(SymMot("LETSGO"), LOOP.OFF)
    CH("DIG_SHOP_OWNER"):WaitPlayMotion()
  end
  function EventPlay.eventShopDigStartFall()
    CH("DIG_SHOP_OWNER"):SetManpu("MP_SWEAT_L")
    CH("DIG_SHOP_OWNER"):SetNeckRot(RotateTarget(0), RotateTarget(-35), RotateTarget(0), TimeSec(0.3))
    CH("DIG_SHOP_OWNER"):WaitNeckRot()
    ShopSys:Talk(-249298670, nil)
    WINDOW:CloseMessage()
    CH("DIG_SHOP_OWNER"):ResetNeckRot(TimeSec(0.15))
    CH("DIG_SHOP_OWNER"):WaitNeckRot()
    subEveJump(CH("DIG_SHOP_OWNER"))
    ShopSys:Talk(-636923183, nil)
    WINDOW:CloseMessage()
  end
  function EventPlay.eventShopDigBuildingStart()
    ShopSys:SetShopTag("\229\187\186\227\129\163\227\129\166\227\129\132\227\130\139\229\187\186\231\137\169", GROUND__2:GetText_DigBrokenShopName())
    CH("DIG_SHOP_OWNER"):SetMotion(SymMot("SPEAK"), LOOP.ON)
    ShopSys:Talk(-706591611, nil)
    ShopSys:Talk(-19982522, nil)
    WINDOW:CloseMessage()
  end
  function EventPlay.eventShopDigBuildingStartFall()
    CH("DIG_SHOP_OWNER"):SetManpu("MP_SWEAT_L")
    CH("DIG_SHOP_OWNER"):SetNeckRot(RotateTarget(0), RotateTarget(-35), RotateTarget(0), TimeSec(0.3))
    CH("DIG_SHOP_OWNER"):WaitNeckRot()
    ShopSys:Talk(1735596030, nil)
    WINDOW:CloseMessage()
    CH("DIG_SHOP_OWNER"):ResetNeckRot(TimeSec(0.15))
    CH("DIG_SHOP_OWNER"):WaitNeckRot()
    subEveJump(CH("DIG_SHOP_OWNER"))
    ShopSys:Talk(1281246269, nil)
    WINDOW:CloseMessage()
  end
  function EventPlay.eventShopDigDepthStart()
    ShopSys:Talk(1196014124, nil)
    WINDOW:CloseMessage()
    subEveDoubleJump(CH("DIG_SHOP_OWNER"))
  end
  function EventPlay.eventShopDigNoMoney1st()
    ShopSys:Talk(-805434278, nil)
    WINDOW:CloseMessage()
  end
  function EventPlay.eventShopDigThanks1st()
    subEveDoubleJump(CH("DIG_SHOP_OWNER"))
    ShopSys:Talk(1703757554, nil)
    WINDOW:CloseMessage()
  end
  if resumeFlow then
    FlowSys:Call(resumeFlow)
  else
    FlowSys:Call("DigMenuOutSideTop")
  end
  WINDOW:CloseMessage()
  FlowSys:Finish()
  ShopSys:Finish()
  LOWER_SCREEN:SetVisible(true)
end
function OpenDigMenuInSide(shopIns, landIndex, spaceIndex)
  local DIG_STATE = {
    DIG = 1,
    REWARD = 2,
    NOT_GET_ITEMS = 3
  }
  local DIG_PRICE_RATE_10M = 100
  local depth = 0
  local EventPlay = {}
  MENU:LoadMenuTextPool("message/shop.bin", false)
  MENU:LoadMenuTextPool("message/paradise_next_common.bin")
  FlowSys:Start()
  ShopSys:Start()
  ShopSys:SetParaideShopInstance(shopIns)
  function FlowSys.Proc.DigMenuInSideCheck()
    if shopIns:DigGetDungeonFlag() == false then
      if shopIns:GetTalk() then
        if shopIns:GetState() == DIG_STATE.DIG then
          ShopSys:Talk(-1855765031, nil)
          FlowSys:Next("DigMenuEnd")
        else
          FlowSys:Next("DigMenuInSideTop")
        end
      else
        shopIns:SetTalk(true)
        if shopIns:GetState() == DIG_STATE.REWARD or shopIns:GetState() == DIG_STATE.NOT_GET_ITEMS then
          FlowSys:Next("DigMenuDigTreasure")
        else
          FlowSys:Next("DigMenuInSideTop")
        end
      end
    else
      FlowSys:Next("TestDungeonFlow")
    end
  end
  function FlowSys.Proc.DigMenuInSideTop()
    CommonSys:OpenBasicMenu(nil, -1733859855, nil)
    ShopSys:TalkAskFlowNoClose(1136885316, FACE_TYPE.NORMAL, {cursorReset = true}, {
      next = "DigMenuFinish"
    }, {text = -1117351442, next = "DigMenuDig"}, {
      text = 1274797384,
      next = "DigMenuHelp"
    })
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.DigMenuInSideTopLoop()
    CommonSys:OpenBasicMenu(nil, -1733859855, nil)
    ShopSys:TalkAskFlowNoClose(-1999523329, FACE_TYPE.NORMAL, {cursorReset = true}, {
      next = "DigMenuFinish"
    }, {text = -596324825, next = "DigMenuDig"}, {
      text = -1441293256,
      next = "DigMenuHelp"
    })
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.DigMenuDigTreasure()
    if shopIns:IsItemHit() then
      EventPlay.eventShopDigDetectItem()
      FlowSys:Next("DigMenuGetItems")
    elseif shopIns:IsDungeonHit() then
      FlowSys:Next("DigMenuGetDungeon")
    else
      EventPlay.eventShopDigDetectNo()
      FlowSys:Next("DigMenuInSideTopLoop")
    end
  end
  function FlowSys.Proc.DigMenuGetItems()
    if shopIns:IsItemHit() then
      local item = shopIns:GetDigItemId()
      local num = shopIns:GetDigItemCount()
      OverFlow:AddOverflowCheckItem(item, num, true)
      SOUND:PlayMe(SymSnd("ME_REWARD"))
      shopIns:DeleteCurrentDigItem()
      SOUND:WaitMe()
      FlowSys:Next("DigMenuGetItems")
    elseif shopIns:IsDungeonHit() then
      OverFlow:OpenOrderOverflowMenu(true)
      EventPlay.eventShopDigDetectDungeon()
      FlowSys:Next("DigMenuGetDungeon")
    else
      OverFlow:OpenOrderOverflowMenu(true)
      FlowSys:Next("DigMenuInSideTopLoop")
    end
  end
  function FlowSys.Proc.DigMenuGetDungeon()
    SOUND:PlayMe(SymSnd("ME_EVT_DAN_01"))
    ShopSys:Talk(1869255562, nil)
    WINDOW:KeyWait()
    SOUND:PlayMe(SymSnd("ME_DUNGEON_OPEN"))
    ShopSys:SysMsg(1090617947, nil)
    SOUND:WaitMe()
    WINDOW:KeyWait()
    ShopSys:Talk(815817799, nil)
    shopIns:DigSetDungeonFlag(true)
    FlowSys:Next("DigMenuDeleteDungeon")
  end
  function FlowSys.Proc.DigMenuDeleteDungeon()
    FlowSys:Next("DigMenuEnd")
  end
  function FlowSys.Proc.DigMenuDig()
    FlowSys:Next("DigMenuSelectDigDepth")
  end
  function FlowSys.Proc.DigMenuSelectDigDepth()
    depth = 0
    CommonSys:OpenBasicMenu(nil, 1331611147, nil)
    ShopSys:TalkAskFlowNoClose(349454646, FACE_TYPE.NORMAL, {cursorReset = true}, {
      next = "DigMenuInSideTopLoop"
    }, {
      text = 1251503404,
      next = "DigMenuDepthSelect10"
    }, {
      text = -973407621,
      next = "DigMenuDepthSelect50"
    }, {
      text = -1800595233,
      next = "DigMenuDepthSelect100"
    })
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.DigMenuDepthSelect10()
    depth = 1
    FlowSys:Next("DigMenuDecideDigDepth")
  end
  function FlowSys.Proc.DigMenuDepthSelect50()
    depth = 5
    FlowSys:Next("DigMenuDecideDigDepth")
  end
  function FlowSys.Proc.DigMenuDepthSelect100()
    depth = 10
    FlowSys:Next("DigMenuDecideDigDepth")
  end
  function FlowSys.Proc.DigMenuDecideDigDepth()
    local price = DIG_PRICE_RATE_10M * depth
    MENU:SetTag_Value(0, depth * 10)
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\230\183\177\227\129\149", MENU:ReplaceTagText("[value_b:0]"))
    MENU:SetTag_Money(0, price)
    ShopSys:SetShopTag("\229\144\136\232\168\136\232\179\188\229\133\165\233\161\141", MENU:ReplaceTagText("[st_money:0]"))
    ShopSys:DispMoneyWindowOpen()
    ShopSys:TalkAskFlowNoClose(910417198, nil, nil, {
      next = "DigMenuSelectDigDepth"
    }, {
      text = 2126309025,
      next = "DigMenuCheckEnoughMoneyForDepth"
    }, {
      text = -1514875366,
      next = "DigMenuSelectDigDepth",
      default = true
    })
    ShopSys:DispMoneyWindowClose()
  end
  function FlowSys.Proc.DigMenuCheckEnoughMoneyForDepth()
    local price = DIG_PRICE_RATE_10M * depth
    if price <= GROUND:GetPlayerMoney() then
      GROUND:SetPlayerMoney(GROUND:GetPlayerMoney() - price)
      shopIns:SetDigCount(depth)
      EventPlay.eventShopDigThanks()
      FlowSys:Next("DigMenuEnd")
    else
      EventPlay.eventShopDigNoMoney()
      FlowSys:Next("DigMenuSelectDigDepth")
    end
  end
  function FlowSys.Proc.TestDungeonFlow()
    ShopSys:Talk(-1630880854, nil)
    WINDOW:CloseMessage()
    ShopSys:SysMsg(463461163, nil)
    WINDOW:CloseMessage()
    if FLAG.ParaLandType == CONST.PARA_LAND_TYPE_PRAIRIE then
      ShopSys:Talk(-1632864485, nil)
      WINDOW:CloseMessage()
    elseif FLAG.ParaLandType == CONST.PARA_LAND_TYPE_WATER then
      ShopSys:Talk(1518281761, nil)
      WINDOW:CloseMessage()
    elseif FLAG.ParaLandType == CONST.PARA_LAND_TYPE_ROCKY_HILL then
      ShopSys:Talk(-719054582, nil)
      WINDOW:CloseMessage()
    elseif FLAG.ParaLandType == CONST.PARA_LAND_TYPE_FOREST then
      ShopSys:Talk(1351267353, nil)
      WINDOW:CloseMessage()
    end
    if MULTI_PLAY:IsLogined() then
      ShopSys:SysMsg(9)
      FlowSys:Next("DigMenuFinish")
    else
      ShopSys:TalkAskFlowNoClose(-1870036004, nil, nil, {
        next = "DigMenuFinish"
      }, {
        text = -15978344,
        next = "DungeonExplore"
      }, {
        text = -1094176750,
        next = "DigMenuFinish",
        default = true
      })
    end
  end
  function FlowSys.Proc.DungeonExplore()
    ShopSys:Talk(-1433268525, nil)
    WINDOW:CloseMessage()
    SOUND:FadeOutBgm(TimeSec(0.5))
    SCREEN_A:FadeOutAll(TimeSec(0.5), false)
    SCREEN_B:FadeOutAll(TimeSec(0.5), true)
    SCREEN_B:FadeOut(TimeSec(0), false)
    SCREEN_A:FadeOut(TimeSec(0), false)
    GROUND:BrokenLandShopWaitNone(GROUND:GetNowLandIndex(), spaceIndex)
    CAMERA:ResetAzimuthDifferenceVolume()
    subMapCameraDefMode()
    SYSTEM:ResetRescueCount()
    SYSTEM:IncAdventureCount()
    FUNC_COMMON:SetSdmcEnable(false)
    if FLAG.ParaLandType == CONST.PARA_LAND_TYPE_PRAIRIE then
      SYSTEM:EnterDungeon(Dg(83))
    elseif FLAG.ParaLandType == CONST.PARA_LAND_TYPE_WATER then
      SYSTEM:EnterDungeon(Dg(84))
    elseif FLAG.ParaLandType == CONST.PARA_LAND_TYPE_ROCKY_HILL then
      SYSTEM:EnterDungeon(Dg(85))
    elseif FLAG.ParaLandType == CONST.PARA_LAND_TYPE_FOREST then
      SYSTEM:EnterDungeon(Dg(86))
    end
    FlowSys:Next("DigMenuEnd")
  end
  function FlowSys.Proc.DigMenuHelp()
    ShopSys:Talk(-1839105071, nil)
    WINDOW:CloseMessage()
    FlowSys:Next("DigMenuInSideTopLoop")
  end
  function FlowSys.Proc.DigMenuFinish()
    ShopSys:Talk(-442611085, nil)
    FlowSys:Next("DigMenuEnd")
  end
  function FlowSys.Proc.DigMenuEnd()
    FlowSys:Return()
  end
  function EventPlay.eventShopDigNoMoney()
    ShopSys:Talk(-805434278, nil)
    WINDOW:CloseMessage()
  end
  function EventPlay.eventShopDigThanks()
    subEveDoubleJump(CH(shopIns:GetOwnerSymbol()))
    ShopSys:Talk(-939529500, nil)
    WINDOW:CloseMessage()
  end
  function EventPlay.eventShopDigDetectNo()
    local SHOP_OWNER = CH(string.format("LAND_SHOP_STAFF_%02d", spaceIndex))
    local POINT_CENTER = SymPos(string.format("@SHOP_CENTER%02d", spaceIndex))
    local SHOP_OWNER_DEF = SHOP_OWNER:GetDir()
    ShopSys:Talk(-686229747, nil)
    WINDOW:CloseMessage()
    SHOP_OWNER:DirTo(POINT_CENTER, Speed(500), ROT_TYPE.NEAR)
    SHOP_OWNER:SetNeckRot(RotateTarget(0), RotateTarget(-35), RotateTarget(0), TimeSec(0.3))
    SHOP_OWNER:WaitNeckRot()
    SOUND:PlaySe(SymSnd("SE_EVT_SIGN_SWEAT"))
    SHOP_OWNER:SetManpu("MP_SWEAT_L")
    ShopSys:Talk(-63593266, nil)
    ShopSys:Talk(-449931889, nil)
    WINDOW:CloseMessage()
    SHOP_OWNER:ResetNeckRot(TimeSec(0.15))
    SHOP_OWNER:WaitNeckRot()
    SHOP_OWNER:DirTo(RotateTarget(SHOP_OWNER_DEF), Speed(500), ROT_TYPE.NEAR)
    SHOP_OWNER:WaitRotate()
  end
  function EventPlay.eventShopDigDetectItem()
    local SHOP_OWNER = CH(string.format("LAND_SHOP_STAFF_%02d", spaceIndex))
    subEveJump(CH(shopIns:GetOwnerSymbol()))
    SHOP_OWNER:SetManpu("MP_LAUGH_LP")
    ShopSys:Talk(-1718762101, nil)
    WINDOW:CloseMessage()
    SHOP_OWNER:ResetManpu()
  end
  function EventPlay.eventShopDigDetectDungeon()
    subEveDoubleJump(CH(shopIns:GetOwnerSymbol()))
    ShopSys:Talk(291117501, nil)
    WINDOW:CloseMessage()
  end
  FlowSys:Call("DigMenuInSideCheck")
  WINDOW:CloseMessage()
  FlowSys:Finish()
  ShopSys:Finish()
end
