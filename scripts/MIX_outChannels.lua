local button = self:findByName("bON")
local fader = self:findByName("fLevel")
local button_old = 0
local tv

local colorOn = Color.fromHexString("FFA70BFF")   -- color ON
local colorOff = Color.fromHexString("FFFFFFFF")  -- color OFF

--- Init ---
button.properties.color = colorOff
button.values.x = 0

-------------------------------------------------------------
function update()
  tv = button.values.x
  if(tv ~= button_old) then
    if(tv > 0) then
      button.properties.color = colorOn
    else
      button.properties.color = colorOff
    end
    button_old = tv 
  end
end