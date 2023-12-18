local buttons = {}      -- array of all ON buttons
local buttons_old = {}  -- array of old values
local testValue         -- value to be tested
local fader = self:findByName("fLevel")
local zeroDb = 0.9211


local colorOn = Color.fromHexString("FFA70BFF")   -- color ON
local colorOff = Color.fromHexString("FFFFFFFF")  -- color OFF
local colorAbove0 = Color.fromHexString("FF0006FF")
local colorBelow0 = Color.fromHexString("FFFFFFFF")

buttons[1] = self:findByName("bON")
buttons[2] = self:findByName("bAFL")

for i = 1, #buttons do
  buttons_old[i] = 0
end


function update()
  --- buttons color control
  for i = 1, #buttons do
    testValue = buttons[i].values.x
    if testValue ~= buttons_old[i] then
      if testValue > 0 then
        buttons[i].properties.color = colorOn
      else
        buttons[i].properties.color = colorOff
      end
      buttons_old[i] = testValue
    end
  end
  
  --- fader color control
  if fader.values.x > zeroDb then
    fader.properties.color = colorAbove0
  else
    fader.properties.color = colorBelow0
  end
end