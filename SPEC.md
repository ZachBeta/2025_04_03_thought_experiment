# PartyRecall

A demonstration app showing how AI memory and context works through an interactive party planning interface.

## Core Concept
- Interactive chat interface demonstrating AI context window limitations
- Uses party planning as a relatable way to show how AI remembers and forgets information
- Designed for general audience (friends and family) to understand AI concepts

## Technical Stack
- Ruby on Rails
- Hotwire for real-time updates
- Bulma for CSS
- SQLite database

## UI Components

### Chat Interface
- iMessage-style chat bubbles
- Tutorial overlay for guided progression
- Clear visual distinction between "remembered" and "forgotten" messages

### Memory Visualization
1. Message Highlighting System
   - Current context: Fully bright/highlighted
   - About to be forgotten: Warning state/partially faded
   - Out of context: Greyed out

2. Progress Bar Component
   - Total capacity: 100 memory units
   - Each message shows:
     - Message ID (1, 2, 3, etc.)
     - Size (rounded to 2 significant figures)
     - Proportional space in bar
   - Visual format: `[1:15][2:08][3:25][4:12][5:13]│░░░░░░░░░░░░░░│`

### Memory Size Parameters
- Context window: 5-10 messages
- Message sizes:
  - Short messages: ~10 units
  - Medium messages: ~15-20 units
  - Long messages: ~25-30 units

## Tutorial Flow

### Initial Sequence
1. Introduction to memory system
2. Basic party planning messages:
   - "Let's plan a party" (small)
   - "Party time!" (small)
   - Theme introduction (medium)
   - Details expansion (larger)

### Learning Progression
1. Start with basic conversation
2. Demonstrate context building
3. Show memory limitations
4. Allow free experimentation

## User Experience Goals
- Intuitive visualization of AI memory
- Clear demonstration of context limitations
- Engaging party planning scenario
- Simple, non-technical presentation
- Tutorial-guided with freedom to explore 