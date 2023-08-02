function OpenQuestCounterMenu(optTbl)
  if optTbl == nil then
    optTbl = {}
  end
  if optTbl.isBoard == nil then
    optTbl.isBoard = false
  end
  if optTbl.questSelectIndex == nil then
    optTbl.questSelectIndex = -1
  end
  local EventPlay = {}
  MENU:LoadMenuTextPool("message/shop.bin", false)
  SCREEN_B:FadeOut(TimeSec(0.1, TIME_TYPE.FRAME), true)
  SCREEN_B:LoadWallpaper("WALLPAPER_SUB_COUNTER01")
  SCREEN_B:FadeIn(TimeSec(0.1, TIME_TYPE.FRAME), false)
  MENU:SetTag_String(7, "[player]")
  FlowSys:Start()
  ShopSys:Start()
  ShopSys:SetOwner("MARIRURI", "\227\131\158\227\131\170\227\131\171\227\131\170")
  FlowSys.Stat.questSelectIndex = optTbl.questSelectIndex
  function FlowSys.Proc.error()
    QUEST:ResetCurrentQuestInfo()
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.branch()
    if QUEST:IsCurrentQuestInfo() then
      FlowSys:Next("cancel")
    else
      FlowSys:Next("welcome")
    end
  end
  function FlowSys.Proc.welcome()
    CommonSys:OpenBasicMenu(nil, -1733859855, nil)
    ShopSys:TalkAskFlowNoClose(-560474423, FACE_TYPE.NORMAL, nil, {next = "exit"}, {text = -1427493779, next = "go"}, {text = 1477416397, next = "helpA"})
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.series()
    CommonSys:OpenBasicMenu(nil, -1733859855, nil)
    ShopSys:TalkAskFlowNoClose(-2078154705, FACE_TYPE.NORMAL, nil, {next = "exit"}, {text = 497296372, next = "go"}, {text = -1461438342, next = "helpA"})
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.cancel()
    MENU:SetTag_String(5, QUEST:GetCurrentQuestInfo_TitleStr())
    if MULTI_PLAY:IsLogined() then
      FlowSys:Next("onlineCancel")
    else
      FlowSys:Next("offlineCancel")
    end
  end
  function FlowSys.Proc.offlineCancel()
    ShopSys:TalkAskFlowNoClose(1117187376, FACE_TYPE.NORMAL, nil, {next = "exit"}, {
      text = -246436999,
      next = "removePrepare"
    }, {text = 2134606928, next = "exit"})
  end
  function FlowSys.Proc.onlineCancel()
    repeat
      ShopSys:TalkAskFlowNoClose(138312119, FACE_TYPE.NORMAL, nil, {next = "exit"}, {
        text = 1413129982,
        next = "removePrepareOnlineConfirm"
      }, {text = -1378215908, next = "exit"})
      do break end -- pseudo-goto
      ShopSys:TalkAskFlowNoClose(-1699750011, FACE_TYPE.NORMAL, nil, {next = "exit"}, {
        text = -900356804,
        next = "removePrepareOnlineConfirm"
      }, {text = -530301229, next = "exit"})
    until true
  end
  function FlowSys.Proc.go()
    if QUEST:GetQuestListSize_MyList() ~= 0 then
      ShopSys:Talk(334039005)
      FlowSys.Stat.isARMyList = false
      FlowSys:Next("questSelect")
    else
      ShopSys:Talk(-1154946758)
      WINDOW:CloseMessage()
      FlowSys:Next("series")
    end
  end
  function FlowSys.Proc.questSelect()
    WINDOW:CloseMessage()
    FlowSys.Stat.questSelectIndex = -1
    local decideFunc = function(optTbl)
      FlowSys.Stat.questSelectIndex = optTbl.self.curItem.obj.index
      MENU:SetTag_String(6, QUEST:GetQuestInfo_TitleStr(FlowSys.Stat.questSelectIndex))
      SCREEN_A:FadeOutAll(TimeSec(4, TIME_TYPE.FRAME), false)
      SCREEN_B:FadeOutAll(TimeSec(4, TIME_TYPE.FRAME), true)
      optTbl.self:Close()
    end
    OpenQuestMyListMenu({
      parentMenu = nil,
      decideActionFunc = decideFunc,
      isARMyList = FlowSys.Stat.isARMyList,
      isWallPaper = true,
      basicTitle = -72242842,
      basicPadHelp = 389984035,
      basicLineHelp = nil,
      bFadeStart = true,
      bFadeEnd = true
    })
    if FlowSys.Stat.questSelectIndex == -1 then
      FlowSys:Next("series")
      return
    else
      FlowSys:Next("questLimit")
      return
    end
  end
  function FlowSys.Proc.questLimit()
    CheckQuestLimit(FlowSys.Stat.questSelectIndex, function()
      FlowSys:Next("questLimitConfirm")
    end, function()
      FlowSys:Next("doubleConditionAct")
    end, nil, function()
      FlowSys:Next("multiOnlyAct")
    end, function()
      FlowSys:Next("ownerPartyAct")
    end, function()
      FlowSys:Next("itemMaxConditionAct")
    end, function()
      FlowSys:Next("noItemConditionAct")
    end, function()
      FlowSys:Next("noMemberTypeAct")
    end, function()
      FlowSys:Next("levelConditionUpAct")
    end, function()
      FlowSys:Next("levelConditionDownAct")
    end, function()
      FlowSys:Next("onlyMemberAct")
    end, function()
      FlowSys:Next("noMemberOverAct")
    end, function()
      FlowSys:Next("multiConditonAct")
    end)
  end
  function FlowSys.Proc.doubleConditionAct()
    CH("MARIRURI"):SetManpu("MP_FLY_SWEAT")
    ShopSys:Talk(2086386455, FACE_TYPE.SURPRISE)
    if optTbl.isBoard == false then
      ShopSys:TalkAskFlowNoClose(1467410644, FACE_TYPE.NORMAL, nil, {next = "back"}, {
        text = 1121576952,
        next = "questSelect"
      }, {text = 1174878400, next = "back"})
    else
      FlowSys:Next("back")
    end
  end
  function FlowSys.Proc.noMultiAct()
    CH("MARIRURI"):SetManpu("MP_SHOCK_L")
    ShopSys:Talk(1464600602, FACE_TYPE.SAD)
    WINDOW:KeyWait()
    FlowSys:Next("back")
  end
  function FlowSys.Proc.multiOnlyAct()
    CH("MARIRURI"):SetManpu("MP_SHOCK_L")
    ShopSys:Talk(-1608371428, FACE_TYPE.SAD)
    WINDOW:KeyWait()
    FlowSys:Next("back")
  end
  function FlowSys.Proc.ownerPartyAct()
    CH("MARIRURI"):SetManpu("MP_SHOCK_L")
    ShopSys:Talk(422363715, FACE_TYPE.SAD)
    WINDOW:KeyWait()
    FlowSys:Next("back")
  end
  function FlowSys.Proc.itemMaxConditionAct()
    MENU:SetTag_String(8, QUEST:GetQuestInfo_LimitType_CarryNum(FlowSys.Stat.questSelectIndex) .. "")
    ShopSys:TalkAskFlowNoClose(1069349451, FACE_TYPE.NORMAL, nil, {next = "back"}, {
      text = 91850449,
      next = "itemMaxConditionNgAna"
    }, {text = 1605928601, next = "back"})
  end
  function FlowSys.Proc.itemMaxConditionNgAna()
    ShopSys:Talk(999116644)
    FlowSys:Next("prepare")
  end
  function FlowSys.Proc.noItemConditionAct()
    ShopSys:TalkAskFlowNoClose(-969643118, FACE_TYPE.NORMAL, nil, {next = "back"}, {
      text = -497863945,
      next = "noItemConditionNgAna"
    }, {text = 337056597, next = "back"})
  end
  function FlowSys.Proc.noItemConditionNgAna()
    ShopSys:Talk(1813876452)
    FlowSys:Next("prepare")
  end
  function FlowSys.Proc.noMemberTypeAct()
    MENU:SetTag_String(9, MENU:ReplaceTagText("[type:" .. QUEST:GetQuestInfo_LimitType_TypeIndex(FlowSys.Stat.questSelectIndex) .. "]"))
    if QUEST:IsQuestInfo_Limit_NoMemberType_Possible(FlowSys.Stat.questSelectIndex) then
      ShopSys:TalkAskFlowNoClose(32127746, FACE_TYPE.NORMAL, nil, {next = "back"}, {
        text = -1660475867,
        next = "noMemberTypeNgAna"
      }, {text = 1661568178, next = "back"})
    else
      ShopSys:Talk(717906737)
      WINDOW:KeyWait()
      FlowSys:Next("back")
    end
  end
  function FlowSys.Proc.noMemberTypeNgAna()
    ShopSys:Talk(-1119242982)
    FlowSys:Next("prepare")
  end
  function FlowSys.Proc.levelConditionUpAct()
    MENU:SetTag_String(10, QUEST:GetQuestInfo_LimitType_LvOver(FlowSys.Stat.questSelectIndex) .. "")
    if QUEST:IsQuestInfo_Limit_LevelConditionUp_Possible(FlowSys.Stat.questSelectIndex) then
      ShopSys:TalkAskFlowNoClose(1988108317, FACE_TYPE.NORMAL, nil, {next = "back"}, {
        text = -1076306571,
        next = "levelConditionUpNgAna"
      }, {text = -2086863907, next = "back"})
    else
      ShopSys:Talk(6485051)
      WINDOW:KeyWait()
      FlowSys:Next("back")
    end
  end
  function FlowSys.Proc.levelConditionUpNgAna()
    ShopSys:Talk(-874649632)
    FlowSys:Next("prepare")
  end
  function FlowSys.Proc.levelConditionDownAct()
    MENU:SetTag_String(10, QUEST:GetQuestInfo_LimitType_LvUnder(FlowSys.Stat.questSelectIndex) .. "")
    if QUEST:IsQuestInfo_Limit_LevelConditionDown_Possible(FlowSys.Stat.questSelectIndex) then
      ShopSys:TalkAskFlowNoClose(1127124631, FACE_TYPE.NORMAL, nil, {next = "back"}, {
        text = 543206204,
        next = "levelConditionDownNgAna"
      }, {text = 2092213465, next = "back"})
    else
      ShopSys:Talk(-35149367)
      WINDOW:KeyWait()
      FlowSys:Next("back")
    end
  end
  function FlowSys.Proc.levelConditionDownNgAna()
    ShopSys:Talk(-1148112749)
    FlowSys:Next("prepare")
  end
  function FlowSys.Proc.onlyMemberAct()
    ShopSys:Talk(2142602016, FACE_TYPE.NORMAL)
    FlowSys:Next("clearAct")
  end
  function FlowSys.Proc.noMemberOverAct()
    MENU:SetTag_String(11, QUEST:GetQuestInfo_LimitType_PeopleNum(FlowSys.Stat.questSelectIndex) .. "")
    ShopSys:TalkAskFlowNoClose(-1289123951, FACE_TYPE.NORMAL, nil, {next = "back"}, {
      text = 648447885,
      next = "noMemberOverNgAna"
    }, {text = -1880199460, next = "back"})
  end
  function FlowSys.Proc.noMemberOverNgAna()
    ShopSys:Talk(966655790)
    FlowSys:Next("prepare")
  end
  function FlowSys.Proc.multiConditonAct()
    ShopSys:Talk(1855299695)
    WINDOW:CloseMessage()
    FlowSys:Next("clearAct")
  end
  function FlowSys.Proc.questLimitConfirm()
    ConfirmQuestLimit(FlowSys.Stat.questSelectIndex, function()
      FlowSys:Next("dungeonLimit")
    end, function()
      MENU:SetTag_String(8, QUEST:GetQuestInfo_LimitType_CarryNum(FlowSys.Stat.questSelectIndex) .. "")
      ShopSys:Talk(-1173036155)
      FlowSys:Next("clearAct")
    end, function()
      ShopSys:Talk(-310107643)
      FlowSys:Next("clearAct")
    end, function()
      MENU:SetTag_String(9, MENU:ReplaceTagText("[type:" .. QUEST:GetQuestInfo_LimitType_TypeIndex(FlowSys.Stat.questSelectIndex) .. "]"))
      ShopSys:Talk(1020271099)
      FlowSys:Next("clearAct")
    end, function()
      MENU:SetTag_String(10, QUEST:GetQuestInfo_LimitType_LvOver(FlowSys.Stat.questSelectIndex) .. "")
      ShopSys:Talk(1245989633)
      FlowSys:Next("clearAct")
    end, function()
      MENU:SetTag_String(10, QUEST:GetQuestInfo_LimitType_LvUnder(FlowSys.Stat.questSelectIndex) .. "")
      ShopSys:Talk(973642866)
      FlowSys:Next("clearAct")
    end, function()
      ShopSys:Talk(-30658623)
      FlowSys:Next("clearAct")
    end, function()
      MENU:SetTag_String(11, QUEST:GetQuestInfo_LimitType_PeopleNum(FlowSys.Stat.questSelectIndex) .. "")
      ShopSys:Talk(-1207675953)
      FlowSys:Next("clearAct")
    end)
  end
  function FlowSys.Proc.dungeonLimit()
    FlowSys.Stat.ngLimit = false
    FlowSys.Stat.blockItemAndMoney = false
    FlowSys.Stat.blockMemberCount = false
    FlowSys.Stat.assertLevelReset = false
    local dungeonIndex = QUEST:GetQuestInfo_UseDungeon(FlowSys.Stat.questSelectIndex)
    local itemLimitNum = GROUND:GetItemLimitCount(dungeonIndex)
    local partyLimitNum = GROUND:GetDungeonPartyLimitCount(dungeonIndex)
    CheckDungeonLimit(dungeonIndex, function()
    end, function()
      FlowSys.Stat.blockItemAndMoney = true
      FlowSys.Stat.ngLimit = true
    end, nil, nil)
    CheckDungeonLimit(dungeonIndex, function()
    end, nil, function()
      FlowSys.Stat.blockMemberCount = true
      FlowSys.Stat.ngLimit = true
    end, nil)
    CheckDungeonLimit(dungeonIndex, function()
    end, nil, nil, function()
      FlowSys.Stat.assertLevelReset = true
    end)
    if itemLimitNum == 0 and partyLimitNum == 1 then
      FlowSys:Next("dungeonItemAndMoneyAndOnly")
    elseif itemLimitNum == 0 and partyLimitNum < 4 then
      FlowSys:Next("dungeonItemAndMoneyAndMemberOver")
    elseif itemLimitNum == 0 then
      FlowSys:Next("dungeonItemAndMoney")
    elseif partyLimitNum == 1 then
      FlowSys:Next("dungeonOnly")
    elseif partyLimitNum < 4 then
      FlowSys:Next("dungeonMemberOver")
    else
      FlowSys:Next("dungeonNoLimit")
    end
  end
  function FlowSys.Proc.dungeonItemAndMoneyAndOnly()
    if FlowSys.Stat.ngLimit == true then
      ShopSys:TalkAskFlowNoClose(-1295533567, FACE_TYPE.NORMAL, nil, {next = "back"}, {
        text = -776166228,
        next = "dungeonItemAndMoneyAndOnlyNgAna"
      }, {text = -61122412, next = "back"})
    else
      ShopSys:Talk(2109342246)
      if FlowSys.Stat.assertLevelReset == true then
        ShopSys:Talk(-14111853)
      end
      FlowSys:Next("clearAct")
    end
  end
  function FlowSys.Proc.dungeonItemAndMoneyAndOnlyNgAna()
    if FlowSys.Stat.blockItemAndMoney == true and FlowSys.Stat.blockMemberCount == true then
      ShopSys:Talk(86890861)
    elseif FlowSys.Stat.blockItemAndMoney == true and FlowSys.Stat.blockMemberCount == false then
      ShopSys:Talk(-1637410686)
    elseif FlowSys.Stat.blockItemAndMoney == false and FlowSys.Stat.blockMemberCount == true then
      ShopSys:Talk(-1857018899)
    end
    if FlowSys.Stat.assertLevelReset == true then
      ShopSys:Talk(-14111853)
    end
    FlowSys:Next("prepare")
  end
  function FlowSys.Proc.dungeonItemAndMoneyAndMemberOver()
    MENU:SetTag_String(11, GROUND:GetDungeonPartyLimitCount(QUEST:GetQuestInfo_UseDungeon(FlowSys.Stat.questSelectIndex)) .. "")
    if FlowSys.Stat.ngLimit == true then
      ShopSys:TalkAskFlowNoClose(-108594799, FACE_TYPE.NORMAL, nil, {next = "back"}, {
        text = 1626918696,
        next = "dungeonItemAndMoneyAndMemberOverNgAna"
      }, {text = -1593233097, next = "back"})
    else
      ShopSys:Talk(-963425799)
      if FlowSys.Stat.assertLevelReset == true then
        ShopSys:Talk(-14111853)
      end
      FlowSys:Next("clearAct")
    end
  end
  function FlowSys.Proc.dungeonItemAndMoneyAndMemberOverNgAna()
    if FlowSys.Stat.blockItemAndMoney == true and FlowSys.Stat.blockMemberCount == true then
      ShopSys:Talk(-581439606)
    elseif FlowSys.Stat.blockItemAndMoney == true and FlowSys.Stat.blockMemberCount == false then
      ShopSys:Talk(-1460587589)
    elseif FlowSys.Stat.blockItemAndMoney == false and FlowSys.Stat.blockMemberCount == true then
      ShopSys:Talk(-1480193836)
    end
    if FlowSys.Stat.assertLevelReset == true then
      ShopSys:Talk(-14111853)
    end
    FlowSys:Next("prepare")
  end
  function FlowSys.Proc.dungeonItemAndMoney()
    if FlowSys.Stat.ngLimit == true then
      ShopSys:TalkAskFlowNoClose(-926469430, FACE_TYPE.NORMAL, nil, {next = "back"}, {
        text = -18111690,
        next = "dungeonItemAndMoneyNgAna"
      }, {text = 1602527286, next = "back"})
    else
      ShopSys:Talk(380427733)
      if FlowSys.Stat.assertLevelReset == true then
        ShopSys:Talk(-14111853)
      end
      FlowSys:Next("clearAct")
    end
  end
  function FlowSys.Proc.dungeonItemAndMoneyNgAna()
    if FlowSys.Stat.blockItemAndMoney == true then
      ShopSys:Talk(-1758105292)
    end
    if FlowSys.Stat.assertLevelReset == true then
      ShopSys:Talk(-14111853)
    end
    FlowSys:Next("prepare")
  end
  function FlowSys.Proc.dungeonOnly()
    if FlowSys.Stat.ngLimit == true then
      FlowSys:Next("dungeonOnlyNgAna")
    else
      ShopSys:Talk(1546205278)
      if FlowSys.Stat.assertLevelReset == true then
        ShopSys:Talk(-14111853)
      end
      FlowSys:Next("clearAct")
    end
  end
  function FlowSys.Proc.dungeonOnlyNgAna()
    if FlowSys.Stat.blockMemberCount == true then
      ShopSys:Talk(-575630145)
    end
    if FlowSys.Stat.assertLevelReset == true then
      ShopSys:Talk(-14111853)
    end
    FlowSys:Next("clearAct")
  end
  function FlowSys.Proc.dungeonMemberOver()
    MENU:SetTag_String(11, GROUND:GetDungeonPartyLimitCount(QUEST:GetQuestInfo_UseDungeon(FlowSys.Stat.questSelectIndex)) .. "")
    if FlowSys.Stat.ngLimit == true then
      ShopSys:TalkAskFlowNoClose(-600156210, FACE_TYPE.NORMAL, nil, {next = "back"}, {
        text = -1622936309,
        next = "dungeonMemberOverNgAna"
      }, {text = -85663797, next = "back"})
    else
      ShopSys:Talk(-657366224)
      if FlowSys.Stat.assertLevelReset == true then
        ShopSys:Talk(-14111853)
      end
      FlowSys:Next("clearAct")
    end
  end
  function FlowSys.Proc.dungeonMemberOverNgAna()
    if FlowSys.Stat.blockMemberCount == true then
      ShopSys:Talk(1497944017)
    end
    if FlowSys.Stat.assertLevelReset == true then
      ShopSys:Talk(-14111853)
    end
    FlowSys:Next("prepare")
  end
  function FlowSys.Proc.dungeonNoLimit()
    if FlowSys.Stat.assertLevelReset == true then
      ShopSys:Talk(465950214)
    end
    FlowSys:Next("clearAct")
  end
  function FlowSys.Proc.clearAct()
    if optTbl.isBoard == true then
      FlowSys:Next("prepare")
    else
      ShopSys:TalkAskFlowNoClose(1921011938, FACE_TYPE.NORMAL, nil, {next = "back"}, {text = -2139378312, next = "prepare"}, {text = -1719461886, next = "back"})
    end
  end
  function FlowSys.Proc.prepare()
    WINDOW:CloseMessage()
    QUEST:SetCurrentQuestInfo(FlowSys.Stat.questSelectIndex)
    FlowSys:Next("multiPlayConfirm")
  end
  function FlowSys.Proc.multiPlayConfirm()
    if MULTI_PLAY:IsLogined() then
      FlowSys:Next("prepareMulti")
    else
      FlowSys:Next("openGate")
    end
  end
  function FlowSys.Proc.prepareMulti()
    QUEST:SetOnlineQuestSeed()
    FlowSys:Next("multiPlayEntry")
  end
  function FlowSys.Proc.multiPlayEntry()
    local resumeFlowSysData = FlowSys:Suspend()
    local resumeShopSysData = ShopSys:Suspend()
    local nextFlow = "back"
    OpenMultiPlaySynchronizeMenu_Dungeon(function()
      nextFlow = "host_matchingFinish"
    end, function()
      nextFlow = "matchingCancel"
    end, function()
      nextFlow = "matchingCancel"
    end, function()
      nextFlow = "error"
    end)
    FlowSys:Resume(resumeFlowSysData)
    ShopSys:Resume(resumeShopSysData)
    FlowSys:Next(nextFlow)
  end
  function FlowSys.Proc.matchingCancel()
    QUEST:ResetCurrentQuestInfo()
    FlowSys:Next("back")
  end
  function FlowSys.Proc.openGate()
    WINDOW:ForceCloseMessage()
    if QUEST:IsQuestInfo_Multi(FlowSys.Stat.questSelectIndex) then
      SCREEN_B:FadeOut(TimeSec(0.3), true)
      EventPlay.eventShopMarirurileftGate(face)
    else
      SCREEN_B:FadeOut(TimeSec(0.3), true)
      EventPlay.eventShopMariruriRightGate(face)
    end
    ShopSys:Talk(1176109234)
    if optTbl.isBoard == true then
      FlowSys:Next("toBoard")
    else
      WINDOW:CloseMessage()
      subSpWait(TimeSec(0.3))
      SCREEN_B:FadeIn(TimeSec(0.3), false)
      FlowSys:Return()
    end
  end
  function FlowSys.Proc.removePrepareOnlineConfirm()
    if MULTI_PLAY:SyncMultiPlayQuestCancel() then
      if QUEST:IsCurrentQuestInfo() then
        FlowSys:Next("removePrepare")
      else
        ShopSys:Talk(1422776724)
        FlowSys:Next("exit")
      end
    else
      ShopSys:Talk(219152515)
      FlowSys:Next("exit")
    end
  end
  function FlowSys.Proc.removePrepare()
    if QUEST:IsCurrentQuestInfo_Multi() then
      GM("TOMODACHI_GATE"):SetMotion(SymMot("close"), LOOP.OFF)
    else
      GM("IRAI_GATE"):SetMotion(SymMot("close"), LOOP.OFF)
    end
    QUEST:ResetCurrentQuestInfo()
    repeat
      if MULTI_PLAY:IsLogined() then
        ShopSys:Talk(-458326900)
        WINDOW:CloseMessage()
        do break end -- pseudo-goto
        ShopSys:Talk(1810287436)
        WINDOW:CloseMessage()
      else
        ShopSys:Talk(-1663478920)
        WINDOW:CloseMessage()
      end
    until true
    FlowSys:Next("series")
  end
  function FlowSys.Proc.helpA()
    ShopSys:Talk(-216850753)
    WINDOW:CloseMessage()
    FlowSys:Next("series")
  end
  function FlowSys.Proc.helpB()
    ShopSys:Talk(-667005572)
    WINDOW:CloseMessage()
    FlowSys:Next("series")
  end
  function FlowSys.Proc.back()
    if optTbl.isBoard == true then
      FlowSys:Next("toBoard")
    else
      FlowSys:Next("series")
    end
  end
  function FlowSys.Proc.exit()
    ShopSys:Talk(1427129007)
    WINDOW:CloseMessage()
    FlowSys:Return()
  end
  function FlowSys.Proc.boardFrom()
    EventPlay.eventShopMariruriQuickReserve()
    FlowSys:Next("questLimit")
  end
  function FlowSys.Proc.toBoard()
    if QUEST:IsCurrentQuestIndex(FlowSys.Stat.questSelectIndex) then
    else
      ShopSys:Talk(-43397706)
    end
    WINDOW:CloseMessage()
    if CHARA:IsExist("HERO") then
      CH("HERO"):DirTo(SymPos("P_EFFECT_KEIJIBAN_R"), Speed(500))
    end
    if CHARA:IsExist("PLAYER") then
      CH("PLAYER"):DirTo(SymPos("P_EFFECT_KEIJIBAN_R"), Speed(500))
    end
    if CHARA:IsExist("PARTNER") then
      CH("PARTNER"):DirTo(SymPos("P_EFFECT_KEIJIBAN_R"), Speed(500))
    end
    subUsuComFuncTalkOutBase01(CH("MARIRURI"), FlowSys.Stat.result)
    subSpWait(TimeSec(0.3))
    SCREEN_B:FadeIn(TimeSec(0.3), false)
    FlowSys:Return()
  end
  function FlowSys.Proc.host_matchingFinish()
    SPRITE:DestroySprite("upperBg_Board")
    SPRITE:DestroyPatternSet("upperSet_Board")
    FLAG.MultiSpecialFlag = CONST.EVENT_MULTI_CALL
    FLAG.MapFlags = CONST.MAP_EVENT
    SYSTEM:NextEntry()
    FlowSys:Return()
  end
  function EventPlay.eventShopMariruriRightGate(face)
    WINDOW:RemoveFace()
    CAMERA:SetEye(SymCam("CAMERA_IRAI_GATE"))
    CAMERA:SetTgt(SymCam("CAMERA_IRAI_GATE"))
    subSpWait(TimeSec(0.5))
    if FLAG.ParaCenterLv == CONST.PARA_CENTER_LV_04 then
      GM("TOMODACHI_GATE"):SetMotion(SymMot("close"), LOOP.OFF)
    end
    GM("IRAI_GATE"):SetMotion(SymMot("open"), LOOP.OFF)
    SOUND:PlaySe(SymSnd("SE_EVT_OPEN_GATE"), Volume(256))
    GM("IRAI_GATE"):WaitPlayMotion()
    subSpWait(TimeSec(0.5))
    subMapCameraSet()
    CAMERA:MoveToPlayer(TimeSec(0), ACCEL_TYPE.NONE, DECEL_TYPE.NONE)
    subSpWait(TimeSec(0.3))
  end
  function EventPlay.eventShopMarirurileftGate(face)
    WINDOW:ForceCloseMessage()
    GM("IRAI_GATE"):SetMotion(SymMot("close"), LOOP.OFF)
    GM("TOMODACHI_GATE"):WaitPlayMotion()
    WINDOW:RemoveFace()
    CAMERA:SetEye(SymCam("CAMERA_TOMODACHI_GATE"))
    CAMERA:SetTgt(SymCam("CAMERA_TOMODACHI_GATE"))
    subSpWait(TimeSec(0.5))
    GM("TOMODACHI_GATE"):SetMotion(SymMot("open"), LOOP.OFF)
    SOUND:PlaySe(SymSnd("SE_EVT_OPEN_GATE"), Volume(256))
    GM("TOMODACHI_GATE"):WaitPlayMotion()
    subSpWait(TimeSec(0.5))
    subMapCameraSet()
    CAMERA:MoveToPlayer(TimeSec(0), ACCEL_TYPE.NONE, DECEL_TYPE.NONE)
    subSpWait(TimeSec(0.3))
  end
  function EventPlay.eventShopMariruriQuickReserve()
    if MULTI_PLAY:IsLogined() then
      FLAG.ParaCenterBoardEvent = CONST.FLAG_LEFT
    end
    FlowSys.Stat.result = subUsuComFuncTalkInBase01(CH("MARIRURI"))
    ShopSys:Talk(617746084)
    WINDOW:CloseMessage()
  end
  if optTbl.isBoard == true then
    FlowSys:Call("boardFrom")
  else
    FlowSys:Call("branch")
  end
  FlowSys:Finish()
  ShopSys:Finish()
