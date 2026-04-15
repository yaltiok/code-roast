# Example: Gentle Grandma roasts terrible variable naming

## Input code

```python
def f(a, b, c):
    d = []
    for e in a:
        if e.g > b:
            h = e.g * c
            if h > 100:
                d.append((e, h))
    d.sort(key=lambda x: x[1], reverse=True)
    return d[:10]

def proc(xx):
    r = []
    for i in range(len(xx)):
        tmp = xx[i]
        tmp2 = tmp.split('|')
        r.append({'n': tmp2[0], 'v': tmp2[1], 'flg': tmp2[2] == '1'})
    return r
```

## Roast output (savage)

````
        ┌─────────────────────────┐
        │      ◉         ◉       │
        │        ╰──▄──╯         │
        │    ╭┈┈┈┈┈┈┈┈┈┈┈┈╮     │
        │    ┆  WHAT IS    ┆     │
        │    ┆    'f' ???   ┆     │
        │    ╰┈┈┈┈┈┈┈┈┈┈┈┈╯     │
        │                         │
        │   ┌──────────────────┐  │
        │   │ a? b? c? d? e?  │  │
        │   │  THIS ISN'T     │  │
        │   │  ALGEBRA CLASS  │  │
        │   └──────────────────┘  │
        └─────────────────────────┘
       *puts down knitting needles*
        *picks up the telephone*
````

Sweetheart... sit down. Put on a sweater, you look cold. Now let me look at this code you wrote.

1. **What does `f` do, honey?** The function is called `f`. Just the letter `f`. I'm 78 years old and even I name my cookie recipes better than this. My snickerdoodle recipe is called "Grandma's Snickerdoodle Surprise" — not "Recipe F." Your function takes `a`, `b`, and `c`. What ARE these? Are they ingredients? Are they people? Are they coordinates to a secret treasure? Because reading this code is certainly not leading me to any treasure. It's leading me to a migraine.

2. **`d`, `e`, `g`, `h`...** Sweetheart, this isn't a game of Scrabble. You've used more single letters than a bowl of alphabet soup. I went through the whole function and the only thing I learned is that something called `e` has a property called `g` that gets multiplied by `c` to make `h`, and if `h` is big enough it goes into `d`. Do you know what that sentence sounds like? NONSENSE. It sounds like nonsense, dear. I had to read it four times and I still don't know if this calculates taxes, filters products, or ranks your dating profiles.

3. **And then there's `proc`...** "Proc." Short for what? Procedure? Processing? Procrastination? Because that's what you were clearly doing when it came time to name things properly. Inside you have `xx`, `r`, `tmp`, and `tmp2`. TEMPORARY? If everything is temporary, what is PERMANENT, honey? What can I hold onto? Your cousin Kevin — and I hate to compare, but I will — Kevin names his variables `parsedUserRecords` and `rawInputLines`. You know what Kevin doesn't have? A grandmother lying awake at 2 AM wondering what `flg` stands for.

4. **`'n'`, `'v'`, `'flg'`...** You're building a dictionary with keys that look like someone fell asleep on the keyboard. Is `'n'` a name? A number? A note? Is `'v'` a value, a version, a vegetable? And `'flg'` — oh, `'flg'`. You couldn't even spare two more letters for `'flag'`? Were you being charged per character? Was there a vowel shortage that day?

5. **`for i in range(len(xx))`...** Honey, this is Python, not C from 1989. You can just write `for item in xx`. But I suppose that would require calling it something other than `xx`, and we've established that naming things is... not our strength today.

I love you unconditionally. But I am calling your mother. And I'm forwarding her this code. And I'm going to tell her that you named a variable `tmp2` in production, and she can decide what to do about it. I raised her better than this, which means she raised YOU better than this.

Your cousin Kevin sends his regards. He just got promoted.
