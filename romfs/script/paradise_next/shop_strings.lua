function GetExtraShopName(shopLabel)
  local extraShopNameTbl = {
    shop_special_merchant_throw = {
      [LANGUAGE_TYPE.EN] = "Stones\227\128\128and\227\128\128Spikes",
      [LANGUAGE_TYPE.FR] = "Pierres\227\128\128et\227\128\128Epines",
      [LANGUAGE_TYPE.GE] = "Steine\227\128\128und\227\128\128Dornen",
      [LANGUAGE_TYPE.IT] = "Pietre,\227\128\128Punte\227\128\128e\227\128\128Spine",
      [LANGUAGE_TYPE.SP] = "Piedras\227\128\128y\227\128\128Clavos"
    }
  }
  if extraShopNameTbl[shopLabel] then
    local eLanguageType = SYSTEM:GetLanguageType()
    if extraShopNameTbl[shopLabel][eLanguageType] then
      return extraShopNameTbl[shopLabel][eLanguageType]
    else
      return extraShopNameTbl[shopLabel][LANGUAGE_TYPE.EN]
    end
  end
  return nil
end
function GetLandShopNameTextIdForTitle(shopLabel)
  local landTypeNameTbl = {
    reclamation_weed = 1989378931,
    reclamation_wood = -1952329977,
    reclamation_water = -634815408,
    reclamation_rock = 567129807
  }
  local extraName = GetExtraShopName(shopLabel)
  if extraName then
    return extraName
  elseif landTypeNameTbl[shopLabel] then
    return landTypeNameTbl[shopLabel]
  else
    return GROUND:GetLandShopNameTextId(shopLabel)
  end
end
function GetLandShopNameTextStringForTitle(shopLabel)
  local idOrText = GetLandShopNameTextIdForTitle(shopLabel)
  if shopLabel=="shop_special_merchant_throw" then
    return idOrText
  else
    return MENU:GetTextPoolText(idOrText)
  end
end
function GetLandShopExplainTextIdForDesc(nowShopId, nextShopLevel)
  --local extraShopExplainTbl = {
  --  shop_special_merchant_throw = {
  --    [LANGUAGE_TYPE.EN] = "\235\132\128This\227\128\128is\227\128\128a\227\128\128specialty\227\128\128shop\227\128\128for\227\128\128Stones[R]and\227\128\128spikes!\227\128\128You\227\128\128can\227\128\128buy\227\128\128Stones\227\128\128and\227\128\128spikes[R]anytime\227\128\128and\227\128\128sell\227\128\128them\227\128\128for\227\128\128higher\227\128\128prices![R]As\227\128\128it\227\128\128gets\227\128\128upgraded,\227\128\128it'll\227\128\128carry\227\128\128rare\227\128\128ones!\235\132\144",
  --    [LANGUAGE_TYPE.FR] = "\235\132\128Cette\227\128\128boutique\227\128\128est\227\128\128spécialisée\227\128\128dans\227\128\128les[R]Pierres\227\128\128et\227\128\128les\227\128\128épines.\227\128\128Vous\227\128\128pouvez\227\128\128en[R]acheter,\227\128\128mais\227\128\128aussi\227\128\128y\227\128\128vendre\227\128\128les\227\128\128vôtres[R]à\227\128\128un\227\128\128prix\227\128\128supérieur\227\128\128au\227\128\128prix\227\128\128du\227\128\128marché.[R]Plus\227\128\128elle\227\128\128s'améliore,\227\128\128plus\227\128\128elle\227\128\128propose[R]des\227\128\128Pierres\227\128\128et\227\128\128épines\227\128\128rares.\235\132\144",
  --    [LANGUAGE_TYPE.GE] = "\235\132\128This\227\128\128is\227\128\128a\227\128\128specialty\227\128\128shop\227\128\128for\227\128\128Stones[R]and\227\128\128spikes!\227\128\128You\227\128\128can\227\128\128buy\227\128\128Stones\227\128\128and\227\128\128spikes[R]anytime\227\128\128and\227\128\128sell\227\128\128them\227\128\128for\227\128\128higher\227\128\128prices![R]As\227\128\128it\227\128\128gets\227\128\128upgraded,\227\128\128it'll\227\128\128carry\227\128\128rare\227\128\128ones!\235\132\144",
  --    [LANGUAGE_TYPE.IT] = "\235\132\128This\227\128\128is\227\128\128a\227\128\128specialty\227\128\128shop\227\128\128for\227\128\128Stones[R]and\227\128\128spikes!\227\128\128You\227\128\128can\227\128\128buy\227\128\128Stones\227\128\128and\227\128\128spikes[R]anytime\227\128\128and\227\128\128sell\227\128\128them\227\128\128for\227\128\128higher\227\128\128prices![R]As\227\128\128it\227\128\128gets\227\128\128upgraded,\227\128\128it'll\227\128\128carry\227\128\128rare\227\128\128ones!\235\132\144",
  --    [LANGUAGE_TYPE.SP] = "\235\132\128This\227\128\128is\227\128\128a\227\128\128specialty\227\128\128shop\227\128\128for\227\128\128Stones[R]and\227\128\128spikes!\227\128\128You\227\128\128can\227\128\128buy\227\128\128Stones\227\128\128and\227\128\128spikes[R]anytime\227\128\128and\227\128\128sell\227\128\128them\227\128\128for\227\128\128higher\227\128\128prices![R]As\227\128\128it\227\128\128gets\227\128\128upgraded,\227\128\128it'll\227\128\128carry\227\128\128rare\227\128\128ones!\235\132\144"
  --  }
  --}
  local extraShopExplainTbl = {
  }
  if extraShopExplainTbl[nowShopId] then
    local eLanguageType = SYSTEM:GetLanguageType()
    if extraShopExplainTbl[nowShopId][eLanguageType] then
      return extraShopExplainTbl[nowShopId][eLanguageType]
    else
      return extraShopExplainTbl[nowShopId][LANGUAGE_TYPE.EN]
    end
  else
    return GROUND:GetLandShopExplainTextId(nowShopId, nextShopLevel)
  end
end
function GetShopNameSpecial(shopIns)
  local extraName = GetExtraShopName(shopIns:GetShopLabel())
  if extraName then
    return extraName
  end
  return shopIns:GetShopName()
end