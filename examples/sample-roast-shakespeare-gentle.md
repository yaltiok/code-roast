# Example: Shakespeare roasts a simple todo app

## Input code

```javascript
let todos = [];
let id = 1;

function addTodo(text) {
    todos.push({ id: id++, text: text, done: false });
}

function removeTodo(todoId) {
    todos = todos.filter(t => t.id !== todoId);
}

function toggleTodo(todoId) {
    todos.forEach(t => {
        if (t.id === todoId) {
            t.done = !t.done;
        }
    });
}

function getTodos() {
    return todos;
}
```

## Roast output (gentle)

````
    ┌──────────────┐
    │    ⊙ ╭╮ ⊙   │
    │    ╰─══─╯    │
    │   ╭┈┈┈┈╮    │
    │   ┆ 🪶  ┆    │
    │   ╰┈┈┈┈╯    │
    └──────────────┘
  *[BARD nods thoughtfully]*
````

# A SONNET FOR THE HUMBLE TODO

*[Enter BARD, who reads the code with a gentle smile and a slow nod of recognition]*

---

### *Sonnet CDIV — Upon Reviewing a Todo List of Modest Ambition*

A todo list! The poet's first-born child,
The rite of passage every coder takes.
Its logic clear, its structure undefiled —
It adds, removes, and toggles without breaks.

Four functions, each of purpose plain and true,
A filter here, a forEach there — well placed.
The `id` ascends as todos join the queue,
No error thrown, no edge case left unfaced.

And yet — and yet! — the Bard must gently note
Some habits that, if left to grow unchecked,
Shall turn this seedling codebase to a moat
Of tangled state no gardener can correct.

*[BARD sets down the sonnet and speaks plainly]*

---

**On the matter of GLOBAL STATE**

Dear author, thy `todos` and `id` sit naked
In the global scope, exposed to all the world
Like laundry hung upon the castle wall
For every passing function to inspect — or modify.

Today, thy program hath but one todo list.
But tomorrow? Two lists? Three? A list of lists?
Thy globals shall collide like ships in fog,
Each one mutating what the other needs.

'Tis not a sin. 'Tis a seedling of a sin.
Wrap them in a closure, a class, a module —
Give them a home with walls and doors,
That they may live in privacy and peace.

---

**On the matter of MUTATION**

*[BARD gestures to toggleTodo with mild concern]*

Observe thy `toggleTodo`. It walks the array
And MUTATES each todo it finds in place.
`t.done = !t.done` — a flip most direct,
But one that changes the ORIGINAL object.

If ever thou dost pass these todos elsewhere —
To a framework, a renderer, a log —
They shall not know the todo changed beneath them.
The reference stays the same; the truth does not.

Thy `removeTodo` knows better! It uses `filter`,
Creating a NEW array — pure, untouched, clean.
Let `toggleTodo` follow its example:
Return new objects. Let the old ones rest.

---

**On the matter of PERSISTENCE**

*[BARD glances at the browser, then back]*

A todo list that forgets! Refresh the page
And every task dissolves like morning dew.
Thy user adds "Buy milk," "Write tests," "Call Mum" —
Then closes the tab and all three fade to void.

A `localStorage` call, a JSON stringify —
'Twould take but four lines more to grant thy todos
The gift of memory, the grace of permanence,
The simple dignity of surviving a reload.

---

**On the matter of RETURNING THE ORIGINAL**

`getTodos` returns the array itself —
Not a copy, not a slice, but the VERY array.
Any caller may `.push()`, `.pop()`, `.splice()` at will,
Bypassing `addTodo` and `removeTodo` entirely.

'Tis like posting a guard at the castle gate
But leaving the back door wide open
With a sign that reads "TODOS THIS WAY."

Return a copy. `return [...todos]`. Done.
The gate and the door shall both be guarded.

---

*[BARD picks up the quill once more]*

### *The Closing Couplet*

But soft — this code doth work! It runs! It lives!
And working code is more than most folk gives.

*[BARD smiles]*

Thou hast a foundation, dear author. 'Tis small,
'Tis humble, 'tis a cottage, not a hall.
But cottages, with care, become estates —
And todo apps become the tools of fates.

Add a module boundary. Embrace immutability.
Save to storage. Guard thy references.
And this modest script shall grow
Into something even the Bard would proudly show.

*[BARD exits with an encouraging nod, leaving the quill behind as a gift]*
