# Example: Shakespeare roasts terrible CSS

## Input code

```css
.container {
    width: 100%;
    max-width: 100%;
    min-width: 100%;
    margin: 0px 0px 0px 0px;
    padding: 0px 0px 0px 0px;
    position: relative;
    display: block;
    float: left;
    clear: both;
    overflow: hidden;
    z-index: 9999;
}

.container .inner {
    width: 100% !important;
    margin: auto !important;
    padding: 10px !important;
    position: absolute !important;
    top: 0 !important;
    left: 0 !important;
    z-index: 99999 !important;
}

.container .inner .content {
    z-index: 999999;
    position: fixed;
}
```

## Roast output (savage)

````
    ┌──────────────┐
    │    ◉ ▄▄ ◉   │
    │    ╰════╯    │
    │  ╱╭┈┈┈┈╮╲   │
    │   ┆ 🪶  ┆    │
    │   ╰┈┈┈┈╯    │
    └──────────────┘
  *[BARD snaps quill in half]*
````

# THE TRAGEDIE OF Z-INDEX: A TALE OF SPECIFICITY AND SORROW

### *In which a stylesheet doth declare war upon itself, and !important is the only casualty*

---

**ACT I — THE REDUNDANCY**

*[Enter CONTAINER, draped in properties that say the same thing seven different ways]*

What light through yonder stylesheet breaks?
'Tis `width: 100%` — and `max-width: 100%` is the sun!
And lo, `min-width: 100%` rises from the east
To join its brethren in the most redundant dawn
That CSS hath ever witnessed!

THREE declarations, all to say one thing:
"Be wide." BE WIDE! As if the element,
Upon hearing `width: 100%`, might rebel
And shrink itself to spite thee! Nay, the author
Wrote a CAGE of widths — a minimum, a maximum,
And the thing itself — lest the div dream of freedom.

And `margin: 0px 0px 0px 0px`! FOUR ZEROES!
Four! Written longhand! With units on zero!
Thou dost know that zero pixels equals zero em
Equals zero rem equals ZERO?! Zero needs
No unit, for NOTHING requires no measurement!
'Tis like saying "I have zero gallons
Of zero liters of zero cups of nothing."
We UNDERSTOOD at zero!

*[Aside]* I wrote Hamlet in fewer words than this container uses to say "take up space."

---

**ACT II — THE CONTRADICTIONS**

*[The stage splits. RELATIVE and FLOAT enter from opposite sides. BLOCK stands confused in the middle.]*

Now mark this well, for here the plot thickens
Into a stew of incompatible intentions:

`position: relative` — the element stays in flow!
`display: block` — aye, 'tis block by default, thou GENIUS!
A div is block! Declaring it so is like
Announcing to the court: "THE KING IS THE KING!"
We KNOW! HE'S WEARING THE CROWN!

But THEN — `float: left`!
The element leaves the flow it just declared!
And `clear: both`! It clears the float it just created!
Thou art floating LEFT whilst clearing BOTH —
'Tis a ship that launches and docks simultaneously,
A horse that gallops forth and reins itself,
A playwright who writes ACT I and FINIS on the same page!

And `overflow: hidden` — to clip the chaos
That these contradictions shall surely birth.
'Tis not a style rule — 'tis a COVER-UP.

---

**ACT III — THE IMPORTANT WARS**

*[Thunder. Lightning. Enter INNER, brandishing seven !important declarations like daggers.]*

*[BARD staggers backward]*

Seven. SEVEN declarations marked `!important`.
Not one. Not two. Not a desperate three.
SEVEN. Every single property SCREAMS
At the browser with the fury of a tyrant
Who ends every sentence with "AND I MEAN IT!"

`width: 100% !important` — thou already said 100%!
`margin: auto !important` — WHOM art thou overriding?!
`padding: 10px !important` — what dark force compels
Ten pixels to require nuclear authority?!

*[BARD reads aloud, growing more horrified]*

`position: absolute !important` — INSIDE a relative parent
That floats left and clears both! The absolute child
Hath now divorced itself from a parent
Who was ALREADY having an identity crisis!

And `top: 0 !important` and `left: 0 !important` —
Pinned to the corner with the desperation
Of a student pinning their essay to the door
Of a professor who retired three years hence!

This is not CSS. This is a HOSTAGE NEGOTIATION.
Every `!important` is a ransom note that reads:
"I do not understand the cascade. I REFUSE to understand the cascade.
I shall BRUTE FORCE my way to visual correctness
And future developers shall WEEP."

---

**ACT IV — THE Z-INDEX ESCALATION**

*[A tower is wheeled onto stage, stretching into the heavens. On each level, a number grows.]*

Now we arrive at the crown jewel of this catastrophe.
The z-index. O, the z-index!

The container: `z-index: 9999`.
Nine thousand, nine hundred, and ninety-nine.
A number so large it suggests the author
Hath fought z-index battles before — and LOST.
For no one starts at 9999. Nay.
One starts at 1. Then 2. Then 10. Then 100.
Then 999. Then 9999. Each escalation
A scar from a war against a dropdown menu
Or a modal that refused to sit above the header.

The inner: `z-index: 99999`.
*[BARD's eye twitches]*
NINETY-NINE THOUSAND. To sit above its parent.
Its OWN parent! A child demanding to be
Stacked above the one who CONTAINS it!
This is not a z-index — this is an ARMS RACE.

And THEN — O, THEN — the content:

`z-index: 999999`.

*[BARD falls to knees]*

NINE HUNDRED AND NINETY-NINE THOUSAND,
NINE HUNDRED AND NINETY-NINE.

What light through yonder z-index breaks?
'Tis 999999, and !important is the sun!
But soft! What z-index through yonder window breaks?
It is the NEXT DEVELOPER, who shall need 9999999
To place a TOOLTIP above this monstrosity!

---

**ACT V — THE POSITION: FIXED**

*[Silence falls. A single spotlight on CONTENT, who stands motionless while the world scrolls past.]*

And now, the final betrayal.

The container is `relative`.
The inner is `absolute` — torn from flow, pinned to its parent.
The content is... `fixed`.

FIXED.

*[BARD stares into the void]*

Fixed to the VIEWPORT. Not to the container.
Not to the inner. To the WINDOW ITSELF.
This element hath looked upon its parent,
Looked upon its grandparent, and said:
"I know NEITHER of you. I answer to the BROWSER."

Three generations. Three positioning contexts.
`relative` begat `absolute` begat `fixed` —
A lineage of escalating detachment,
A family tree where each generation
Moves FURTHER from its roots!

'Tis the CSS equivalent of a child
Who leaves home, then leaves the country,
Then leaves the PLANET.

*[BARD addresses the audience, exhausted]*

Let the epitaph of this stylesheet read:

> *"Here lies a container that contained nothing,*
> *an inner that was outermost,*
> *and content fixed to naught but the developer's tears."*

I have seen tragedies. I have WRITTEN tragedies.
But never — NEVER — have I seen a tragedy
Where the villain, the victim, and the fool
Were all the same stylesheet.

Rewrite it. Burn it. Salt the earth where it was hosted.
And may God have mercy on the specificity graph.

*[Exeunt omnes. The z-index counter continues climbing in the darkness. It never stops.]*

**-- FINIS --**
