# Vim Motions Cheatsheet  

## 1. Basic Cursor Movement (Daily Essentials)
| Motion   | Description                              | Keystrokes    | Usage Frequency |
|----------|------------------------------------------|---------------|-----------------|
| `h j k l`| ← ↓ ↑ →                                  | h j k l       | ★★★★★          |
| `w`      | Forward to beginning of next word        | w             | ★★★★★          |
| `b`      | Backward to beginning of previous word   | b             | ★★★★★          |
| `e`      | Forward to end of current/next word      | e             | ★★★★☆          |
| `W B E`  | Same as w/b/e but treating punctuation as part of word (WORD) | W B E | ★★★★☆          |

## 2. Line Navigation
| Motion   | Description                              | Keystrokes    | Usage Frequency |
|----------|------------------------------------------|---------------|-----------------|
| `0`      | Beginning of line                        | 0             | ★★★★☆          |
| `^`      | First non-blank character of line        | ^             | ★★★★           |
| `$`      | End of line                              | $             | ★★★★           |
| `g_`     | Last non-blank character of line         | g_            | ★☆             |

## 3. Vertical / Document Navigation
| Motion   | Description                              | Keystrokes    | Usage Frequency |
|----------|------------------------------------------|---------------|-----------------|
| `gg`     | First line of file                       | gg            | ★★★★           |
| `G`      | Last line of file                        | G             | ★★★★           |
| `{` `}`  | Previous/next paragraph                  | { }           | ★★★☆           |
| `Ctrl-u` | Half page up                             | Ctrl+u        | ★★             |
| `Ctrl-d` | Half page down                           | Ctrl+d        | ★★             |
| `Ctrl-f` | Full page forward                        | Ctrl+f        | ★★             |
| `Ctrl-b` | Full page backward                       | Ctrl+b        | ★★             |

## 4. Character & Search Based Motions (Very Powerful)
| Motion   | Description                              | Keystrokes    | Usage Frequency |
|----------|------------------------------------------|---------------|-----------------|
| `f{char}`| Jump forward to next occurrence of {char}| f             | ★★★            |
| `F{char}`| Jump backward to previous {char}         | F             | ★★★            |
| `t{char}`| Jump forward till before {char}          | t             | ★★★            |
| `T{char}`| Jump backward till after {char}          | T             | ★★★            |
| `;`      | Repeat last f/t forward                  | ;             | ★★★            |
| `,`      | Repeat last f/t backward                 | ,             | ★★★            |
| `/`      | Search forward                           | /             | ★★★            |
| `?`      | Search backward                          | ?             | ★★★            |
| `n`      | Next search match                        | n             | ★★★            |
| `N`      | Previous search match                    | N             | ★★★            |
| `*`      | Search forward for word under cursor     | *             | ★★☆            |
| `#`      | Search backward for word under cursor    | #             | ★★☆            |

## 5. Structure & Matching Motions
| Motion   | Description                              | Keystrokes    | Usage Frequency |
|----------|------------------------------------------|---------------|-----------------|
| `%`      | Jump to matching bracket/paren/brace     | %             | ★★☆            |
| `[{`     | Previous unmatched {                     | [{            | ★☆             |
| `]}`     | Next unmatched }                         | ]}            | ★☆             |

## 6. Screen Position & Scrolling
| Motion   | Description                              | Keystrokes    | Usage Frequency |
|----------|------------------------------------------|---------------|-----------------|
| `H`      | Top of screen                            | H             | ★★             |
| `M`      | Middle of screen                         | M             | ★★             |
| `L`      | Bottom of screen                         | L             | ★★             |
| `zt`     | Scroll current line to top of screen     | zt            | ★☆             |
| `zz`     | Scroll current line to center            | zz            | ★☆             |
| `zb`     | Scroll current line to bottom            | zb            | ★☆             |

## 7. Position History & Marks
| Motion   | Description                              | Keystrokes    | Usage Frequency |
|----------|------------------------------------------|---------------|-----------------|
| ``       | Back to position before last jump        | ``            | ★☆             |
| `gi`     | Go to last insert position               | gi            | ★★             |
| ``.`     | Go to last change position               | `.            | ★☆             |
| `g;`     | Previous change in change list           | g;            | ★☆             |
| `g,`     | Next change in change list               | g,            | ★☆             |
| `Ctrl-o` | Backward in jump list                    | Ctrl+o        | ★☆             |
| `Ctrl-i` | Forward in jump list                     | Ctrl+i        | ★☆             |

## Most Useful Text Object + Motion Combos (Operator + Motion)
These are what make Vim powerful in practice:

```vim
ciw        # change inner word          (extremely common)
ci" ci'    # change inside quotes
di( di)    # delete inside/outside parens
yi{        # yank inside block
dap        # delete a paragraph
yap        # yank a paragraph
df)        # delete forward to )
dt,        # delete till comma