end
function OpenQuestCounterUpdateBoardMenu(optTbl)
  if optTbl == nil then
    optTbl = {}
  end
  if optTbl.multi == nil then
    optTbl.multi = false
  end
  local EventPlay = {}
  FlowSys:Start()
  ShopSys:Start()
  ShopSys:SetOwner("MARIRURI", "\227\131\158\227\131\170\227\131\171\227\131\170")
  function FlowSys.Proc.updateBoard()
    if optTbl.multi == true then
      QUEST:UpdateBoardMultiQuest()
      FLAG.ParaCenterBoardEvent = CONST.FLAG_LEFT
    else
      QUEST:UpdateBoardSingleQuest()
      FLAG.ParaCenterBoardEvent = CONST.FLAG_CHECK_NONE
    end
    if QUEST:GetQuestListSize_Board(optTbl.multi) == 0 then
      FlowSys:Next("noneDirection")
    else
      FlowSys:Next("updateDirection")
    end
  end
  function FlowSys.Proc.noneDirection()
    EventPlay.eventShopMariruriReloadNg()
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.updateDirection()
    EventPlay.eventShopMariruriReloadOk()
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.exit()
    WINDOW:CloseMessage()
    FlowSys:Return()
  end
  function EventPlay.eventShopMariruriReloadOk()
    WINDOW:CloseMessage()
    if CHARA:IsExist("HERO") then
      CH("HERO"):DirTo(CH("MARIRURI"), Speed(500), ROT_TYPE.NEAR)
    end
    if CHARA:IsExist("PLAYER") then
      CH("PLAYER"):DirTo(CH("MARIRURI"), Speed(500), ROT_TYPE.NEAR)
    end
    if CHARA:IsExist("PARTNER") then
      CH("PARTNER"):DirTo(CH("MARIRURI"), Speed(500), ROT_TYPE.NEAR)
    end
    subSpWait(TimeSec(0.3))
    local result = subUsuComFuncTalkInBase01(CH("MARIRURI"))
    local lastPosEye = CAMERA:GetEye()
    local lastPosTgt = CAMERA:GetTgt()
    ShopSys:Talk(770823829)
    WINDOW:CloseMessage()
    if FLAG.ParaCenterBoardEvent == CONST.FLAG_LEFT then
      CH("MARIRURI"):DirTo(SymPos("P_EFFECT_KEIJIBAN_L"), Speed(500))
      subSpWait(TimeSec(0.2))
      if CHARA:IsExist("HERO") then
        CH("HERO"):DirTo(SymPos("P_EFFECT_KEIJIBAN_L"), Speed(500))
      end
      if CHARA:IsExist("PLAYER") then
        CH("PLAYER"):DirTo(SymPos("P_EFFECT_KEIJIBAN_L"), Speed(500))
      end
      if CHARA:IsExist("PARTNER") then
        CH("PARTNER"):DirTo(SymPos("P_EFFECT_KEIJIBAN_L"), Speed(500))
      end
      WINDOW:RemoveFace()
      CAMERA:SetEye(SymCam("CAMERA_KEIJIBAN_L"))
      CAMERA:SetTgt(SymCam("CAMERA_KEIJIBAN_L"))
      subSpWait(TimeSec(0.5))
      EFFECT:Create("effectKeijiban", SymEff("NM_STAR_VR_BLUE"))
      EFFECT:SetPosition("effectKeijiban", SymPos("P_EFFECT_KEIJIBAN_L"))
      EFFECT:Play("effectKeijiban")
    else
      CH("MARIRURI"):DirTo(SymPos("P_EFFECT_KEIJIBAN_R"), Speed(500))
      subSpWait(TimeSec(0.2))
      if CHARA:IsExist("HERO") then
        CH("HERO"):DirTo(SymPos("P_EFFECT_KEIJIBAN_R"), Speed(500))
      end
      if CHARA:IsExist("PLAYER") then
        CH("PLAYER"):DirTo(SymPos("P_EFFECT_KEIJIBAN_R"), Speed(500))
      end
      if CHARA:IsExist("PARTNER") then
        CH("PARTNER"):DirTo(SymPos("P_EFFECT_KEIJIBAN_R"), Speed(500))
      end
      WINDOW:RemoveFace()
      CAMERA:SetEye(SymCam("CAMERA_KEIJIBAN_R"))
      CAMERA:SetTgt(SymCam("CAMERA_KEIJIBAN_R"))
      subSpWait(TimeSec(0.5))
      EFFECT:Create("effectKeijiban", SymEff("NM_STAR_VR_BLUE"))
      EFFECT:SetPosition("effectKeijiban", SymPos("P_EFFECT_KEIJIBAN_R"))
      EFFECT:Play("effectKeijiban")
    end
    SOUND:PlaySe(SymSnd("SE_WAZA_OMAJINAI"), Volume(256))
    EFFECT:Wait("effectKeijiban")
    SOUND:WaitSe(SymSnd("SE_WAZA_OMAJINAI"))
    subSpWait(TimeSec(0.3))
    CAMERA:SetEye(lastPosEye)
    CAMERA:SetTgt(lastPosTgt)
    subSpWait(TimeSec(0.3))
    if CHARA:IsExist("HERO") then
      CH("HERO"):DirTo(CH("MARIRURI"), Speed(500), ROT_TYPE.NEAR)
    end
    if CHARA:IsExist("PLAYER") then
      CH("PLAYER"):DirTo(CH("MARIRURI"), Speed(500), ROT_TYPE.NEAR)
    end
    if CHARA:IsExist("PARTNER") then
      CH("PARTNER"):DirTo(CH("MARIRURI"), Speed(500), ROT_TYPE.NEAR)
    end
    subEveDoubleJump(CH("MARIRURI"))
    ShopSys:Talk(1506793958)
    WINDOW:CloseMessage()
    subUsuComFuncTalkOutBase01(CH("MARIRURI"), result)
    subSpWait(TimeSec(0.5))
  end
  function EventPlay.eventShopMariruriReloadNg()
    if CHARA:IsExist("HERO") then
      CH("HERO"):DirTo(CH("MARIRURI"), Speed(500), ROT_TYPE.NEAR)
    end
    if CHARA:IsExist("PLAYER") then
      CH("PLAYER"):DirTo(CH("MARIRURI"), Speed(500), ROT_TYPE.NEAR)
    end
    if CHARA:IsExist("PARTNER") then
      CH("PARTNER"):DirTo(CH("MARIRURI"), Speed(500), ROT_TYPE.NEAR)
    end
    ShopSys:Talk(-1351472119)
    FLAG.ParaCenterBoardEvent = CONST.FLAG_CHECK_NONE
    WINDOW:CloseMessage()
  end
  FlowSys:Call("updateBoard")
  FlowSys:Finish()
  ShopSys:Finish()
