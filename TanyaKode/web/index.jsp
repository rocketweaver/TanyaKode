<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Welcome to our community!</title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <header class="container">
            <nav>
                <h1 class="logo white-color">
                    Tanya<span class="primary-color bold">Kode</span>
                </h1>
                <ul class="nav-list">
                    <li class="nav-item">
                        <a
                            href="#"
                            rel="noopener noreferrer"
                            class="nav-link underline-hover white-color"
                            >Home</a
                        >
                    </li>
                    <li class="nav-item">
                        <a
                            href="signin.jsp"
                            rel="noopener noreferrer"
                            class="nav-link signin-link"
                            >Signin</a
                        >
                    </li>
                </ul>
            </nav>
        </header>
        <section id="hero" class="container">
            <div id="hero-txt">
                <h1 class="white-color">
                    The place where you can ask anything about codes.
                </h1>
            </div>
        </section>
        <section id="benefits" class="container">
            <div id="benefit-1" class="benefit-card">
                <div class="benefit-content">
                    <img
                        src="icons/iconmonstr-help-1.svg"
                        alt="Question icon"
                        id="people-icon"
                        />
                    <p class="benefit-txt">
                        Finding best answer to your technical question.
                    </p>
                </div>
            </div>
            <div id="benefit-2" class="benefit-card">
                <div class="benefit-content">
                    <img
                        src="icons/iconmonstr-user-29.svg"
                        alt="People icon"
                        class="benefit-icon"
                        />
                    <p class="benefit-txt">Meet new people from various places.</p>
                </div>
            </div>
            <div id="benefit-3" class="benefit-card">
                <div class="benefit-content">
                    <img
                        src="icons/iconmonstr-handshake-3.svg"
                        alt="Handshake icon"
                        class="benefit-icon"
                        />
                    <p class="benefit-txt">Helping people to solving problems.</p>
                </div>
            </div>
        </section>

        <footer class="black-bg container mt-0">
            <p class="white-color">
                &copy;2023, Group 3 - 2WD1. All rights reserved.
            </p>
        </footer>

        <script src="js/blacknav.js"></script>
    </body>
</html>
