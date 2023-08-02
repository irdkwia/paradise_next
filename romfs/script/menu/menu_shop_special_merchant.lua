dofile("script/menu/menu_shop_main_sellf_low.lua")
dofile("script/paradise_next/shop_strings.lua")
function OpenShopSpecialMerchantMenu(shopIns)
  MENU:LoadMenuTextPool("message/shop.bin", false)
  MENU:LoadMenuTextPool("message/paradise_next_common.bin")
  FlowSys:Start()
  ShopSys:Start()
  ShopSys:SetParaideShopInstance(shopIns)
  FlowSys.Stat.TalkFirst = true
  function FlowSys.Proc.MenuTopFirst()
    SYSTEM:ExecuteTutorialHint(SymHint("SHOP_SPECIAL_FIRST"))
    ShopSys:SetSelectGoodsTbl(nil)
    ShopSys:SetShopTag("\229\176\130\233\150\128\229\186\151\229\144\141", GetShopNameSpecial(shopIns))
    local SpecialMerchantType = shopIns:GetShopLabel()
    if SpecialMerchantType == "shop_special_merchant_plant" then
      ShopSys:Talk(-239005527, nil)
      WINDOW:CloseMessage()
      CommonSys:OpenBasicMenu(nil, -1733859855, nil)
      ShopSys:TalkAskFlowNoClose(652598928, FACE_TYPE.NORMAL, {cursorReset = true}, {
        next = "ExitMerchant"
      }, {
        text = -153134861,
        next = "TopBuyBefore"
      }, {text = -1825301742, next = "TopSell"}, {text = -232462753, next = "SellAll"}, {text = 1418881842, next = "Help"})
    elseif SpecialMerchantType == "shop_special_merchant_throw" then
      ShopSys:Talk(1978174988, nil)
      WINDOW:CloseMessage()
      CommonSys:OpenBasicMenu(nil, -1733859855, nil)
      ShopSys:TalkAskFlowNoClose(10, FACE_TYPE.NORMAL, {cursorReset = true}, {
        next = "ExitMerchant"
      }, {
        text = -153134861,
        next = "TopBuyBefore"
      }, {text = -1825301742, next = "TopSell"}, {text = -232462753, next = "SellAll"}, {text = 1418881842, next = "Help"})
    elseif SpecialMerchantType == "shop_special_merchant_orb" then
      ShopSys:Talk(1978174988, nil)
      WINDOW:CloseMessage()
      CommonSys:OpenBasicMenu(nil, -1733859855, nil)
      ShopSys:TalkAskFlowNoClose(669914535, FACE_TYPE.NORMAL, {cursorReset = true}, {
        next = "ExitMerchant"
      }, {
        text = -153134861,
        next = "TopBuyBefore"
      }, {text = -1825301742, next = "TopSell"}, {text = -232462753, next = "SellAll"}, {text = 1418881842, next = "Help"})
    end
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.MenuTopLoop()
    ShopSys:SetSelectGoodsTbl(nil)
    CommonSys:OpenBasicMenu(nil, -1733859855, nil)
    ShopSys:TalkAskFlowNoClose(575459664, nil, {cursorReset = true}, {
      next = "ExitMerchant"
    }, {
      text = -1491615315,
      next = "TopBuyBefore"
    }, {text = 1054806496, next = "TopSell"}, {text = 523115072, next = "SellAll"}, {text = -109485632, next = "Help"})
    CommonSys:CloseBasicMenu()
  end
  function FlowSys.Proc.TopBuyBefore()
    if ShopSys:CheckLineup() == false then
      ShopSys:Talk(415508388, nil)
      FlowSys:Next("MenuTopLoop")
      return
    end
    if shopIns:CheckExistFeaturedProductItem() == true then
      if FlowSys.Stat.TalkFirst then
        if shopIns:CheckFeaturedProductItemLasyDay() == true then
          ShopSys:Talk(-991942462, nil)
        else
          ShopSys:Talk(1236756304, nil)
        end
      else
        ShopSys:Talk(1092143011, nil)
      end
    else
      ShopSys:Talk(1092143011, nil)
    end
    FlowSys.Stat.TalkFirst = false
    FlowSys:Next("TopBuy")
  end
  function FlowSys.Proc.TopBuy()
    WINDOW:CloseMessage()
    CommonSys:BeginLowerMenuNavi(nil, nil, false)
    DispShopSelectMenu(function()
      CommonSys:EndLowerMenuNavi(true)
      FlowSys:Next("Buy")
    end, function()
      CommonSys:EndLowerMenuNavi(true)
      FlowSys:Next("MenuTopLoop")
    end, function()
      FlowSys:Next("ItemGuide", "TopBuy")
    end, -1996904500, -1568252767, 270105400)
  end
  function FlowSys.Proc.ItemGuide(nextFlow)
    CommonSys:BeginLowerMenuNavi(nil, nil, false)
    DispItemGuide()
    CommonSys:EndLowerMenuNavi(true)
    FlowSys:Next(nextFlow)
  end
  function FlowSys.Proc.Buy()
    if ShopSys:CheckBuyablePrice() == false then
      ShopSys:Talk(-712902797, nil)
      FlowSys:Next("TopBuy")
      return
    end
    if ShopSys:CheckBagOver() == true then
      ShopSys:Talk(-1161120696, nil)
      FlowSys:Next("TopBuy")
      return
    end
    FlowSys:Next("ManyBuy")
  end
  function FlowSys.Proc.ManyBuy()
    ShopSys:SetShopTag("\233\129\184\230\138\158\227\129\151\227\129\159\233\129\147\229\133\183", ShopSys:GetSelectItemName())
    ShopSys:SetShopTag("\229\144\136\232\168\136\232\179\188\229\133\165\233\161\141", ShopSys:GetBuyPriceText())
    if ShopSys:CheckMultiSelect() == true then
      ShopSys:TalkAskFlowNoClose(229067525, nil, nil, {next = "TopBuy"}, {text = 228330404, next = "Payment"}, {
        text = -407229119,
        next = "TopBuy",
        default = true
      })
    else
      ShopSys:TalkAskFlowNoClose(-77635692, nil, nil, {next = "TopBuy"}, {text = 1133656479, next = "Payment"}, {
        text = 1450961103,
        next = "TopBuy",
        default = true
      })
    end
  end
  function FlowSys.Proc.Payment()
    ShopSys:Buy()
    SOUND:PlaySe(SymSnd("SE_ACT_MONEY"))
    ShopSys:Talk(-728260231)
    FlowSys:Next("SoldOut")
  end
  function FlowSys.Proc.SoldOut()
    if ShopSys:CheckLineup() == false then
      ShopSys:Talk(196331012, nil)
      FlowSys:Next("MenuTopLoop")
      return
    end
    if ShopSys:CheckMultiSelect() == true then
      FlowSys:Next("MenuTopLoop")
      return
    end
    if ShopSys:CheckBagFull() then
      FlowSys:Next("MenuTopLoop")
      return
    end
    ShopSys:TalkAskFlowNoClose(1512026629, nil, nil, {
      next = "MenuTopLoop"
    }, {text = -2133789075, next = "TopBuy"}, {
      text = 329990445,
      next = "MenuTopLoop"
    })
  end
  SetupCommonFlow_ShopSellFlow({
    TEXT_SELL_ITEM_SELECT = -680672142,
    TEXT_SELL_ALL = -1027255795,
    TEXT_SELL_ALL_YES = 38148183,
    TEXT_SELL_ALL_NO = 1841673258,
    TEXT_SELL_NO_ITEM = 1037979671,
    TEXT_SELL_NO_SELLITEM = -1835135517,
    TEXT_SELL_MAX_MONEY = -2141882039,
    TEXT_SELL_ALL_BANK = -1393478245,
    TEXT_SELL_MAX_BANK = -1288224629,
    TEXT_SELL_MAX_BANK_YES = -71604096,
    TEXT_SELL_MAX_BANK_NO = -967812282,
    TEXT_SELL_MAX_THANKS = -491319162,
    TEXT_CAPTION_SELL = -420962171,
    TEXT_SELL_SELECT_SELL = -1870100459,
    TEXT_SELL_SELECT_EXPLAIN = -888751705,
    TEXT_SELL_CONFIRM_PLURAL = -692549222,
    TEXT_SELL_CONFIRM_PLURAL_YES = -1407460003,
    TEXT_SELL_CONFIRM_PLURAL_NO = 301576052,
    TEXT_SELL_CONFIRM_NO_SELLITEM = -1777438609,
    TEXT_SELL_CONFIRM = -370235819,
    TEXT_SELL_CONFIRM_YES = -808581874,
    TEXT_SELL_CONFIRM_NO = 1938245907,
    TEXT_SELL_MAX_MONEY_TO_BANK = -648788656,
    TEXT_SELL_MAX_BANK = -1288224629,
    TEXT_SELL_MAX_BANK_YES = -71604096,
    TEXT_SELL_MAX_BANK_NO = -967812282,
    TEXT_SELL_MAX_THANKS = -491319162,
    TEXT_SELL_THANKS = 1924392764,
    TEXT_SELL_SERIES = -63179712,
    TEXT_SELL_SERIES_YES = -1523820623,
    TEXT_SELL_SERIES_NO = 1764257440
  })
  function FlowSys.Proc.Help()
    ShopSys:SetShopTag("\229\176\130\233\150\128\229\186\151\229\144\141", GetShopNameSpecial(shopIns))
    local SpecialMerchantType = shopIns:GetShopLabel()
    if SpecialMerchantType == "shop_special_merchant_plant" then
      ShopSys:Talk(1030066307, nil)
    elseif SpecialMerchantType == "shop_special_merchant_throw" then
      ShopSys:Talk(373867328, nil)
    elseif SpecialMerchantType == "shop_special_merchant_orb" then
      ShopSys:Talk(257159681, nil)
    end
    WINDOW:CloseMessage()
    FlowSys:Next("MenuTopLoop")
  end
  function FlowSys.Proc.ExitMerchant()
    ShopSys:Talk(2048567401, nil)
    FlowSys:Next("TESTEND")
  end
  function FlowSys.Proc.TESTEND()
    FlowSys:Return()
  end
  FlowSys:Call("MenuTopFirst")
  WINDOW:CloseMessage()
  FlowSys:Finish()
  ShopSys:Finish()
end
