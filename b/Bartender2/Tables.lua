local _G = getfenv(0)

AllButtons = {}
for i=1,12 do table.insert(AllButtons, _G["Bar1Button"..i]) end
for i=1,12 do table.insert(AllButtons, _G["Bar2Button"..i]) end
for i=1,12 do table.insert(AllButtons, _G["Bar3Button"..i]) end
for i=1,12 do table.insert(AllButtons, _G["Bar4Button"..i]) end
for i=1,12 do table.insert(AllButtons, _G["Bar5Button"..i]) end
for i=1,10 do table.insert(AllButtons, _G["Bar6Button"..i]) end
for i=1,10 do table.insert(AllButtons, _G["Bar7Button"..i]) end
for i=1,5  do table.insert(AllButtons, _G["Bar8Button"..i]) end
for i=1,8  do table.insert(AllButtons, _G["Bar9Button"..i]) end
for i=1,12 do table.insert(AllButtons, _G["Bar10Button"..i]) end

AllIcons = {}
for i=1,12 do table.insert(AllIcons, _G["Bar1Button"..i.."Icon"]) end
for i=1,12 do table.insert(AllIcons, _G["Bar1Button"..i.."Icon"]) end
for i=1,12 do table.insert(AllIcons, _G["Bar2Button"..i.."Icon"]) end
for i=1,12 do table.insert(AllIcons, _G["Bar3Button"..i.."Icon"]) end
for i=1,12 do table.insert(AllIcons, _G["Bar4Button"..i.."Icon"]) end
for i=1,12 do table.insert(AllIcons, _G["Bar5Button"..i.."Icon"]) end
for i=1,10 do table.insert(AllIcons, _G["Bar6Button"..i.."Icon"]) end
for i=1,10 do table.insert(AllIcons, _G["Bar7Button"..i.."Icon"]) end
for i=1,5  do table.insert(AllIcons, _G["Bar8Button"..i.."Icon"]) end
for i=1,12 do table.insert(AllIcons, _G["Bar10Button"..i.."Icon"]) end

AllNormalTextures = {}
for i=1,12 do table.insert(AllNormalTextures, _G["Bar1Button"..i.."NT"]) end
for i=1,12 do table.insert(AllNormalTextures, _G["Bar2Button"..i.."NT"]) end
for i=1,12 do table.insert(AllNormalTextures, _G["Bar3Button"..i.."NT"]) end
for i=1,12 do table.insert(AllNormalTextures, _G["Bar4Button"..i.."NT"]) end
for i=1,12 do table.insert(AllNormalTextures, _G["Bar5Button"..i.."NT"]) end
for i=1,10 do table.insert(AllNormalTextures, _G["Bar6Button"..i.."NT"]) end
for i=1,10 do table.insert(AllNormalTextures, _G["Bar7Button"..i.."NT"]) end
for i=1, 5 do table.insert(AllNormalTextures, _G["Bar8Button"..i.."NT"]) end
for i=1,12 do table.insert(AllNormalTextures, _G["Bar10Button"..i.."NT"]) end