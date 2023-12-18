-- Variables
local list_size = 16
local button_value = {}                             
local list = {}
local old_button = 0
local xypad = {}
local xygroup = self.parent:findByName("gXY")
local xypoints = {}
local xyclear = true

local color0 = Color.fromHexString("7F7F7FFF")
local color1 = Color.fromHexString("88D3FFFF")
local color2 = Color.fromHexString("FF6CDEFF")
local color3 = Color.fromHexString("FF993EFF")
local color0t = Color.fromHexString("7F7F7F00")
local color1t = Color.fromHexString("88D3FF30")
local color2t = Color.fromHexString("FF6CDE30")
local color3t = Color.fromHexString("FF993E30")


-- Initialization
for i = 1, list_size do
  list[i] = self:findByName(tostring(i))
  button_value[i] = 0
  xypad[i] = xygroup.children[i]
  xypad[i].properties.visible = 1
  xypad[i].properties.background = 0
  xypad[i].properties.interactive = 0
  xypad[i].values.x = 0.5
  xypad[i].values.y = 0.5
  xypoints[i] = {xypad[i].values.x, xypad[i].values.y}
  if (i >= 1 and i <= 4) then
    xypad[i].properties.color = color1t
  elseif (i >= 5 and i <= 6) then
    xypad[i].properties.color = color0t
    xypad[i].properties.visible = 0
  elseif (i >= 7 and i <= 8) then
    xypad[i].properties.color = color2t
  elseif (i >= 9 and i <= 16) then
    xypad[i].properties.color = color3t
  end
end

--------------------------------------------------------

function update()
  for i = 1, #list do                     
    if list[i].values.x ~= button_value[i] then     -- check if value of button 'i' has changed
      if list[i].values.x > 0 then                  -- check if button 'i' was switched on or off
        switch("ON", i)
        xyclear = false
      else
        switch("OFF", i)
        xyclear = true
      end
      button_value[i] = list[i].values.x            -- update button value in list
    end
  end
  
--  if (xyclear) then
--    for i = 1, #list do
--      xypad[i].properties.color = color0
--      xypad[i].properties.visible = 1
--      xypad[i].properties.interactive = 0
--    end
--  end
  
end

--------------------------------------------------------

function switch(command, button)
  if old_button ~= 0 then                              -- if other button is active then turn it off
    self.children[tostring(old_button)].values.x = 0
    button_value[old_button] = 0                       -- update value of old button in list
    xypoints[old_button][1] = xypad[button].values.x    -- save xy value of old button
    xypoints[old_button][2] = xypad[button].values.y    -- "
    xypad[old_button].properties.interactive = 0        -- make old button inactive...
--    xypad[old_button].properties.visible = 0            -- ... and invisible
    if (button >= 1 and button <= 4) then
      xypad[old_button].properties.color = color1t
    elseif (button >= 7 and button <= 8) then
      xypad[old_button].properties.color = color2t
    elseif (button >= 9 and button <= 16) then
      xypad[old_button].properties.color = color3t
    else
      xypad[old_button].properties.color = color0t
    end
  end
  
  if command == "ON" then                              -- if a button was turned 'on' 
    old_button = button                                -- save the now active button for next 'super' action
    xypad[button].properties.interactive = 1
    xypad[button].properties.visible = 1
    if (button >=1 and button <= 4) then
      xypad[button].properties.color = color1
    elseif (button >= 7 and button <= 8) then
      xypad[button].properties.color = color2
    elseif (button >= 9 and button <= 16) then
      xypad[button].properties.color = color3
    else
      xypad[button].properties.interactive = 0
      xypad[button].properties.color = color0
    end      
  elseif command == "OFF" then                    -- if a button was turned 'off'
    old_button = 0                                -- set now active button to 'none'
--    xypad[button].properties.visible = 0
--    xypad[button].properties.color = color0t
    xypad[button].properties.interactive = 0
--    xypad[button].properties.visible = 0
    if (button >= 1 and button <= 4) then
      xypad[button].properties.color = color1t
    elseif (button >= 7 and button <= 8) then
      xypad[button].properties.color = color2t
    elseif (button >= 9 and button <= 16) then
      xypad[button].properties.color = color3t
    else
      xypad[button].properties.color = color0t
    end
  end
end