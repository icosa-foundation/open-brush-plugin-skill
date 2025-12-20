--[[
  Plugin Name: Rainbow Effect
  Description: Cycles through rainbow colors over time
  Author: Icosa Foundation

  Usage:
    - This plugin runs automatically when loaded
    - The brush color will cycle through the rainbow
    - Paint strokes to see the color changing effect

  Demonstrates:
    - Color manipulation
    - Tool/brush access
    - Smooth animation with timers
    - HSV to RGB color conversion
]]

-- State variables
local hue = 0.0 -- Current hue value (0-360)
local hueSpeed = 30.0 -- Degrees per second
local timer = Timer.new()

-- Initialize the plugin
function init()
  print("Rainbow Effect plugin initialized")
  print("Your brush will now cycle through rainbow colors!")
  timer:start()
end

-- Update function runs every frame
function update()
  -- Get elapsed time since last frame
  local deltaTime = timer:elapsed()

  -- Update hue based on time
  hue = hue + (hueSpeed * deltaTime)

  -- Wrap hue around 360 degrees
  if hue >= 360.0 then
    hue = hue - 360.0
  end

  -- Convert HSV to RGB
  local color = hsvToRgb(hue, 1.0, 1.0)

  -- Get current tool and set its color
  local tool = App.tool()
  if tool then
    tool:setColor(color)
  end

  -- Reset timer for next frame
  timer:reset()
  timer:start()
end

-- Helper function: Convert HSV to RGB
-- h: hue (0-360), s: saturation (0-1), v: value (0-1)
-- Returns a Color object
function hsvToRgb(h, s, v)
  local h_normalized = h / 60.0
  local c = v * s
  local x = c * (1 - math.abs((h_normalized % 2) - 1))
  local m = v - c

  local r, g, b

  if h_normalized < 1 then
    r, g, b = c, x, 0
  elseif h_normalized < 2 then
    r, g, b = x, c, 0
  elseif h_normalized < 3 then
    r, g, b = 0, c, x
  elseif h_normalized < 4 then
    r, g, b = 0, x, c
  elseif h_normalized < 5 then
    r, g, b = x, 0, c
  else
    r, g, b = c, 0, x
  end

  -- Create and return a Color object
  return Color.new(r + m, g + m, b + m, 1.0)
end
