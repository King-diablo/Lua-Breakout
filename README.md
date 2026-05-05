# Lua Breakout

A classic Breakout game implementation in Lua using the LÖVE 2D game framework.

## About

This project is a recreation of the classic Breakout arcade game, built while following the [CS50's Introduction to Game Development](https://www.edx.org/course/cs50s-introduction-to-game-development) tutorial series. It serves as a learning project to understand game development concepts and the LÖVE framework.

## Features

- **Paddle Control** - Move your paddle to bounce the ball
- **Brick Breaking** - Destroy all bricks to advance levels
- **High Scores** - Track your best scores
- **Multiple Levels** - Generated brick patterns for variety
- **Sound Effects** - Audio feedback for gameplay events
- **Smooth Physics** - Ball physics and collision detection

## Project Structure

- `main.lua` - Entry point
- `src/` - Core game source code
    - `states/` - Game state management (play, start, game over, etc.)
    - `ball.lua` - Ball entity and physics
    - `brick.lua` - Brick entity
    - `paddle.lua` - Paddle entity and controls
    - `constants.lua` - Game constants and configuration
    - `Dependencies.lua` - Game initialization
- `lib/` - Third-party libraries
- `graphics/` - Sprite and image assets
- `sounds/` - Audio assets
- `fonts/` - Custom fonts

## Requirements

- [LÖVE 2D](https://love2d.org/) (v11.4+)
- Lua 5.1+

## How to Run

1. Install LÖVE 2D from https://love2d.org/
2. Navigate to the project directory
3. Run: `love .`

## Learning Goals

This project demonstrates:

- Game loop architecture
- State management patterns
- Physics and collision detection
- Entity-component organization
- Event handling and input management
- Sprite rendering and animation
