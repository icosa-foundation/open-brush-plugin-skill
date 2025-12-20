# Open Brush Plugin Skill for Claude Code

A Claude Code skill for creating and modifying Lua plugins for Open Brush. This skill provides full access to the Open Brush Lua API documentation and assists with plugin development.

## Features

- Complete Open Brush Lua API documentation included locally
- Plugin templates and common patterns
- Code examples and best practices
- Fast local documentation access
- Optional MCP server integration for enhanced performance

## Installation

Install this skill globally for use across all your projects:

```bash
git clone https://github.com/icosa-foundation/open-brush-plugin-skill.git ~/.claude/skills/open-brush-plugin-skill
```

The skill will be automatically available in Claude Code after installation.

## Usage

Once installed, Claude will automatically use this skill when you:

- Ask to create an Open Brush plugin
- Work with Lua scripts for Open Brush
- Ask about the Open Brush scripting API
- Request information about Lua functions or plugin development

### Example Prompts

```
"Create a plugin that draws a spiral when I press the trigger"
"How do I get the current user position in Open Brush?"
"Write a plugin that colors strokes based on their layer"
"What functions are available in the Stroke class?"
```

## What's Included

### API Documentation

The `docs/` directory contains the complete Open Brush Lua API reference:

- **Core Objects**: App, Sketch, User, Tool, Headset, Spectator
- **Spatial & Transformation**: Transform, Vector2/3/4, Rotation, Path, Matrix
- **Visual Elements**: Brush, Stroke, Layer, Group, Color, Image, Video
- **Environment & Scene**: Environment, CameraPath, Guide, Model
- **Advanced Features**: Selection, Symmetry, Easing, Timer, Random, Math
- **Utilities**: Svg, Webrequest, Visualizer, Waveform

### Examples

The `examples/` directory contains sample plugins demonstrating common patterns and techniques.

## Updating

To get the latest API documentation and skill improvements:

```bash
cd ~/.claude/skills/open-brush-plugin-skill
git pull
```

The documentation in this repo is automatically synced from the [official Open Brush plugin scripting docs](https://github.com/icosa-foundation/open-brush-plugin-scripting-docs).

## Optional: Enhanced Performance with MCP

For advanced users, you can optionally configure the GitBook MCP server for faster documentation queries:

```bash
claude mcp add --transport http gitbook-openbrush https://icosa.gitbook.io/open-brush-plugin-scripting-docs/~gitbook/mcp
```

This enables structured queries across all documentation but is not required for normal use.

## Documentation Sources

- **This Skill (Local)**: Fast access to API documentation included in `./docs/`
- **API Reference**: https://github.com/icosa-foundation/open-brush-plugin-scripting-docs
- **Tutorials & Guides**: https://github.com/icosa-foundation/open-brush-docs
- **Web Viewer**: https://icosa.gitbook.io/open-brush-plugin-scripting-docs

## Contributing

This skill is maintained by the Icosa Foundation. The API documentation is automatically synced from the source repositories.

For issues or suggestions:
- Skill issues: https://github.com/icosa-foundation/open-brush-plugin-skill/issues
- Documentation issues: https://github.com/icosa-foundation/open-brush-plugin-scripting-docs/issues

## License

[Add appropriate license information]

## About Open Brush

Open Brush is an open-source VR painting application. Learn more at:
- Website: https://openbrush.app
- GitHub: https://github.com/icosa-foundation/open-brush
