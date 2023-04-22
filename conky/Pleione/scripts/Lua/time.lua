words = {"Bir ", "İki ", "Üç ", "Dört ", "Beş ", "Altı ", "Yedi ", "Sekiz ", "Dokuz "}
words1 = {"Biri ", "İkiyi ", "Üçü ", "Dördü ", "Beşi ", "Altıyı ", "Yediyi ", "Sekizi ", "Dokuzu "}
levels = {"THOUSAND ", "MILLION ", "BILLION ", "TRILLION ", "QUADRILLION ", "QUINTILLION ", "SEXTILLION ", "SEPTILLION ", "OCTILLION ", [0] = ""}
iwords = {"On ", "Yirmi ", "Otuz ", "Kırk ", "Elli ", "Altmış ", "Yetmiş ", "Seksen ", "Doksan "}
twords = {"On Bir ", "On İki ", "On Üç ", "On Dört ", "On Beş ", "On Altı ", "On Yedi ", "On Sekiz ", "On Dokuz "}
iwords1 = {"Onu ", "Yirmiyi ", "Otuz ", "Kırk ", "Elli ", "Altmış ", "Yetmiş ", "Seksen ", "Doksan "}
twords1 = {"On Biri ", "On İkiyi ", "On Üçü ", "On Dördü ", "On Beşi ", "On Altıyı ", "On Yediyi ", "On Sekizi ", "On Dokuzu "}

function digits(n)
  local i, ret = -1
  return function()
    i, ret = i + 1, n % 10
    if n > 0 then
      n = math.floor(n / 10)
      return i, ret
    end
  end
end

level = false
function getname(pos, dig)
  level = level or pos % 3 == 0
  if(dig == 0) then return "" end
  local name = (pos % 3 == 1 and iwords[dig] or words[dig]) .. (pos % 3 == 2 and "HUNDRED " or "")
  if(level) then name, level = name .. levels[math.floor(pos / 3)], false end
  return name
end

function getnameHour(pos, dig)
  level = level or pos % 3 == 0
  if(dig == 0) then return "" end
  local name = (pos % 3 == 1 and iwords1[dig] or words1[dig]) .. (pos % 3 == 2 and "HUNDRED " or "")
  if(level) then name, level = name .. levels[math.floor(pos / 3)], false end
  return name
end

function numberToWord(number)
    if(number == 0) then return "O'Clock " end
    vword = ""
    for i, v in digits(number) do
      vword = getname(i, v) .. vword
    end

    for i, v in ipairs(words) do
      vword = vword:gsub("TY " .. v, "TY-" .. v)
      vword = vword:gsub("Ten " .. v, twords[i])
    end
    return vword
end

function numberToWordHour(number)
  if(number == 0) then return "O'Clock " end
    vword = ""
  for i, v in digits(number) do
    vword = getnameHour(i, v) .. vword
  end

  for i, v in ipairs(words1) do
    vword = vword:gsub("TY " .. v, "TY-" .. v)
    vword = vword:gsub("Ten " .. v, twords1[i])
  end
  return vword
end

function conky_Hour()
    return numberToWordHour(os.date("%I") + 0)
end

function conky_Minute()
    return numberToWord(os.date("%M") + 0)
end

function conky_Date()
    return numberToWord(os.date("%d") + 0)
end
