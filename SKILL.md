---
name: open-brush-plugin-skill
description: Create and modify Lua plugins for Open Brush with full API documentation access. Use when the user wants to create Open Brush plugins, work with Lua scripts for Open Brush, or asks about Open Brush scripting API, Lua functions, or plugin development.
---

# Open Brush Lua Plugin Development

This skill helps you create and modify Lua plugins for Open Brush, a VR painting application. You have access to the complete Open Brush Lua API documentation.

## Quick Start

### Plugin File Structure
Open Brush Lua plugins are `.lua` files placed in the Open Brush plugins directory. A basic plugin structure:

```lua
-- Plugin metadata
--[[
  Plugin Name: My Plugin
  Description: What this plugin does
  Author: Your Name
]]

-- Initialization
function init()
  -- Setup code runs once when plugin loads
end

-- Update loop (optional)
function update()
  -- Runs every frame
end

-- Custom functions
function myFunction()
  -- Your plugin logic
end
```

### API Documentation
**Primary Reference**: https://icosa.gitbook.io/open-brush-plugin-scripting-docs

The API is organized into these major categories:

#### Core Objects
- `App` - Application-level functions and settings
- `Sketch` - Access and modify the current sketch
- `User` - User position, orientation, and input
- `Tool` - Current brush/tool settings
- `Headset` - VR headset information
- `Spectator` - Spectator camera control

#### Spatial & Transformation
- `Transform` - Position, rotation, and scale
- `Vector2`, `Vector3`, `Vector4` - Vector math
- `Rotation` - Quaternion rotations
- `Path`, `Path2d` - Path manipulation
- `Matrix` - Matrix transformations

#### Visual Elements
- `Brush` - Brush types and settings
- `Stroke` - Individual brush strokes
- `Layer` - Layer management
- `Group` - Grouped objects
- `Color` - Color manipulation
- `Image`, `Video` - Media references
- Corresponding `List` variants (StrokeList, LayerList, etc.)

#### Environment & Scene
- `Environment` - Skybox, lighting, fog
- `CameraPath` - Camera path recording
- `Guide` - Reference guides and grids
- `Model` - 3D model references
- `Wand` - Controller/wand state

#### Advanced Features
- `Selection` - Object selection
- `Symmetry` - Symmetry modes and settings (SymmetryMode, SymmetryPointType, SymmetrySettings, SymmetryWallpaperType)
- `Easing` - Easing functions for animation
- `Timer` - Timing and delays
- `Random` - Random number generation
- `Math` - Extended math functions
- `Visualizer`, `Waveform` - Audio visualization

#### Utilities
- `Svg` - SVG import/export
- `Webrequest` - HTTP requests

## Common Plugin Patterns

### Accessing the Current Sketch
```lua
local sketch = App.sketch()
local strokes = sketch:strokes()
```

### Working with Strokes
```lua
function processAllStrokes()
  local strokes = App.sketch():strokes()
  for i = 0, strokes:count() - 1 do
    local stroke = strokes:item(i)
    -- Process stroke
  end
end
```

### Getting User Position/Rotation
```lua
local userPos = User.position()
local userRot = User.rotation()
```

### Creating Custom Tools/Commands
```lua
function onToolTrigger()
  -- Respond to controller trigger
  local controlPoints = {}
  -- Build stroke data
  App.sketch():createStroke(controlPoints)
end
```

### Using Timers
```lua
local myTimer = Timer.new()
myTimer:start()

function update()
  if myTimer:elapsed() > 5.0 then
    -- Do something after 5 seconds
    myTimer:reset()
  end
end
```

### Working with Selections
```lua
local selection = App.sketch():selection()
if selection:count() > 0 then
  -- Process selected items
end
```

## Best Practices

1. **Use init() for Setup**: Put initialization code in the `init()` function
2. **Optimize update()**: Keep the `update()` function lightweight as it runs every frame
3. **Check for nil**: Always validate objects exist before accessing them
4. **Use Local Variables**: Local variables are faster than global ones
5. **Comment Your Code**: Explain what your plugin does and any complex logic
6. **Test Incrementally**: Test each function as you build it
7. **Handle Errors**: Use `pcall()` for operations that might fail

## Debugging Tips

- Use `print()` statements to log values to the Open Brush console
- Check the Open Brush log files for error messages
- Test with simple operations first before adding complexity
- Verify API calls with the documentation

## Instructions for AI Agents

### Critical API Rules

**MOST IMPORTANT**: Only use APIs listed in `./LuaModules/__autocomplete.lua`. NEVER invent methods or properties. If unsure, say "I'm unsure - let me check the API documentation" and read `__autocomplete.lua`. Favor the Open Brush API over standard Lua library functions.

