-- NOTE: Buttons in the Group have to be named 1, 2, 3, ...

-- Variables
local list_size = 8
local button_value = {}                             
local list = {}
local old_button = 0

-- Initialization
for i = 1, list_size do
  list[i] = self:findByName(tostring(i))
  button_value[i] = 0
end


--------------------------------------------------------

function update()
  for i = 1, #list do                     
    if list[i].values.x ~= button_value[i] then     -- check if value of button 'i' has changed
      if list[i].values.x > 0 then                  -- check if button 'i' was switched on or off
        switch("ON", i)
      else
        switch("OFF", i)
      end
      button_value[i] = list[i].values.x            -- update button value in list
    end
  end
end

--------------------------------------------------------

function switch(command, button)
  
  if old_button ~= 0 then                              -- if other button is active then turn it off
    self.children[tostring(old_button)].values.x = 0
    button_value[old_button] = 0                       -- update value of old button in list
  end
  
  if command == "ON" then                           -- if a button was turned 'on' 
      old_button = button                             -- save the now active button for next 'super' action
  elseif command == "OFF" then                    -- if a button was turned 'off'
      old_button = 0                                  -- set now active button to 'none'
  end
    
end