end
function OpenQuestCounterMenu_Guest()
  local EventPlay = {}
  MENU:LoadMenuTextPool("message/shop.bin", false)
  MENU:LoadMenuTextPool("message/menu_quest_counter.bin")
  FlowSys:Start()
  ShopSys:Start()
  ShopSys:SetOwner("MARIRURI", "\227\131\158\227\131\170\227\131\171\227\131\170")
  function FlowSys.Proc.error()
    QUEST:ResetCurrentQuestInfo()
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.syncQuest()
    if MULTI_PLAY:SyncMultiPlayQuest() then
      FlowSys:Next("entry")
    else
      FlowSys:Next("error")
    end
  end
  function FlowSys.Proc.entry()
    local resumeFlowSysData = FlowSys:Suspend()
    local resumeShopSysData = ShopSys:Suspend()
    local nextFlow = "exit"
    OpenMultiPlaySynchronizeGuestMenu_Dungeon(function()
      nextFlow = "guest_matchingFinish"
    end, function()
      nextFlow = "matchingCancel"
    end, function()
      nextFlow = "error"
    end)
    FlowSys:Resume(resumeFlowSysData)
    ShopSys:Resume(resumeShopSysData)
    FlowSys:Next(nextFlow)
  end
  function FlowSys.Proc.openMultiGate()
    SCREEN_B:FadeOut(TimeSec(0.3), true)
    EventPlay.eventShopMarirurileftMultiGate(face)
    FlowSys:Next("direction")
  end
  function FlowSys.Proc.matchingCancel()
    QUEST:ResetCurrentQuestInfo()
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.direction()
    ShopSys:Talk(-724194601)
    FlowSys:Next("exit")
  end
  function FlowSys.Proc.exit()
    WINDOW:CloseMessage()
    FlowSys:Return()
  end
  function FlowSys.Proc.guest_matchingFinish()
    FLAG.MultiSpecialFlag = CONST.EVENT_MULTI_CALL
    FLAG.MapFlags = CONST.MAP_EVENT
    SYSTEM:NextEntry()
    FlowSys:Return()
  end
  function EventPlay.eventShopMarirurileftMultiGate(face)
    WINDOW:ForceCloseMessage()
    GM("IRAI_GATE"):SetMotion(SymMot("close"), LOOP.OFF)
    GM("TOMODACHI_GATE"):WaitPlayMotion()
    WINDOW:RemoveFace()
    CAMERA:SetEye(SymCam("CAMERA_TOMODACHI_GATE"))
    CAMERA:SetTgt(SymCam("CAMERA_TOMODACHI_GATE"))
    subSpWait(TimeSec(0.5))
    GM("TOMODACHI_GATE"):SetMotion(SymMot("open"), LOOP.OFF)
    SOUND:PlaySe(SymSnd("SE_EVT_OPEN_GATE"), Volume(256))
    GM("TOMODACHI_GATE"):WaitPlayMotion()
    subSpWait(TimeSec(0.5))
    CAMERA:MoveToPlayer(TimeSec(0), ACCEL_TYPE.NONE, DECEL_TYPE.NONE)
    subSpWait(TimeSec(0.3))
    SCREEN_B:FadeIn(TimeSec(0.3), true)
  end
  FlowSys:Call("syncQuest")
  FlowSys:Finish()
  ShopSys:Finish()
end