**Core Syntax Rules**:
- Constructors: `ClassName:New(...)` (capital N, always use colon)
- Properties: `object.property` (dot notation)
- Methods: `object:method()` (colon notation)
- API classes start with capital letters (e.g., `Vector3`, `Transform`, `Path`)
- Methods do NOT return self - no method chaining
- Use `Math` (capital M) library, not lua's `math`

**Plugin Structure**:
All plugins define:
- `Main()` - called every frame (required)
- `Start()` - called when plugin begins (optional)
- `End()` - called when plugin ends (optional)
- `Settings` table - plugin metadata (optional)
- `Parameters` table - UI sliders for user input (optional)

```lua
Settings = {
  description = "Plugin description",
  space = "pointer" -- or "canvas", "world", etc.
}

Parameters = {
  speed = {label = "Speed", type = "float", min = 1, max = 100, default = 50}
}
-- Access as: Parameters.speed
```

**Four Plugin Types** (determined by return value from `Main()`):

1. **Pointer Plugin** - Returns single `Transform`
   - Modifies brush pointer position while user draws
   - Changes position/rotation of current stroke in real-time

2. **Symmetry Plugin** - Returns `Path` or list of `Transform`
   - Creates multiple brush pointers
   - Each transform = one additional stroke

3. **Tool Plugin** - Returns `Path` or `PathList`
   - Generates complete strokes in one action
   - Typically triggered on button press/release

4. **Background Plugin** - Returns nothing
   - Runs autonomously every frame
   - Draws strokes using explicit `Draw()` methods

**Important Constraints**:
- Brush color/type/size cannot change during a stroke (only between strokes)
- Understand coordinate spaces - default varies by plugin type (check Settings.space)
- Transform scale component affects stroke width/thickness

**For complete details, examples, and edge cases, read `./instructions.md`**


### Accessing Documentation

All documentation is included locally in this skill:

- **`./LuaDocs/`** - Complete API reference (app.md, stroke.md, vector3.md, etc.)
- **`./MainDocs/`** - Tutorials and guides (writing-plugins/, example-plugins/)
- **`./examples/`** - Real plugin examples (BackgroundScript.*, PointerScript.*, SymmetryScript.*, ToolScript.*)
- **`./LuaModules/__autocomplete.lua`** - Complete list of all valid API classes, methods, and properties

Use the Read tool to access any documentation file directly.

**External references** (for context only):
- GitHub: [API Docs](https://github.com/icosa-foundation/open-brush-plugin-scripting-docs), [Tutorials](https://github.com/icosa-foundation/open-brush-docs)
- Web viewer: https://icosa.gitbook.io/open-brush-plugin-scripting-docs

### Plugin Development Guidelines

When helping users with Open Brush Lua plugins:

1. **Verify API calls** - Check the documentation before using functions to ensure they exist and understand their parameters
2. **Ask clarifying questions** about what the plugin should do before writing code
3. **Follow Lua best practices** - use local variables, proper indentation, clear naming
4. **Provide complete, working examples** that users can copy and test
5. **Explain the code** - add comments and describe what each section does
6. **Suggest testing approaches** - how to verify the plugin works
7. **Consider performance** - warn if operations might be slow (e.g., processing thousands of strokes every frame)
8. **Reference the right docs** - API docs for function signatures, main docs for concepts and tutorials

## Example Plugin Templates

### Simple Stroke Counter
```lua
--[[
  Plugin Name: Stroke Counter
  Description: Counts total strokes in sketch
]]

function init()
  print("Stroke Counter initialized")
end

function countStrokes()
  local sketch = App.sketch()
  local strokes = sketch:strokes()
  local count = strokes:count()
  print("Total strokes: " .. count)
  return count
end
```

### Position Logger
```lua
--[[
  Plugin Name: Position Logger
  Description: Logs user position every 2 seconds
]]

local timer = Timer.new()

function init()
  timer:start()
end

function update()
  if timer:elapsed() > 2.0 then
    local pos = User.position()
    print(string.format("User at: %.2f, %.2f, %.2f", pos.x, pos.y, pos.z))
    timer:reset()
  end
end
```

## Additional Resources

- **API Documentation Repository**: https://github.com/icosa-foundation/open-brush-plugin-scripting-docs
- **Main Documentation Repository**: https://github.com/icosa-foundation/open-brush-docs
- **Example Plugins**: Browse the `LuaScriptExamples` directory in the API docs repo for real-world plugin examples
