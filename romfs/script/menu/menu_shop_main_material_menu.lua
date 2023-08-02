dofile("script/paradise_next/shop_strings.lua")
function DispSelectColorMenu(selectColorChangeType, titleText, padHelpText, bgGraphicLabel, selectedAction, cancelAction)
  if bgGraphicLabel == nil then
    bgGraphicLabel = "HOME"
  end
  local bgPtnTbl = {
    PARA_SHOP_COUNTER = {
      name = "noticeBG",
      img = "NOTICE_INST01",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_HOUSE_1 = {
      name = "noticeBG",
      img = "NOTICE_INST02",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_HOUSE_2 = {
      name = "noticeBG",
      img = "NOTICE_INST03",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_DOOM_1 = {
      name = "noticeBG",
      img = "NOTICE_INST04",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_DOOM_2 = {
      name = "noticeBG",
      img = "NOTICE_INST05",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_TENT_1 = {
      name = "noticeBG",
      img = "NOTICE_INST06",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_TENT_2 = {
      name = "noticeBG",
      img = "NOTICE_INST07",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_HORIATE = {
      name = "noticeBG",
      img = "NOTICE_INST08",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_WAZA_TRAINING = {
      name = "noticeBG",
      img = "NOTICE_INST09",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_MUSIC = {
      name = "noticeBG",
      img = "NOTICE_INST10",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_FARM_1 = {
      name = "noticeBG",
      img = "NOTICE_INST11",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_FARM_2 = {
      name = "noticeBG",
      img = "NOTICE_INST12",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_DIVER = {
      name = "noticeBG",
      img = "NOTICE_INST13",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_SALVAGE = {
      name = "noticeBG",
      img = "NOTICE_INST14",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    PARA_SHOP_TAMAIRE = {
      name = "noticeBG",
      img = "NOTICE_INST15",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    },
    HOME = {
      name = "noticeBG",
      img = "NOTICE_HOME",
      u = 0,
      v = 0,
      w = 256,
      h = 192,
      cx = 128,
      cy = 96,
      allocateFromMap = true
    }
  }
  SPRITE:CreatePatternSet("upperNoticeSet", bgPtnTbl[bgGraphicLabel], {
    name = "notice_red",
    img = "NOTICE_INST_COLORS",
    u = 0,
    v = 0,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_blue",
    img = "NOTICE_INST_COLORS",
    u = 64,
    v = 0,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_yellow",
    img = "NOTICE_INST_COLORS",
    u = 128,
    v = 0,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_purple",
    img = "NOTICE_INST_COLORS",
    u = 192,
    v = 0,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_green",
    img = "NOTICE_INST_COLORS",
    u = 0,
    v = 64,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_pink",
    img = "NOTICE_INST_COLORS",
    u = 64,
    v = 64,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_aqua",
    img = "NOTICE_INST_COLORS",
    u = 128,
    v = 64,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_gray",
    img = "NOTICE_INST_COLORS",
    u = 192,
    v = 64,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_default",
    img = "NOTICE_INST_COLORS",
    u = 0,
    v = 192,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_rare_gold",
    img = "NOTICE_INST_COLORS",
    u = 128,
    v = 128,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_rare_silver",
    img = "NOTICE_INST_COLORS",
    u = 64,
    v = 128,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_rare_copper",
    img = "NOTICE_INST_COLORS",
    u = 0,
    v = 128,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  }, {
    name = "notice_rare_crystal",
    img = "NOTICE_INST_COLORS",
    u = 192,
    v = 128,
    w = 64,
    h = 64,
    cx = 32,
    cy = 32,
    allocateFromMap = true
  })
  local labelBaseTbl = {
    [PARADISE_COLOR_CHANGE_TYPE.HOME_ROOF] = "color_home_roof_",
    [PARADISE_COLOR_CHANGE_TYPE.HOME_WINDOW] = "color_home_win_",
    [PARADISE_COLOR_CHANGE_TYPE.SHOP] = "color_shop_",
    [PARADISE_COLOR_CHANGE_TYPE.FARM] = "color_farm_"
  }
  local labelColorSetTbl = {
    [PARADISE_COLOR_CHANGE_TYPE.HOME_ROOF] = {
      "red",
      "blue",
      "yellow",
      "purple",
      "green",
      "pink",
      "aqua",
      "gray",
      "default"
    },
    [PARADISE_COLOR_CHANGE_TYPE.HOME_WINDOW] = {
      "red",
      "blue",
      "yellow",
      "purple",
      "green",
      "pink",
      "aqua",
      "gray",
      "default"
    },
    [PARADISE_COLOR_CHANGE_TYPE.SHOP] = {
      "red",
      "blue",
      "yellow",
      "purple",
      "green",
      "pink",
      "aqua",
      "gray",
      "default",
      "rare_gold",
      "rare_silver",
      "rare_copper",
      "rare_crystal"
    },
    [PARADISE_COLOR_CHANGE_TYPE.FARM] = {
      "red",
      "blue",
      "default"
    }
  }
  local spriteNameModSetTbl = {
    [PARADISE_COLOR_CHANGE_TYPE.HOME_ROOF] = {},
    [PARADISE_COLOR_CHANGE_TYPE.HOME_WINDOW] = {},
    [PARADISE_COLOR_CHANGE_TYPE.SHOP] = {},
    [PARADISE_COLOR_CHANGE_TYPE.FARM] = {default = "yellow"}
  }
  local subWallpaperImg = {
    [PARADISE_COLOR_CHANGE_TYPE.HOME_ROOF] = "WALLPAPER_SUB_UTILITY01",
    [PARADISE_COLOR_CHANGE_TYPE.HOME_WINDOW] = "WALLPAPER_SUB_UTILITY01",
    [PARADISE_COLOR_CHANGE_TYPE.SHOP] = "WALLPAPER_SUB_NOTICE01",
    [PARADISE_COLOR_CHANGE_TYPE.FARM] = "WALLPAPER_SUB_NOTICE01"
  }
  local labelBase = labelBaseTbl[selectColorChangeType]
  local labelColorSet = labelColorSetTbl[selectColorChangeType]
  local spriteNameModSet = spriteNameModSetTbl[selectColorChangeType]
  local titleTextTbl = {}
  local spritePtnTbl = {}
  for i, color in ipairs(labelColorSet) do
    titleTextTbl[labelBase .. color] = GetLandShopNameTextIdForTitle(labelBase .. color)
    spritePtnTbl[labelBase .. color] = spriteNameModSet[color] and "notice_" .. spriteNameModSet[color] or "notice_" .. color
  end
  local upperMaterialMenu = ShopSys:OpenUpperMaterialMenu({
    enumMaterialFunc = function(colorChangeLabel)
      return coroutine.wrap(function()
        for idx = 1, GROUND:GetColorChangeMaterialCount(colorChangeLabel) do
          coroutine.yield({
            itemIndex = GROUND:GetColorChangeMaterialItemIndex(colorChangeLabel, idx - 1),
            neecCount = GROUND:GetColorChangeMaterialNeedCount(colorChangeLabel, idx - 1),
            hasCount = GROUND:GetColorChangeMaterialHasCount(colorChangeLabel, idx - 1)
          })
        end
      end)
    end,
    getPriceFunc = function(colorChangeLabel)
      return GROUND:GetColorChangePrice(colorChangeLabel)
    end,
    spritePtnSetName = "upperNoticeSet",
    titleTextTbl = titleTextTbl,
    spriteBgPtn = "noticeBG",
    spritePtnTbl = spritePtnTbl
  })
  local colorList = {}
  for colorLabel in GROUND:EnumerateColorChengeOkLabel(selectColorChangeType) do
    local sortPrio = GROUND:GetLandShopSortPrio(colorLabel)
    table.insert(colorList, {label = colorLabel, sortPrio = sortPrio})
  end
  table.sort(colorList, function(a, b)
    return a.sortPrio < b.sortPrio
  end)
  local typeListMenu = MENU:CreatePageMenuBigStack()
  typeListMenu:SetDecideSound(false)
  local colorCount = 0
  for i, color in ipairs(colorList) do
    typeListMenu:AddItem(GetLandShopNameTextIdForTitle(color.label), color.label, nil)
    colorCount = colorCount + 1
  end
  if colorCount < 9 then
    typeListMenu:SetLayoutRectAndLines(16, 40, 136, 0)
    typeListMenu:ShowPageNum(false)
  else
    typeListMenu:SetLayoutRectAndLines(16, 40, 136, 8)
    typeListMenu:ShowPageNum(true)
  end
  function typeListMenu:itemPreOpenModifyAction()
    local label = self.curItem.obj
    local state = GROUND:GetOpenLimitState_LandShopLabel(label)
    if state == PARADISE_OPEN_LIMIT_STATE.CLOSE then
      self.curItem.text = "???"
      self.curItem.grayed = true
    elseif state == PARADISE_OPEN_LIMIT_STATE.OPEN_NEW then
      self.curItem.text = "[M:NEW]" .. self.curItem.text
    end
  end
  function typeListMenu:openedAction()
    SCREEN_B:LoadWallpaper(subWallpaperImg[selectColorChangeType])
    SCREEN_B:SetVisibleWallpaper(true)
    CommonSys:OpenBasicMenu(titleText, padHelpText, nil)
    upperMaterialMenu:UpdateInfo(self.curItem.obj)
  end
  function typeListMenu:currentItemChange()
    upperMaterialMenu:UpdateInfo(self.curItem.obj)
  end
  function typeListMenu:decideAction()
    if selectedAction then
      SOUND:PlaySe(SymSnd("SE_SYS_DECIDE"))
      selectedAction(self.curItem.obj)
      self:Close()
    end
  end
  function typeListMenu:cancelAction()
    cancelAction()
    self:Close()
  end
  function typeListMenu:closedAction()
    CommonSys:CloseBasicMenu()
    upperMaterialMenu:Close()
  end
  CommonSys:OpenAndCloseWait(typeListMenu)
  SPRITE:DestroyPatternSet("upperNoticeSet")
end
function DispSelectLandTypeMenu(titleText, padHelpText, selectedAction, cancelAction, withTutorial)
  MENU:LoadMenuTextPool("message/paradise_next_common.bin")
  SPRITE:CreatePatternSet("upperNoticeSet", {
    name = "notice_prairie",
    img = "NOTICE_OUTPOST01",
    u = 0,
    v = 0,
    w = 256,
    h = 192,
    cx = 128,
    cy = 96,
    allocateFromMap = true
  }, {
    name = "notice_forest",
    img = "NOTICE_OUTPOST02",
    u = 0,
    v = 0,
    w = 256,
    h = 192,
    cx = 128,
    cy = 96,
    allocateFromMap = true
  }, {
    name = "notice_water",
    img = "NOTICE_OUTPOST03",
    u = 0,
    v = 0,
    w = 256,
    h = 192,
    cx = 128,
    cy = 96,
    allocateFromMap = true
  }, {
    name = "notice_rocky",
    img = "NOTICE_OUTPOST04",
    u = 0,
    v = 0,
    w = 256,
    h = 192,
    cx = 128,
    cy = 96,
    allocateFromMap = true
  })
  local upperMaterialMenu = ShopSys:OpenUpperMaterialMenu({
    enumMaterialFunc = function(landType)
      return coroutine.wrap(function()
        for idx = 1, GROUND:GetDevelopLandMaterialCount(landType) do
          coroutine.yield({
            itemIndex = GROUND:GetDevelopLandMaterialItemIndex(landType, idx - 1),
            neecCount = GROUND:GetDevelopLandMaterialNeedCount(landType, idx - 1),
            hasCount = GROUND:GetDevelopLandMaterialHasCount(landType, idx - 1)
          })
        end
      end)
    end,
    getPriceFunc = function(landType)
      return GROUND:GetDevelopLandPrice(landType)
    end,
    spritePtnSetName = "upperNoticeSet",
    titleTextTbl = {
      [PARADISE_LAND_TYPE.PRAIRIE] = 1989378931,
      [PARADISE_LAND_TYPE.FOREST] = -1952329977,
      [PARADISE_LAND_TYPE.ROCKY_HILL] = 567129807,
      [PARADISE_LAND_TYPE.WATER] = -634815408
    },
    spritePtnTbl = {
      [PARADISE_LAND_TYPE.PRAIRIE] = "notice_prairie",
      [PARADISE_LAND_TYPE.FOREST] = "notice_forest",
      [PARADISE_LAND_TYPE.ROCKY_HILL] = "notice_rocky",
      [PARADISE_LAND_TYPE.WATER] = "notice_water"
    }
  })
  local typeListMenu = MENU:CreatePageMenuBigStack()
  typeListMenu:SetDecideSound(false)
  typeListMenu:SetLayoutRectAndLines(16, 40, 136, 4)
  typeListMenu:ShowPageNum(false)
  typeListMenu:AddItem(363840461, PARADISE_LAND_TYPE.PRAIRIE, nil)
  typeListMenu:AddItem(1091680814, PARADISE_LAND_TYPE.WATER, nil)
  typeListMenu:AddItem(1209690050, PARADISE_LAND_TYPE.FOREST, nil)
  typeListMenu:AddItem(1579658716, PARADISE_LAND_TYPE.ROCKY_HILL, nil)
  local typeLabelTbl = {
    [PARADISE_LAND_TYPE.PRAIRIE] = "reclamation_weed",
    [PARADISE_LAND_TYPE.FOREST] = "reclamation_wood",
    [PARADISE_LAND_TYPE.ROCKY_HILL] = "reclamation_rock",
    [PARADISE_LAND_TYPE.WATER] = "reclamation_water"
  }
  function typeListMenu:itemPreOpenModifyAction()
    local landType = self.curItem.obj
    local state = GROUND:GetOpenLimitState_LandShopLabel(typeLabelTbl[landType])
    if state == PARADISE_OPEN_LIMIT_STATE.CLOSE then
      self.curItem.text = "???"
      self.curItem.grayed = true
    elseif state == PARADISE_OPEN_LIMIT_STATE.OPEN_NEW then
      self.curItem.text = "[M:NEW]" .. self.curItem.text
    end
  end
  function typeListMenu:openedAction()
    self:SetCursorItemIndex(ShopSys:ResumeCursorIndex("LandTypeMenu", 0))
    SCREEN_B:LoadWallpaper("WALLPAPER_SUB_CARPENTER01")
    SCREEN_B:SetVisibleWallpaper(true)
    CommonSys:OpenBasicMenu(titleText, padHelpText, nil)
    upperMaterialMenu:UpdateInfo(self.curItem.obj)
  end
  function typeListMenu:currentItemChange()
    if self.curItem.grayed == false then
      upperMaterialMenu:UpdateInfo(self.curItem.obj)
    end
  end
  function typeListMenu:decideAction()
    if selectedAction then
      SOUND:PlaySe(SymSnd("SE_SYS_DECIDE"))
      local landType = self.curItem.obj
      local state = GROUND:GetOpenLimitState_LandShopLabel(typeLabelTbl[landType])
      selectedAction(self.curItem.obj)
      self:Close()
    end
  end
  function typeListMenu:cancelAction()
    cancelAction()
    self:Close()
  end
  function typeListMenu:closedAction()
    CommonSys:CloseBasicMenu()
    upperMaterialMenu:Close()
  end
  SCREEN_A:FadeInAll(TimeSec(0.3), false)
  SCREEN_B:FadeInAll(TimeSec(0.3), false)
  typeListMenu:Open()
  if withTutorial then
    SYSTEM:ExecuteTutorialHint(SymHint("SHOP_CARPENTER_ATTRIBUTE"))
  end
  MENU:SetFocus(typeListMenu)
  MENU:WaitClose(typeListMenu)
  SPRITE:DestroyPatternSet("upperNoticeSet")
end
function DispBuildSelectMenu(titleText, padHelpText, selectedAction, cancelAction, withTutorial, isZairyouMenu)
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
  local upperMaterialMenu = ShopSys:OpenUpperMaterialMenu({
    enumMaterialFunc = function(landShopId)
      return coroutine.wrap(function()
        if type(landShopId) ~= "table" then
          for idx = 1, GROUND:GetDevelopLandShopMaterialCount(landShopId, 0) do
            coroutine.yield({
              itemIndex = GROUND:GetDevelopLandShopMaterialItemIndex(landShopId, 0, idx - 1),
              neecCount = GROUND:GetDevelopLandShopMaterialNeedCount(landShopId, 0, idx - 1),
              hasCount = GROUND:GetDevelopLandShopMaterialHasCount(landShopId, 0, idx - 1)
            })
          end
        elseif landShopId.shopLabel ~= nil and landShopId.shopLevel ~= nil then
          for idx = 1, GROUND:GetDevelopLandShopMaterialCount(landShopId.shopLabel, landShopId.shopLevel) do
            coroutine.yield({
              itemIndex = GROUND:GetDevelopLandShopMaterialItemIndex(landShopId.shopLabel, landShopId.shopLevel, idx - 1),
              neecCount = GROUND:GetDevelopLandShopMaterialNeedCount(landShopId.shopLabel, landShopId.shopLevel, idx - 1),
              hasCount = GROUND:GetDevelopLandShopMaterialHasCount(landShopId.shopLabel, landShopId.shopLevel, idx - 1)
            })
          end
        end
      end)
    end,
    getPriceFunc = function(landShopId)
      if type(landShopId) ~= "table" then
        return GROUND:GetDevelopLandShopPrice(landShopId, 0)
      elseif landShopId.shopLabel ~= nil and landShopId.shopLevel ~= nil then
        return GROUND:GetDevelopLandShopPrice(landShopId.shopLabel, landShopId.shopLevel)
      else
        return -1
      end
    end,
    spritePtnSetName = nil,
    titleTextTbl = titleTextTbl,
    spritePtnTbl = spritePtnTbl,
    explainTextTbl = explainTextTbl,
    spriteAutoLoadTbl = spriteAutoLoadTbl
  })
  local shopInfoList = {}
  local shopInfoGroupTbl = {}
  for landShopId in GROUND:EnumerateBuildOkLandShopLabel() do
    local sortPrio = GROUND:GetLandShopSortPrio(landShopId)
    local targetShopList
    targetShopList = shopInfoList
    table.insert(targetShopList, {label = landShopId, sortPrio = sortPrio})
  end
  if (FLAG.MeroettaCounter == CONST.CNT_3 or FLAG.MeroettaCounter == CONST.CNT_4 or FLAG.MeroettaCounter == CONST.CNT_5) and FLAG.ParaMusicParadiseBuild == CONST.FLAG_FALSE and isZairyouMenu then
    local openState = GROUND:GetOpenLimitState_LandShopLabel("shop_jukebox")
    if openState == PARADISE_OPEN_LIMIT_STATE.CLOSE then
      GROUND:SetOpenLimitState_LandShopLabel(nowShopId, PARADISE_OPEN_LIMIT_STATE.OPEN_NEW)
    end
    table.insert(shopInfoList, {
      label = "shop_jukebox",
      sortPrio = 0
    })
  end
  table.sort(shopInfoList, function(a, b)
    return a.sortPrio < b.sortPrio
  end)
  for k, infoGroup in pairs(shopInfoGroupTbl) do
    table.sort(infoGroup.shopInfoList, function(a, b)
      return a.sortPrio < b.sortPrio
    end)
  end
  local shopListMenu = MENU:CreatePageMenuBigStack()
  shopListMenu:SetLayoutRectAndLines(16, 40, 168, 8)
  shopListMenu:ShowPageNum(true)
  local function updateList(shopInfoList)
    shopListMenu:ClearItems()
    for i, info in ipairs(shopInfoList) do
      if info.label then
        shopListMenu:AddItem(GetLandShopNameTextIdForTitle(info.label), info.label, nil)
        titleTextTbl[info.label] = GetLandShopNameTextIdForTitle(info.label)
        spritePtnTbl[info.label] = "notice_" .. GROUND:GetLandShopGraphicLabel(info.label, 0)
        explainTextTbl[info.label] = GetLandShopExplainTextIdForDesc(info.label, 0)
      else
        shopListMenu:AddItem(info.name, info, nil)
        titleTextTbl[info] = info.name
        spritePtnTbl[info] = info.spritePtn
        explainTextTbl[info] = info.exp
      end
    end
    shopListMenu:UpdateItemList()
  end
  function shopListMenu:itemPreOpenModifyAction()
    if type(self.curItem.obj) == "table" then
      self.curItem.text = "[CS:B]" .. self.curItem.text .. "[M:OP01ACT][CR]"
    else
      local label = self.curItem.obj
      local state = GROUND:GetOpenLimitState_LandShopLabel(label)
      if state == PARADISE_OPEN_LIMIT_STATE.CLOSE then
      elseif state == PARADISE_OPEN_LIMIT_STATE.OPEN_NEW then
        MENU:SetTag_String(5, self.curItem.text)
        self.curItem.text = MENU:ReplaceTagText(-1442573159)
      elseif 0 < GROUND:GetLandShopBuildNum(label, 0) then
        MENU:SetTag_String(5, self.curItem.text)
        self.curItem.text = MENU:ReplaceTagText(-1877445541)
      else
        MENU:SetTag_String(5, self.curItem.text)
        self.curItem.text = MENU:ReplaceTagText(-702144315)
      end
    end
  end
  shopListMenu.itemPreUpdateModifyAction = shopListMenu.itemPreOpenModifyAction
  function shopListMenu:openedAction()
    updateList(shopInfoList)
    SCREEN_B:LoadWallpaper("WALLPAPER_SUB_NOTICE01")
    SCREEN_B:SetVisibleWallpaper(true)
    CommonSys:OpenBasicMenu(titleText, padHelpText, nil)
    upperMaterialMenu:UpdateInfo(self.curItem.obj)
  end
  function shopListMenu:currentItemChange()
    upperMaterialMenu:UpdateInfo(self.curItem.obj)
  end
  local gradeUpSelectedAction
  if selectedAction == nil and GROUND:GetOpenLimitState_Menu(PARADISE_MENU_OPEN_TYPE.SHOP_GRADE_UP) ~= PARADISE_OPEN_LIMIT_STATE.CLOSE then
    do
      local gradeUpTextTbl = {
        [0] = -544741112,
        [1] = -190137653,
        [2] = -307131510
      }
      function gradeUpSelectedAction(label)
        local gradeUpListMenu = MENU:CreatePageMenu()
        gradeUpListMenu:SetLayoutRectAndLines(200, 40, 104, 0)
        gradeUpListMenu:SetDecideSound(false)
        gradeUpListMenu.infoGradeUpTbl = {}
        for level = 0, GROUND:GetLandShopLevelMax(label) do
          local infoGradeUp = {}
          titleTextTbl[infoGradeUp] = GetLandShopNameTextIdForTitle(label)
          spritePtnTbl[infoGradeUp] = "notice_" .. GROUND:GetLandShopGraphicLabel(label, level)
          explainTextTbl[infoGradeUp] = GetLandShopExplainTextIdForDesc(label, level)
          infoGradeUp.shopLabel = label
          infoGradeUp.shopLevel = level
          if GROUND:GetLandShopLevelMax(label) == 0 then
            gradeUpListMenu:AddItem(-1921250050, infoGradeUp, nil)
          else
            gradeUpListMenu:AddItem(gradeUpTextTbl[level], infoGradeUp, nil)
          end
          table.insert(gradeUpListMenu.infoGradeUpTbl, infoGradeUp)
        end
        function gradeUpListMenu:openedAction()
          upperMaterialMenu:UpdateInfo(self.infoGradeUpTbl[1])
        end
        function gradeUpListMenu:closedAction()
          for i, infoGradeUp in ipairs(self.infoGradeUpTbl) do
            titleTextTbl[infoGradeUp] = nil
            spritePtnTbl[infoGradeUp] = nil
            explainTextTbl[infoGradeUp] = nil
          end
        end
        function gradeUpListMenu:currentItemChange()
          if #gradeUpListMenu.infoGradeUpTbl > 1 then
            upperMaterialMenu:UpdateInfo(self.curItem.obj)
          end
        end
        function gradeUpListMenu:inputLSelectAction()
          upperMaterialMenu:SwitchInfo(-1)
        end
        function gradeUpListMenu:inputRSelectAction()
          upperMaterialMenu:SwitchInfo(1)
        end
        function gradeUpListMenu:decideAction()
        end
        function gradeUpListMenu:cancelAction()
          gradeUpListMenu:Close()
        end
        gradeUpListMenu:Open()
        MENU:SetFocus(gradeUpListMenu)
        MENU:WaitClose(gradeUpListMenu)
      end
    end
  else
    shopListMenu:SetDecideSound(false)
  end
  local beforeList, beforeIdx
  function shopListMenu:decideAction()
    if type(self.curItem.obj) == "table" then
      beforeList = shopInfoList
      beforeIdx = self:GetCursorItemIndex()
      updateList(self.curItem.obj.shopInfoList)
      self:SetCursorItemIndex(0)
      self:SetCurrentModifyItem(0)
      self:currentItemChange()
    elseif selectedAction then
      SOUND:PlaySe(SymSnd("SE_SYS_DECIDE"))
      selectedAction(self.curItem.obj)
      self:Close()
    elseif gradeUpSelectedAction then
      gradeUpSelectedAction(self.curItem.obj)
      MENU:SetFocus(self)
      upperMaterialMenu:UpdateInfo(self.curItem.obj)
    end
  end
  function shopListMenu:cancelAction()
    if beforeList then
      updateList(beforeList)
      self:SetCursorItemIndex(beforeIdx)
      self:SetCurrentModifyItem(beforeIdx)
      self:currentItemChange()
      beforeList = nil
      beforeIdx = nil
    else
      cancelAction()
      self:Close()
    end
  end
  function shopListMenu:inputLSelectAction()
    upperMaterialMenu:SwitchInfo(-1)
  end
  function shopListMenu:inputRSelectAction()
    upperMaterialMenu:SwitchInfo(1)
  end
  function shopListMenu:closedAction()
    CommonSys:CloseBasicMenu()
    upperMaterialMenu:Close()
  end
  shopListMenu:Open()
  if withTutorial then
    SYSTEM:ExecuteTutorialHint(SymHint("SHOP_SIGNBOARD_BUILD"), false)
    SYSTEM:ExecuteTutorialHint(SymHint("SHOP_SIGNBOARD_SECOUND"), false)
    if 1 <= GROUND:GetParadiseRank() then
      SYSTEM:ExecuteTutorialHint(SymHint("SHOP_SIGNBOARD_LRBUTTON"), false)
    end
  end
  if selectedAction == nil and GROUND:GetOpenLimitState_Menu(PARADISE_MENU_OPEN_TYPE.SHOP_GRADE_UP) ~= PARADISE_OPEN_LIMIT_STATE.CLOSE then
    SYSTEM:ExecuteTutorialHint(SymHint("SHOP_KENZAI_OPEN_GRADEUP"), false)
  end
  MENU:SetFocus(shopListMenu)
  MENU:WaitClose(shopListMenu)
end
function OpenParadiseRankUpMenu()
  MENU:LoadMenuTextPool("message/shop.bin", false)
  MENU:LoadMenuTextPool("message/paradise_next_common.bin")
  if GROUND:UpdateParadiseRank() == false then
    return
  end
  local newRank = GROUND:GetParadiseRank()
  local newShopLabelTbl = {}
  local newColorLabelTbl = {}
  for idx = 0, GROUND:GetParadiseRankBonusLandShop_Count(newRank) - 1 do
    table.insert(newShopLabelTbl, GROUND:GetParadiseRankBonusLandShop_Label(newRank, idx))
  end
  for idx = 0, GROUND:GetParadiseRankBonusShopColor_Count(newRank) - 1 do
    table.insert(newColorLabelTbl, GROUND:GetParadiseRankBonusShopColor_Label(newRank, idx))
  end
  SAJI:CreateSajiPlayer("confetti", "SCRATCH_CONFETTI")
  SJ("confetti"):SetVisible(false)
  SOUND:PlayMe(SymSnd("ME_RANKUP"), Volume(256))
  MENU:SetTag_String(5, GROUND:GetParadiseRankName())
  WINDOW:SysMsg(-87692393)
  SOUND:WaitMe()
  WINDOW:CloseMessage()
  local taskMeAndKamiFubuki = function()
    TASK:Sleep(TimeSec(30, TIME_TYPE.FRAME))
    SOUND:PlayMe(SymSnd("ME_EVT_V_FANFARE"), Volume(256))
    SOUND:PlaySe(SymSnd("SE_EVT_PARTY"), Volume(256))
    TASK:Sleep(TimeSec(10, TIME_TYPE.FRAME))
    SJ("confetti"):SetDrawPriority(500)
    SJ("confetti"):SetPosition(Vector2(200, 120))
    SJ("confetti"):Play(LOOP.ON)
    SJ("confetti"):SetVisible(true)
    SOUND:WaitMe()
    function TaskL.Finish()
      SAJI:DestroySajiPlayer("confetti")
      return
    end
  end
  TASK:Regist(Group("taskMeAndKamiFubuki"), taskMeAndKamiFubuki)
  WINDOW:SysMsg(1113209978)
  TASK:WaitTask(Group("taskMeAndKamiFubuki"))
  WINDOW:CloseMessage()
  if 0 < GROUND:GetParadiseRankBonusBagAddCapacity(newRank) then
    MENU:SetTag_String(10, string.format("%d", GROUND:GetBagItemMaxCount()))
    SOUND:PlayMe(SymSnd("ME_REWARD"), Volume(256))
    WINDOW:SysMsg(1626656511)
    SOUND:WaitMe()
    WINDOW:KeyWait()
  end
  for i, label in ipairs(newShopLabelTbl) do
    MENU:SetTag_String(6, GetLandShopNameTextIdForTitle(label))
    SOUND:PlayMe(SymSnd("ME_REWARD"), Volume(256))
    WINDOW:SysMsg(-932705024)
    SOUND:WaitMe()
    WINDOW:KeyWait()
  end
  for i, label in ipairs(newColorLabelTbl) do
    MENU:SetTag_String(7, GetLandShopNameTextIdForTitle(label))
    SOUND:PlayMe(SymSnd("ME_REWARD"), Volume(256))
    WINDOW:SysMsg(-1808678825)
    SOUND:WaitMe()
    WINDOW:KeyWait()
  end
  for idx = 0, GROUND:GetParadiseRankBonusItem_Count(newRank) - 1 do
    local itemIndex = GROUND:GetParadiseRankBonusItem_ItemIndex(newRank, idx)
    local itemCount = GROUND:GetParadiseRankBonusItem_ItemCount(newRank, idx)
    SOUND:PlayMe(SymSnd("ME_REWARD"), Volume(256))
    OverFlow:AddOverflowCheckItem(itemIndex, itemCount, true)
    OverFlow:OpenOrderOverflowMenu(true)
    SOUND:WaitMe()
  end
  WINDOW:CloseMessage()
  if FLAG.ParaMusicParadiseBuild == CONST.FLAG_TRUE then
    if newRank == 7 then
      WINDOW:SysMsg(1308644427)
      WINDOW:KeyWait()
      SOUND:PlayMe(SymSnd("ME_MINIGAME_PERFECT"), Volume(256))
      WINDOW:SysMsg(605179702)
      SOUND:WaitMe()
      WINDOW:CloseMessage()
    elseif newRank == 8 then
      WINDOW:SysMsg(1697449864)
      WINDOW:KeyWait()
      SOUND:PlayMe(SymSnd("ME_MINIGAME_PERFECT"), Volume(256))
      WINDOW:SysMsg(605179702)
      SOUND:WaitMe()
      WINDOW:CloseMessage()
    elseif newRank == 9 then
      WINDOW:SysMsg(2083927753)
      WINDOW:KeyWait()
      SOUND:PlayMe(SymSnd("ME_MINIGAME_PERFECT"), Volume(256))
      WINDOW:SysMsg(605179702)
      SOUND:WaitMe()
      WINDOW:CloseMessage()
    elseif newRank == 10 then
      WINDOW:SysMsg(863477774)
      WINDOW:KeyWait()
      SOUND:PlayMe(SymSnd("ME_MINIGAME_PERFECT"), Volume(256))
      WINDOW:SysMsg(605179702)
      SOUND:WaitMe()
      WINDOW:CloseMessage()
    end
  end
  SOUND:FadeOutSe(SymSnd("SE_EVT_PARTY"), TimeSec(1))
end
