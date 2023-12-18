--- Variables
local bCue = self:findByName("bCue")          -- cue button
local fCue = self:findByName("fCue")          -- cue fader
local bCapture = self:findByName("bCapture")  -- capture button
local lCapture = self:findByName("lCapture")  -- capture label
local bSelect = self:findByName("bSelect")    -- select button
local lSelect = self:findByName("lSelect")    -- select label
local bDO = {}                                -- direct-out buttons
bDO[1] = self:findByName("bDO1")            -- "
bDO[2] = self:findByName("bDO2")            -- "
bDO[3] = self:findByName("bDO3")            -- "
bDO[4] = self:findByName("bDO4")            -- "

local bCue_old = 0                            -- cue button OLD
local bCapture_old = 0                        -- capture button OLD
local bSelect_old = 0                         -- select button OLD
local bDO_old = {}                            -- direct-out buttons OLD
local bDO_last = 0


local colorOn = Color.fromHexString("FFA70BFF")   -- color ON
local colorOff = Color.fromHexString("FFFFFFFF")  -- color OFF

local testValue = 0                           -- temp value to evaluate

--- Init
fCue.properties.interactive = 0
bSelect.properties.visible = 0
lCapture.values.text = "capture"
for i = 1, #bDO do
  bDO_old[i] = 0
end


--------------------------------------------------------
function update()
  --- CAPTURE ---
  testValue = bCapture.values.x
  if (testValue ~=bCapture_old) then
    if testValue > 0 then
--      bSelect.properties.visible = 1
--      lSelect.properties.visible = 1
      bCapture.properties.color = colorOn
      lCapture.values.text = "record"
    else
--      bSelect.properties.visible = 0
--      lSelect.properties.visible = 0
      bCapture.properties.color = colorOff
      lCapture.values.text = "capture"
    end
    bCapture_old = testValue
  end
  
  --- SELECT ---
  testValue = bSelect.values.x
  if testValue ~= bSelect_old then
    if testValue > 0 then
      bSelect.properties.visible = 1
      lSelect.properties.visible = 1
      bSelect.properties.color = colorOn
--      bCapture.values.x = 0
    else
      bSelect.properties.visible = 0
      lSelect.properties.visible = 0
      bSelect.properties.color = colorOff
    end
    bSelect_old = testValue
  end
  
  --- CUE FADER ---
  testValue = bCue.values.x
  if testValue ~= bCue_old then
    if testValue > 0 then
      fCue.properties.interactive = 1
      fCue.properties.color = colorOn
      bCue.properties.color = colorOn
    else
      fCue.properties.interactive = 0
      fCue.properties.color = colorOff
      bCue.properties.color = colorOff
    end
    bCue_old = testValue
  end
  
  --- DIRECT OUT ---
  
  for i = 1, #bDO do
    testValue = bDO[i].values.x
    if testValue ~= bDO_old[i] then
      if testValue > 0 then
        DO_switch("ON", i)
      else
        DO_switch("OFF", i)
      end
      bDO_old[i] = testValue
    end
  end
  
  --- LOCKING BUTTONS ---
  
  if bDO_last ~= 0 then
    bCapture.properties.interactive = 0
  else
    bCapture.properties.interactive = 1
  end
end

--------------------------------------------------------

function DO_switch(command, button)
--  if bDO_last ~= 0 then
--    self.children[("bDO"..tostring(bDO_last))].values.x = 0
--    self.children[("bDO"..tostring(bDO_last))].properties.color = colorOff
--    bDO_old[bDO_last] = 0
--  end
  
  if command == "ON" then
    self.children[("bDO"..tostring(button))].properties.color = colorOn
    bDO_last = button
  elseif command == "OFF" then
    self.children[("bDO"..tostring(button))].properties.color = colorOff
    bDO_last = 0
  end
end